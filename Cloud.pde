//------ CLOUD ------//
//clouds are groups of particles
class Cloud{
  int nparticles,npullers,npushers;
  Particle[] particles = new Particle[1000];
  Particle[] pullers = new Particle[100];
  Particle[] pushers = new Particle[100];
  boolean wrapping = false; boolean bouncing = true;
  boolean puller_wrapping = false; boolean puller_bouncing = true; boolean puller_locked = true;
  boolean pusher_wrapping = false; boolean pusher_bouncing = true; boolean pusher_locked = true;
  float speed = 0.1; float wander_speed = 0.1; float attract_distance = 80; float attract_speed = 0.0006; float repel_distance = 40; float repel_speed = 0.05;
  float puller_speed = 0.005; float puller_wander_speed = 0.01; float puller_attract_distance = 200; float puller_attract_speed = 0.0007; float puller_repel_distance = 30; float puller_repel_speed = 0.07;
  float pusher_speed = 0.005; float pusher_wander_speed = 0.01; float pusher_attract_distance = 0; float pusher_attract_speed = 0.0005; float pusher_repel_distance = 60; float pusher_repel_speed = 0.08;
  float gx = 0; float gy = 0; float gz = 0;
  float friction = 0.1;
  float bounce_friction = 0.4;
  Cloud(Particle[] $particles){
    nparticles = npullers = npushers = 0;
    for(int i=0;i<$particles.length;i++){
      if($particles[i]==null) break;
      add_particle($particles[i]);
    }
  }
  Cloud(Particle[] $particles,Particle[] $pullers,Particle[] $pushers){
    nparticles = npullers = npushers = 0;
    for(int i=0;i<$particles.length;i++){
      add_particle($particles[i]);
    }
    for(int i=0;i<$pullers.length;i++){
      add_puller($pullers[i]);
    }
    for(int i=0;i<$pushers.length;i++){
      add_pusher($pushers[i]);
    }
  }
  void add_particle(Particle $p){
    $p.wrapping = wrapping; $p.bouncing = bouncing;
    $p.speed = speed; $p.wander_speed = wander_speed; $p.attract_distance = attract_distance; $p.attract_speed = attract_speed; $p.repel_distance = repel_distance; $p.repel_speed = repel_speed;
    $p.gx = gx; $p.gy = gy; $p.gz = gz; $p.friction = friction; $p.bounce_friction = bounce_friction;
    particles[nparticles++] = $p;
  }
  void add_puller(Particle $p){
    $p.wrapping = puller_wrapping; $p.bouncing = puller_bouncing; $p.locked = puller_locked;
    $p.speed = puller_speed; $p.wander_speed = puller_wander_speed; $p.attract_distance = puller_attract_distance; $p.attract_speed = puller_attract_speed; $p.repel_distance = puller_repel_distance; $p.repel_speed = puller_repel_speed;
    $p.gx = gx; $p.gy = gy; $p.gz = gz; $p.friction = friction; $p.bounce_friction = bounce_friction;
    pullers[npullers++] = $p;
  }
  void add_pusher(Particle $p){
    $p.wrapping = pusher_wrapping; $p.bouncing = pusher_bouncing; $p.locked = pusher_locked;
    $p.speed = pusher_speed; $p.wander_speed = pusher_wander_speed; $p.attract_distance = pusher_attract_distance; $p.attract_speed = pusher_attract_speed; $p.repel_distance = pusher_repel_distance; $p.repel_speed = pusher_repel_speed;
    $p.gx = gx; $p.gy = gy; $p.gz = gz; $p.friction = friction; $p.bounce_friction = bounce_friction;
    pushers[npushers++] = $p;
  }
  void apply_force(float $fx,float $fy,float $fz){
    for(int i=0;i<nparticles;i++){
      particles[i].vx += $fx;
      particles[i].vy += $fy;
      particles[i].vz += $fz;
    }
  }
  void wander(){
    for(int i=0;i<nparticles;i++){
      particles[i].wander(false);
    }
  }
  void attract(){
    for(int i=0;i<nparticles;i++){
      for(int j=i+1;j<nparticles;j++){
        particles[i].attract(particles[j]);
      }
    }
  }
  void repel(){
    for(int i=0;i<nparticles;i++){
      for(int j=i+1;j<nparticles;j++){
        particles[i].repel(particles[j]);
      }
    }
  }
  void step(){
    for(int i=0;i<npullers;i++){
      for(int j=0;j<nparticles;j++){
        pullers[i].attract(particles[j]);
        pullers[i].repel(particles[j]);
      }
    }
    for(int i=0;i<npushers;i++){
      for(int j=0;j<nparticles;j++){
        pushers[i].attract(particles[j]);
        pushers[i].repel(particles[j]);
      }
    }
    for(int i=0;i<nparticles;i++){
      particles[i].step();
    }
    for(int i=0;i<npullers;i++){
      pullers[i].step();
    }
    for(int i=0;i<npushers;i++){
      pushers[i].step();
    }
  }
  void render(){
    for(int i=0;i<nparticles;i++){
      particles[i].render();
    }
    /*
    for(int i=0;i<npullers;i++){
      pullers[i].render();
    }
    for(int i=0;i<npushers;i++){
      pushers[i].render();
    }
    */
  }
}
