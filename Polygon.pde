//------ POLYGON ------//
class Polygon{
  int npoints,nsegments;
  Point[] points = new Point[1000];
  Segment[] segments = new Segment[1000];
  Point centroid;
  Polygon(Point[] $points){
    npoints = nsegments = 0;
    for(int i=0;i<$points.length;i++){
      if($points[i]==null) break;
      add_point($points[i]);
    }
  }
  Polygon(){
    npoints = nsegments = 0;
  }
  void reset(){
    for(int i=0;i<nsegments;i++){
      segments[i].reset();
    }
  }
  void rotate(float $a,String $axis){
    float cosa = cos($a);
    float sina = sin($a);
    centroid = get_centroid_point();
    for(int i=0;i<npoints;i++){
      points[i].rotate(cosa,sina,$axis,centroid.x,centroid.y,centroid.z);
    }
  }
  void add_point(Point $p){
    for(int i=0;i<npoints;i++){
      if($p.get_distance_to(points[i].x,points[i].y,points[i].z)<=global.distance_tolerance){ return; }
    }
    points[npoints++] = $p;
    if(npoints>2){
      if(npoints==3){
        //create first closing segment
        segments[nsegments] = new Segment(points[npoints-2],points[npoints-1]);
        segments[nsegments+1] = new Segment(points[npoints-1],points[0]);
        nsegments += 2;
      }else{
        //replace closing segment
        segments[nsegments-1] = new Segment(points[npoints-2],points[npoints-1]);
        segments[nsegments++] = new Segment(points[npoints-1],points[0]);
      }
    }else if(npoints>1){
      segments[nsegments++] = new Segment(points[npoints-2],points[npoints-1]);
    }
  }
  void insert_point(Point $p,Point $after){
    //this is not an efficient way to insert points, just the easiest
    int ntemp = npoints;
    Point[] temp = new Point[1000];
    arraycopy(points,temp);
    points = new Point[1000];
    npoints = 0;
    nsegments = 0;
    for(int i=0;i<ntemp;i++){
      add_point(temp[i]);
      if(temp[i]==$after){ add_point($p); }
    }
  }
  void delete_point(Point $p){
    //this is not an efficient way to remove points, just the easiest :: for reducing lots of large polygons, this should target only the segment to be removed, rather than rebuilding the entire polygon
    int ntemp = npoints;
    Point[] temp = new Point[1000];
    arraycopy(points,temp);
    points = new Point[1000];
    npoints = 0;
    nsegments = 0;
    for(int i=0;i<ntemp;i++){
      if(temp[i]!=$p){
        add_point(temp[i]);
      }
    }
  }
  Polygon get_bounding_box(){
    //xy coordinates only
    float xmin = 9999; float ymin = 9999; float xmax = -9999; float ymax = -9999;
    for(int i=0;i<npoints;i++){
      xmin = min(points[i].x,xmin);
      ymin = min(points[i].y,ymin);
      xmax = max(points[i].x,xmax);
      ymax = max(points[i].y,ymax);
    }
    Point[] ps = new Point[4]; ps[0] = new Point(xmin,ymin,0); ps[1] = new Point(xmax,ymin,0); ps[2] = new Point(xmax,ymax,0); ps[3] = new Point(xmin,ymax,0);
    return new Polygon(ps);
  }
  void simplify(){
    //xy coordinates only
    if(nsegments>2){
      for(int i=0;i<nsegments;i++){
        if(segments[i].get_length()<global.simplify_distance_tolerance||abs(segments[i].get_slope()-segments[(i+1)%nsegments].get_slope())<global.simplify_slope_tolerance){
          delete_point(points[(i+1)%npoints]);
          simplify();
          break;
        }
      }
    }
  }
  void densify(float $d){
    for(int i=0;i<nsegments;i++){
      if(segments[i].get_length()>$d){
        insert_point(segments[i].get_midpoint(),segments[i].p1);
        densify($d);
        break;
      }
    }
  }
  boolean is_complex(){
    //xy coordinates only
    if(npoints!=nsegments){ return true; }
    for(int i=0;i<nsegments;i++){
      for(int j=i+1;j<nsegments;j++){
        if(j==i+1||j==(i+nsegments-1)%nsegments){
          if(segments[i].is_segment_intersecting(segments[j],false)){ return true; }
        }else{
          if(segments[i].is_segment_intersecting(segments[j],true)){ return true; }
        }
      }
    }
    return false;
  }
  boolean is_coord_inside(float $x,float $y){
    //xy coordinates only :: this technique is slower but more accurate than the ray intersection method :: this checks the sum of the angles between all point pairs and the tested point
    float a1,a2;
    float a = 0;
    for(int i=0;i<nsegments;i++){
      a1 = atan2(segments[i].p1.y-$y,segments[i].p1.x-$x);
      a2 = atan2(segments[i].p2.y-$y,segments[i].p2.x-$x);
      a += (a2-a1+5*PI)%TWO_PI-PI; //make sure a falls between -pi and pi
    }
    if(abs(a)+global.angle_tolerance<PI){ return false; }
    return true;
  }
  boolean is_polygon_inside(Polygon $po){
    //xy coordinates only
    for(int i=0;i<npoints;i++){
      if(!is_coord_inside(points[i].x,points[i].y)){ return false; }
    }
    return true;
  }
  boolean is_polygon_intersecting(Polygon $po){
    //xy coordinates only
    for(int i=0;i<nsegments;i++){
      for(int j=0;j<nsegments;j++){
        if(segments[i].is_segment_intersecting(segments[j],true)){ return true; }
      }
    }
    if(is_polygon_inside(this)){ return true; }
    if(is_polygon_inside($po)){ return true; }
    return false;
  }
  boolean is_splittable(Line $l){
    //xy coordinates only
    if(is_complex()){ return false; }
    int ints = 0;
    for(int i=0;i<npoints;i++){
      if($l.is_coord_on(points[i].x,points[i].y,0)){
        ints++;
      }else if(segments[i].is_line_intersecting($l,false)){
        ints++;
      }
    }
    if(ints==2){ return true; }
    return false;
  }
  float get_distance_to(float $x,float $y,float $z){
    float d = segments[0].get_distance_to($x,$y,$z);
    for(int i=1;i<nsegments;i++){
      float temp = segments[i].get_distance_to($x,$y,$z);
      if(temp<d){ d = temp; }
    }
    return d;
  }
  float get_signed_area(){
    //xy coordinates only :: this method of calculating the area will return a signed value: negative means counterclockwise orientation, positive means clockwise :: the signed area is needed for the centroid calculation
    if(is_complex()){ return 0; }
    float a = 0;
    for(int i=0;i<npoints;i++){
      a += points[i].x*points[(i+1)%npoints].y-points[(i+1)%npoints].x*points[i].y;
    }
    return (a*0.5);
  }
  float get_area(){
    //xy coordinates only
    return abs(get_signed_area());
  }
  float get_width(){
    float xmin = 9999; float xmax = -9999;
    for(int i=0;i<npoints;i++){
      xmin = min(points[i].x,xmin);
      xmax = max(points[i].x,xmax);
    }
    return (xmax-xmin);
  }
  float get_height(){
    float ymin = 9999; float ymax = -9999;
    for(int i=0;i<npoints;i++){
      ymin = min(points[i].y,ymin);
      ymax = max(points[i].y,ymax);
    }
    return (ymax-ymin);
  }
  Point get_closest_point(float $x,float $y,float $z){
    //xy coordinates only
    float temp,d; Point p;
    d = segments[0].get_distance_to($x,$y,$z);
    p = segments[0].get_closest_point($x,$y,$z);
    for(int i=1;i<nsegments;i++){
      temp = segments[i].get_distance_to($x,$y,$z);
      if(temp<d){
        d = temp;
        p = segments[i].get_closest_point($x,$y,$z);
      }
    }
    return p;
  }
  Point get_points_centroid_point(){
    //this retrieves the centroid of the points that compose the polygon, not the centroid of the polygon! :: they're not the same thing, it's a cruel world
    float cx = 0; float cy = 0; float cz = 0;
    for(int i=0;i<npoints;i++){
      cx += points[i].x; cy += points[i].y; cz += points[i].z;
    }
    cx /= npoints; cy /= npoints; cz /= npoints;
    Point p = new Point(cx,cy,cz);
    return p;
  }
  Point get_centroid_point(){
    //xy coordinates only
    float a = get_signed_area();
    if(a==0){ return global.error_point; }
    float cx = 0; float cy = 0;
    for(int i=0;i<npoints;i++){
      float temp = points[i].x*points[(i+1)%npoints].y-points[(i+1)%npoints].x*points[i].y;
      cx += (points[i].x+points[(i+1)%npoints].x)*temp;
      cy += (points[i].y+points[(i+1)%npoints].y)*temp;
    }
    cx /= a*6; cy /= a*6;
    return new Point(cx,cy,0);
  }
  Polygon get_convex_hull(){
    if(npoints<4) return this;
    //xy coordinates only :: returns the convex hull for this polygon's set of points :: this is a relatively costly function as it is scripted here
    float a,d;
    int ip = 0; int ntemp = 0; Point[] temp = new Point[npoints]; float[] as = new float[npoints]; float[] ds = new float[npoints];
    //find the topmost point
    for(int i=1;i<npoints;i++){
      if(points[i].y<points[ip].y){ ip = i; }
    }
    //if two points are colinear with the topmost point, take only the one furthest away
    for(int i=0;i<npoints;i++){
      if(i!=ip){
        a = (atan2(points[ip].y-points[i].y,points[ip].x-points[i].x)+PI)%TWO_PI;
        d = dist(points[ip].x,points[ip].y,points[i].x,points[i].y);
        if(d>0){
          boolean found = false;
          for(int j=0;j<ntemp;j++){
            if(a==as[j]){
              if(d>ds[j]){
                //remove the closer point
                Point[] temp1 = (Point[]) subset(temp,0,j); Point[] temp2 = (Point[]) subset(temp,j+1,temp.length-(j+1)); temp = (Point[]) concat(temp1,temp2);
                float[] as1 = subset(as,0,j); float[] as2 = subset(as,j+1,temp.length-(j+1)); as = concat(as1,as2);
                float[] ds1 = subset(ds,0,j); float[] ds2 = subset(ds,j+1,temp.length-(j+1)); ds = concat(ds1,ds2);
                ntemp--; j--;
              }else{
                //skip this point
                found = true;
                break;
              }
            }
          }
          if(!found){
            //add point to array
            temp[ntemp] = points[i]; as[ntemp] = a; ds[ntemp++] = d;
          }
        }
      }
    }
    //bubble sort the arrays according to angle
    for(int i=0;i<ntemp-1;i++){
      for(int j=0;j<ntemp-1-i;j++){
        if(as[j]>as[j+1]){
          Point temp1 = temp[j]; temp[j] = temp[j+1]; temp[j+1] = temp1;
          float as1 = as[j]; as[j] = as[j+1]; as[j+1] = as1;
        }
      }
    }
    temp[ntemp++] = points[ip];
    temp = (Point[]) subset(temp,0,ntemp);
    temp = (Point[]) reverse(temp);
    //find convex hull points
    if(ntemp>3){
      for(int i=0;i<ntemp;i++){
        float pbside = (temp[(i+1+ntemp)%ntemp].y-temp[(i+ntemp)%ntemp].y)*(temp[(i+2+ntemp)%ntemp].x-temp[(i+ntemp)%ntemp].x)-(temp[(i+1+ntemp)%ntemp].x-temp[(i+ntemp)%ntemp].x)*(temp[(i+2+ntemp)%ntemp].y-temp[(i+ntemp)%ntemp].y);
        if(pbside<0){
          //remove the point if it lies on the wrong side
          if((i+1+ntemp)%ntemp==0){
            temp = (Point[]) subset(temp,1,ntemp-1);
          }else if((i+1+ntemp)%ntemp==ntemp-1){
            temp = (Point[]) subset(temp,0,ntemp-1);
          }else{
            Point[] temp1 = (Point[]) subset(temp,0,(i+1+ntemp)%ntemp);
            Point[] temp2 = (Point[]) subset(temp,(i+2+ntemp)%ntemp,ntemp-(i+2+ntemp)%ntemp);
            temp = (Point[]) concat(temp1,temp2);
          }
          i -= 2; ntemp--;
          temp = (Point[]) subset(temp,0,ntemp);
        }
      }
    }
    //return new polygon
    //temp = (Point[]) subset(temp,0,ntemp);
    Polygon po = new Polygon(temp);
    po.simplify();
    return po;
  }
  Polygon get_outline(float $cohesion_distance){
    if(npoints<4) return this;
    float a,mina;
    Vector v,ov;
    int n = 0; int active = 0; int next = 0; int previous = 0; int ip = 0; int ntemp = 0; Point[] temp = new Point[npoints]; float cosa = cos(-PI+0.001); float sina = sin(-PI+0.001);
    //find the topmost point
    for(int i=0;i<npoints;i++){
      if(points[i].y<points[ip].y){ ip = i; }
    }
    active = ip;
    ov = new Vector(-100,0.001,0);
    v = new Vector(0,0,0);
    mina = 9999;
    //repeat until we hit the topmost point again
    while((active!=ip||n==0)&&n<100){
      mina = 9999;
      for(int j=0;j<npoints;j++){
        if(j!=active&&points[active].get_distance_to(points[j])<=$cohesion_distance){
          v.vx = points[j].x-points[active].x; v.vy = points[j].y-points[active].y;
          a = atan2(-ov.vy*v.vx+ov.vx*v.vy,ov.vx*v.vx+ov.vy*v.vy);
          if(a<0) a += TWO_PI;
          if(a<mina){
            mina = a;
            next = j;
          }
        }
      }
      ov.vx = points[next].x-points[active].x; ov.vy = points[next].y-points[active].y;
      ov.rotate(cosa,sina,"z");
      if(next==previous) return this;
      previous = active;
      active = next;
      temp[ntemp++] = points[active];
      n++;
    }
    //temp = (Point[]) subset(temp,0,ntemp);
    return new Polygon(temp);
  }
  Polygon[] split(Line $l){
    //xy coordinates only :: must test to make sure it is a simple polygon first or you'll get strange results
    int ip = 0; Point[] ints = new Point[npoints]; float[] intsi = new float[npoints+2]; int nints = 0; Point[] temp1 = new Point[npoints+2]; float[] temp1i = new float[npoints+2]; int ntemp1 = 0; Point[] temp2 = new Point[npoints+2]; int ntemp2 = 0;
    for(int i=0;i<npoints;i++){
      if($l.is_coord_on(points[i].x,points[i].y,0)){
        ints[nints] = points[i]; intsi[nints++] = i;
        temp1[ntemp1] = points[i]; temp1i[ntemp1++] = i;
        ip = i;
      }else if(segments[i].is_line_intersecting($l,false)){
        Point lint = $l.s.get_intersect_point(segments[i]);
        ints[nints] = lint; intsi[nints++] = i+0.5;
        if(nints%2==0){ temp1[ntemp1] = points[i]; temp1i[ntemp1++] = i; }
        temp1[ntemp1] = lint; temp1i[ntemp1++] = i+0.5; 
        ip = i;
      }else if(nints%2==1){
        temp1[ntemp1] = points[i]; temp1i[ntemp1++] = i;
      }
    }
    for(int i=ip;i<ip+npoints;i++){
      boolean found = false;
      for(int j=0;j<ntemp1;j++){
        if(i%npoints==temp1i[j]){ found = true; break; }
      }
      if(!found){ temp2[ntemp2++] = points[i%npoints]; }
    }
    temp2[ntemp2] = new Point(0,0,0); temp2[ntemp2++].match(ints[0]);
    temp2[ntemp2] = new Point(0,0,0); temp2[ntemp2++].match(ints[1]);
    //temp1 = (Point[]) subset(temp1,0,ntemp1);
    //temp2 = (Point[]) subset(temp2,0,ntemp2);
    Polygon po1 = new Polygon(temp1);
    Polygon po2 = new Polygon(temp2);
    Polygon[] pos = {po1,po2};
    return pos;
  }
  void render(){
    if(npoints<3) return;
    pg.beginShape();
    for(int i=0;i<npoints;i++){
      pg.vertex(points[i].x,points[i].y,points[i].z);
    }
    pg.endShape(CLOSE);
    /*
    for(int i=0;i<npoints;i++){
      points[i].render();
    }
    */
  }
  void render(String $type){
    if(npoints<3) return;
    pg.beginShape();
    if($type=="line"){
      for(int i=0;i<npoints;i++){
        pg.vertex(points[i].x,points[i].y,points[i].z);
      }
    }else if($type=="curve"){
      pg.curveTightness(-0.8);
      pg.curveVertex(points[npoints-1].x,points[npoints-1].y,points[npoints-1].z);
      for(int i=0;i<npoints;i++){
        pg.curveVertex(points[i].x,points[i].y,points[i].z);
      }
      pg.curveVertex(points[0].x,points[0].y,points[0].z);
      pg.curveVertex(points[1].x,points[1].y,points[1].z);
    }else if($type=="bezier"){
      pg.vertex((points[npoints-1].x+points[0].x)/2,(points[npoints-1].y+points[0].y)/2,(points[npoints-1].z+points[0].z)/2);
      for(int i=0;i<npoints;i++){
        pg.bezierVertex(points[i].x,points[i].y,points[i].z,points[i].x,points[i].y,points[i].z,(points[(i+1)%npoints].x+points[i].x)/2,(points[(i+1)%npoints].y+points[i].y)/2,(points[(i+1)%npoints].z+points[i].z)/2);
      }
    }
    pg.endShape(CLOSE);
    /*
    for(int i=0;i<npoints;i++){
      points[i].render();
    }
    */
  }
  void render(PImage $img,float $s){
    if(npoints<3) return;
    pg.beginShape();
    pg.texture($img);
    for(int i=0;i<npoints;i++){
      pg.vertex(round(points[i].x),round(points[i].y),round(points[i].z),round($s*(points[i].x+global.w/2)),round($s*(points[i].y+global.h/2)));
    }
    pg.endShape(CLOSE);
  }
}
/*
  boolean is_coord_inside(float $x,float $y){
    //xy coordinates only :: this technique has a shortcoming :: when the point tested aligns vertically with either the topmost or bottommost point of the polygon, the tested point is said to lie inside, when in reality, it must be outside
    int ints = 0;
    for(int i=0;i<nsegments;i++){
      if(segments[i].is_ray_intersecting($x,$y,true)){
        ints++;
      }
    }
    if(ints%2==0){ return false; }
    return true;
  }
  boolean is_coord_inside(float $x,float $y){
    //xy coordinates only :: this is an alternative to the angle sum method :: it uses the dot product and only one acos calc, but seems to run slower than the atan method, probably due to the creation of the vector objects
    Vector v1 = new Vector(0,0,0);
    Vector v2 = new Vector(0,0,0);
    float a = 0;
    for(int i=0;i<nsegments;i++){
      v1.vx = segments[i].p1.x-$x; v1.vy = segments[i].p1.y-$y; v1.unitize();
      v2.vx = segments[i].p2.x-$x; v2.vy = segments[i].p2.y-$y; v2.unitize();
      a += acos(dot_product(v1,v2));
    }
    if(abs(a-TWO_PI)<global.angle_tolerance){ return true; }
    return false;
  }
  */
