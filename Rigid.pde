//------ RIGID ------//
//rigids are polygons that attempt to hold their shape when subjected to forces :: incomplete
class Rigid extends Polygon{
  int nmasses;
  Mass[] masses = new Mass[1000];
  float density = 1.3;
  float m;
  Rigid(Mass[] $masses,float $density){
    super($masses);
    for(int i=0;i<$masses.length;i++){
      if($masses[i]==null) break;
      add_mass($masses[i]);
    }
    m = get_area()*$density;
  }
  void add_mass(Mass $m){
    masses[nmasses++] = $m;
  }
  void step(){
    rotate(0.01,"z");
    centroid = get_centroid_point();
  }
  void render(){
    super.render();
    centroid.render();
  }
}
