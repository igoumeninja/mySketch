//------ BLOB ------//
//blobs are groups of curved polygons made from proximity tests within one or more particle clouds
class Blob{
  int npolygons,nclouds,nparticles;
  float cohesion_distance = 40;
  float outline_distance = 80;
  Polygon[] polygons = new Polygon[1000];
  Polygon[] outlines = new Polygon[1000];
  Cloud[] clouds = new Cloud[100];
  Particle[] particles = new Particle[1000];
  Blob(Cloud[] $clouds){
    npolygons = nclouds = nparticles = 0;
    for(int i=0;i<$clouds.length;i++){
      add_cloud($clouds[i]);
    }
  }
  void add_cloud(Cloud $c){
    clouds[nclouds++] = $c;
    for(int i=0;i<$c.nparticles;i++){
      particles[nparticles++] = $c.particles[i];
    }
  }
  Polygon[] get_groups(){
    int ngroups = 0;
    Polygon[] groups = new Polygon[nparticles];
    boolean[] grouped = new boolean[nparticles];
    for(int i=0;i<nparticles;i++){
      if(grouped[i]) continue;
      groups[ngroups++] = new Polygon(get_group(particles[i],grouped));
    }
    groups = (Polygon[]) subset(groups,0,ngroups);
    return groups;
  }
  Particle[] get_group(Particle $p,boolean[] $grouped){
    Particle[] group = new Particle[1];
    group[0] = $p;
    for(int i=0;i<nparticles;i++){
      if($grouped[i]) continue;
      if($p.get_distance_to(particles[i])<=cohesion_distance){
        $grouped[i] = true;
        group = (Particle[]) concat(group,get_group(particles[i],$grouped));
      }
    }
    return group;
  }
  void step(){
    for(int i=0;i<nclouds;i++){
      clouds[i].step();
    }
    polygons = get_groups();
    npolygons = polygons.length;
    for(int i=0;i<npolygons;i++){
      outlines[i] = polygons[i].get_outline(cohesion_distance);
    }
  }
  void render(){
    for(int i=0;i<npolygons;i++){
      if(outlines[i]!=polygons[i]){
        if(outlines[i].is_complex()) continue;
        outlines[i].render("curve");
      }
    }
    /*
    for(int i=0;i<nclouds;i++){
      clouds[i].render();
    }
    */
  }
}
