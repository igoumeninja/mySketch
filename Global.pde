//------ GLOBAL ------//
//the global class holds all other default classes
//its only purpose is for organization and to imitate actionscript
class Global{
  Point zero_point,error_point;
  float[] sines,cosines;
  int w,h,d;
  Polygon stage;
  Face circumscribed_face;
  float distance_tolerance = .001;
  float simplify_distance_tolerance = 5;
  float slope_tolerance = .001;
  float simplify_slope_tolerance = .01;
  float angle_tolerance = .001;
  int angles = 720;
  Global(int $w,int $h,int $d){
    w = $w; h = $h; d = $d;
  }
  void init(){
    Point[] ps = new Point[4]; ps[0] = new Point(-w/2,-h/2,0); ps[1] = new Point(w/2,-h/2,0); ps[2] = new Point(w/2,h/2,0); ps[3] = new Point(-w/2,h/2,0);
    stage = new Polygon(ps);
    ps = new Point[3]; ps[0] = new Point(0,-h/2-sqrt(sq(w)-sq(w/2)),0); ps[1] = new Point(-w/2-h/sqrt(3),h/2,0); ps[2] = new Point(w/2+h/sqrt(3),h/2,0);
    circumscribed_face = new Face(ps);
    zero_point = new Point(0,0,0);
    error_point = new Point(-9999,-9999,-9999);
    sines = new float[angles]; cosines = new float[angles];
    for(int i=0;i<angles;i++){
      sines[i] = (float) Math.sin(((float) i/angles)*TWO_PI);
      cosines[i] = (float) Math.cos(((float) i/angles)*TWO_PI);
    }
  }
  float constrainX(float $x){
    return min(w/2,max(-w/2,$x));
  }
  float constrainY(float $y){
    return min(h/2,max(-h/2,$y));
  }
  float constrainZ(float $z){
    return min(0,max(-d,$z));
  }
  Point random_point(){
    //xy coordinates only
    return new Point(random(-w/2,w/2),random(-h/2,h/2),0);
  }
  float sin(float $n){
    while($n<0) $n += TWO_PI;
    return sines[(int)(angles*($n%TWO_PI)/TWO_PI)];
  }
  float cos(float $n){
    while($n<0) $n += TWO_PI;
    return cosines[(int)(angles*($n%TWO_PI)/TWO_PI)];
  }
  float randomize(float $n,float $r){
    return $n+random(-$r/2,$r/2);
  }
}
