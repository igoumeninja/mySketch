//------ MUSCLE ------//
//a spring that expands and contracts repeatedly
class Muscle extends Spring{
  float td,otd;
  int frame = 0;
  int frames = 200;
  Muscle(Mass $m1,Mass $m2,float $k,float $d,float $td){
    super($m1,$m2,$k,$d);
    td = otd = $td;
  }
  void step(){
    frame++;
    d = od+(td-od)/2+cos(PI+TWO_PI*(frame%frames)/frames)*(td-od)/2;
    super.step();
  }
}
