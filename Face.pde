//------ FACE ------//
class Face extends Polygon{
  Point p1,p2,p3,icp,ccp;;
  Plane pl;
  float ccr;
  Face(Point[] $points){
    super($points);
    p1 = $points[0]; p2 = $points[1]; p3 = $points[2];
    pl = new Plane(p1,p2,p3);
    icp = get_incenter_point();
    ccp = get_circumcenter_point();
    ccr = get_circumcircle_radius();
  }
  void orient(Point $p){
    if(pl.get_point_side($p)>0){
      flip();
    }
  }
  void flip(){
    Point temp = p2;
    p2 = p3; p3 = temp;
  }
  boolean is_acute(){
    float d1,d2,d3,x,h,y,a1,a2,a3;
    d1 = p1.get_distance_to(p2); d2 = p2.get_distance_to(p3); d3 = p3.get_distance_to(p1);
    x = (sq(d1)+sq(d2)-sq(d3))/(2*d2); h = sqrt(sq(d1)-sq(x)); y = d2-x;
    a1 = (atan(h/x)+PI)%PI; a2 = (atan(h/y)+PI)%PI; a3 = PI-(a1+a2);
    if(a1<HALF_PI&&a2<HALF_PI&&a3<HALF_PI){ return true; }
    return false;
  }
  float get_circumcircle_radius(){
    return ccp.get_distance_to(p1);
  }
  Point get_incenter_point(){
    float d1,d2,d3; Point p;
    d1 = p2.get_distance_to(p3); d2 = p3.get_distance_to(p1); d3 = p1.get_distance_to(p2);
    return new Point(((d1*p1.x)+(d2*p2.x)+(d3*p3.x))/(d1+d2+d3),((d1*p1.y)+(d2*p2.y)+(d3*p3.y))/(d1+d2+d3),((d1*p1.z)+(d2*p2.z)+(d3*p3.z))/(d1+d2+d3));
  }
  Point get_circumcenter_point(){
    Vector p12,p23,n12,n23; Point mid12,mid23; Line l12,l23; Segment s;
    pl.nv = pl.get_normal();
    p12 = new Vector(p2.x-p1.x,p2.y-p1.y,p2.z-p1.z); p23 = new Vector(p3.x-p2.x,p3.y-p2.y,p3.z-p2.z);
    n12 = cross_product(pl.nv,p12); n23 = cross_product(pl.nv,p23);
    mid12 = new Point((p2.x+p1.x)/2,(p2.y+p1.y)/2,(p2.z+p1.z)/2); mid23 = new Point((p3.x+p2.x)/2,(p3.y+p2.y)/2,(p3.z+p2.z)/2);
    l12 = new Line(mid12,new Point(mid12.x+n12.vx,mid12.y+n12.vy,mid12.z+n12.vz));
    l23 = new Line(mid23,new Point(mid23.x+n23.vx,mid23.y+n23.vy,mid23.z+n23.vz));
    return l12.get_segment_to_line(l23).p1;
  }
  boolean is_point_inside_circumcircle(Point $p){
    if(ccp.get_distance_to($p)<=ccr){ return true; }
    return false;
  }
  boolean is_line_intersecting(Line $l){
    if(!pl.is_line_intersecting($l)){ return false; }
    Point p; Vector v1,v2,v3; float a1,a2,a3;
    p = pl.get_line_intersect_point($l);
    if(p==global.error_point){ return false; }
    v1 = new Vector(p1.x-p.x,p1.y-p.y,p1.z-p.z); v1.unitize();
    v2 = new Vector(p2.x-p.x,p2.y-p.y,p2.z-p.z); v2.unitize();
    v3 = new Vector(p3.x-p.x,p3.y-p.y,p3.z-p.z); v3.unitize();
    a1 = acos(min(max(dot_product(v1,v2),-1),1));
    a2 = acos(min(max(dot_product(v2,v3),-1),1));
    a3 = acos(min(max(dot_product(v3,v1),-1),1));
    if(abs((a1+a2+a3)-TWO_PI)<=global.angle_tolerance){ return true; }
    return false;
  }
  boolean is_segment_intersecting(Segment $s,boolean $inclusive){
    Line l = new Line($s.p1,$s.p2);
    if(!pl.is_line_intersecting(l)){ return false; }
    Point p; Vector v1,v2,v3; float a1,a2,a3;
    p = pl.get_line_intersect_point(l);
    if($s.get_distance_to(p.x,p.y,p.z)>global.distance_tolerance){ return false; }
    v1 = new Vector(p1.x-p.x,p1.y-p.y,p1.z-p.z); v1.unitize();
    v2 = new Vector(p2.x-p.x,p2.y-p.y,p2.z-p.z); v2.unitize();
    v3 = new Vector(p3.x-p.x,p3.y-p.y,p3.z-p.z); v3.unitize();
    a1 = acos(min(max(dot_product(v1,v2),-1),1));
    a2 = acos(min(max(dot_product(v2,v3),-1),1));
    a3 = acos(min(max(dot_product(v3,v1),-1),1));
    if(abs((a1+a2+a3)-TWO_PI)<=global.angle_tolerance){ return true; }
    return false;
  }
  Point get_line_intersect_point(Line $l){
    //must test for intersection first or this will error or result in a point off the face
    return pl.get_line_intersect_point($l);
  }
  boolean cull(){
    float p1x,p1y,p2x,p2y,p3x,p3y;
    p1x = screenX(p1.x,p1.y,p1.z); p1y = screenY(p1.x,p1.y,p1.z);
    p2x = screenX(p2.x,p2.y,p2.z); p2y = screenY(p2.x,p2.y,p2.z);
    p3x = screenX(p3.x,p3.y,p3.z); p3y = screenY(p3.x,p3.y,p3.z);
    if(((p2y-p1y)/(p2x-p1x)-(p3y-p1y)/(p3x-p1x)<0)^(p1x<=p2x==p1x>p3x)){ return false; }
    return true;
  }
  void render(boolean $cull){
    if(!$cull||!cull()){
      super.render();
    }
  }
}
