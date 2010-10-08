//------ SEGMENT ------//
class Segment{
  float l;
  Point p1,p2;
  Segment(Point $p1,Point $p2){
    p1 = $p1; p2 = $p2;
    l = get_length();
  }
  void reset(){
    p1.reset();
    p2.reset();
  }
  void match(Segment $s){
    p1.match($s.p1);
    p2.match($s.p2);
  }
  float get_length(){
    return dist(p1.x,p1.y,p1.z,p2.x,p2.y,p2.z);
  }
  Point get_midpoint(){
    return new Point((p1.x+p2.x)/2,(p1.y+p2.y)/2,(p1.z+p2.z)/2);
  }
  float get_angle(){
    return atan2(p2.y-p1.y,p2.x-p1.x);
  }
  float get_slope(){
    //xy coordinates only
    if(p2.x!=p1.x){
      return ((p2.y-p1.y)/(p2.x-p1.x));
    }else{
      return 999999999;
    }
  }
  boolean is_identical(Segment $s){
    if((p1==$s.p1&&p2==$s.p2)||(p2==$s.p1&&p1==$s.p2)){ return true; }
    return false;
  }
  boolean is_coincident(Segment $s){
    float slope1 = get_slope();
    float slope2 = $s.get_slope();
    if(is_coord_on($s.p1.x,$s.p1.y,$s.p1.z)&&abs(slope1-slope2)<=global.slope_tolerance){ return true; }
    return false;
  }
  boolean is_ray_intersecting(float $x,float $y,boolean $inclusive){
    //xy coordinates only :: for inside-outside testing, etc. :: ray points right, starting from the given coordinates
    float pbua1 = (p2.x-p1.x)*($y-p1.y)-(p2.y-p1.y)*($x-p1.x);
    float pbu2 = p2.y-p1.y;
    float pbub1 = $y-p1.y;
    if(pbu2==0){ return false; }
    float pbua = pbua1/pbu2;
    float pbub = pbub1/pbu2;
    if($inclusive){
      if(pbua>=0&&pbub>0&&pbub<=1){ return true; }
    }else{
      if(pbua>0&&pbub>0&&pbub<=1){ return true; }
    }
    return false;
  }
  boolean is_line_intersecting(Line $l,boolean $inclusive){
    //xy coordinates only
    float pbua1 = (p2.x-p1.x)*($l.s.p1.y-p1.y)-(p2.y-p1.y)*($l.s.p1.x-p1.x);
    float pbu2 = (p2.y-p1.y)*($l.s.p2.x-$l.s.p1.x)-(p2.x-p1.x)*($l.s.p2.y-$l.s.p1.y);
    float pbub1 = ($l.s.p2.x-$l.s.p1.x)*($l.s.p1.y-p1.y)-($l.s.p2.y-$l.s.p1.y)*($l.s.p1.x-p1.x);
    if(pbu2==0){ return false; }
    float pbua = pbua1/pbu2;
    float pbub = pbub1/pbu2;
    if($inclusive){
      if(pbub>=0&&pbub<=1){ return true; }
    }else{
      if(pbub>0&&pbub<1){ return true; }
    }
    return false;
  }
  boolean is_segment_intersecting(Segment $s,boolean $inclusive){
    //xy coordinates only
    float pbua1 = (p2.x-p1.x)*($s.p1.y-p1.y)-(p2.y-p1.y)*($s.p1.x-p1.x);
    float pbu2 = (p2.y-p1.y)*($s.p2.x-$s.p1.x)-(p2.x-p1.x)*($s.p2.y-$s.p1.y);
    float pbub1 = ($s.p2.x-$s.p1.x)*($s.p1.y-p1.y)-($s.p2.y-$s.p1.y)*($s.p1.x-p1.x);
    if(pbu2==0){ return false; }
    float pbua = pbua1/pbu2;
    float pbub = pbub1/pbu2;
    if($inclusive){
      if(pbub>=0&&pbub<=1&&pbua>=0&&pbua<=1){ return true; }
    }else{
      if(pbub>0&&pbub<1&&pbua>0&&pbua<1){ return true; }
    }
    return false;
  }
  boolean is_coord_on(float $x,float $y,float $z){
    float d = get_distance_to($x,$y,$z);
    if(d<=global.distance_tolerance){ return true; }
    return false;
  }
  float get_distance_to(float $x,float $y,float $z){
    Point p = get_closest_point($x,$y,$z);
    return dist(p.x,p.y,p.z,$x,$y,$z);
  }
  Point get_closest_point(float $x,float $y,float $z){
    float u = (($x-p1.x)*(p2.x-p1.x)+($y-p1.y)*(p2.y-p1.y)+($z-p1.z)*(p2.z-p1.z))/sq(dist(p1.x,p1.y,p1.z,p2.x,p2.y,p2.z));
    float x = p1.x+u*(p2.x-p1.x);
    float y = p1.y+u*(p2.y-p1.y);
    float z = p1.z+u*(p2.z-p1.z);
    if(x>p1.x&&x>p2.x){ x = max(p1.x,p2.x); }
    if(x<p1.x&&x<p2.x){ x = min(p1.x,p2.x); }
    if(y>p1.y&&y>p2.y){ y = max(p1.y,p2.y); }
    if(y<p1.y&&y<p2.y){ y = min(p1.y,p2.y); }
    if(z>p1.z&&z>p2.z){ z = max(p1.z,p2.z); }
    if(z<p1.z&&z<p2.z){ z = min(p1.z,p2.z); }
    return new Point(x,y,z);
  }
  Point get_intersect_point(Segment $s){
    //xy coordinates only :: must test for on-segment intersection before using this, otherwise it will project the segments as lines to their intersection point :: it will also return {9999,9999,9999} for parallel lines (should be tested for prior to using this)
    float pbu2 = (p2.y-p1.y)*($s.p2.x-$s.p1.x)-(p2.x-p1.x)*($s.p2.y-$s.p1.y);
    if(pbu2!=0){
      float pbua1 = (p2.x-p1.x)*($s.p1.y-p1.y)-(p2.y-p1.y)*($s.p1.x-p1.x);
      float pbua = pbua1/pbu2;
      return new Point($s.p1.x+($s.p2.x-$s.p1.x)*pbua,$s.p1.y+($s.p2.y-$s.p1.y)*pbua,0);
    }
    return null;
  }
  void render(){
    pg.line(p1.x,p1.y,p1.z,p2.x,p2.y,p2.z);
  }
}
