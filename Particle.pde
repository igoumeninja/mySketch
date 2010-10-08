//------ PARTICLE ------//
//the particle class is stage-aware, in that it can wrap its position from one side of the screen to the other
//particles have no mass, but have a display radius
class Particle extends Point{
  float vx,vy,vz,tvx,tvy,tvz,r;
  boolean wrapping = false;
  boolean bouncing = false;
  boolean locked = false;
  float speed = 0.005;
  float wander_speed = 0.01;
  float attract_distance = 350;
  float attract_speed = 0.005;
  float repel_distance = 25;
  float repel_speed = 0.06;
  float gx = 0;
  float gy = 1;
  float gz = 0;
  float friction = 0.02;
  float bounce_friction = 0.4;
  Particle(float $x,float $y,float $z,float $vx,float $vy,float $vz,float $r,boolean $forces){
    super($x,$y,$z);
    vx = tvx = $vx; vy = tvy = $vy; vz = tvz = $vz; r = $r;
    if(!$forces){
      wander_speed = 0;
      attract_speed = 0;
      repel_speed = 0;
    }
  }
  Particle(float $x,float $y,float $z,float $r,boolean $forces){
    super($x,$y,$z);
    vx = tvx = 0; vy = tvy = 0; vz = tvz = 0; r = $r;
    if(!$forces){
      wander_speed = 0;
      attract_speed = 0;
      repel_speed = 0;
    }
  }
  void attract(Particle $p){
    if(attract_speed==0) return;
    float d = get_distance_to($p.x,$p.y,$p.z);
    if(d<attract_distance&&d>repel_distance){
      float dtvx = ((attract_distance-d)*($p.x-x)/d)*attract_speed;
      float dtvy = ((attract_distance-d)*($p.y-y)/d)*attract_speed;
      float dtvz = ((attract_distance-d)*($p.z-z)/d)*attract_speed;
      if(!locked&&!$p.locked){
        vx += dtvx/2; vy += dtvy/2; vz += dtvz/2;
        $p.vx += -dtvx/2; $p.vy += -dtvy/2; $p.vz += -dtvz/2;
      }else if(locked){
        $p.vx += -dtvx; $p.vy += -dtvy; $p.vz += -dtvz;
      }else{
        vx += dtvx; vy += dtvy; vz += dtvz;
      }
    }
  }
  void repel(Particle $p){
    if(repel_speed==0) return;
    float d = get_distance_to($p.x,$p.y,$p.z);
    if(d<repel_distance&&d>global.distance_tolerance){
      float dtvx = ((repel_distance-d)*($p.x-x)/d)*repel_speed;
      float dtvy = ((repel_distance-d)*($p.y-y)/d)*repel_speed;
      float dtvz = ((repel_distance-d)*($p.z-z)/d)*repel_speed;
      if(!locked&&!$p.locked){
        vx += -dtvx/2; vy += -dtvy/2; vz += -dtvz/2;
        $p.vx += dtvx/2; $p.vy += dtvy/2; $p.vz += dtvz/2;
      }else if(locked){
        $p.vx += dtvx; $p.vy += dtvy; $p.vz += dtvz;
      }else{
        vx += -dtvx; vy += -dtvy; vz += -dtvz;
      }
    }
  }
  void wander(boolean $z){
    if(wander_speed==0) return;
    tvx += random(-wander_speed,wander_speed);
    tvy += random(-wander_speed,wander_speed);
    if($z){
      tvz += random(-wander_speed,wander_speed);
    }
    vx += (tvx-vx)*speed;
    vy += (tvy-vy)*speed;
    vz += (tvz-vz)*speed;
  }
  void step(){
    vx += (float) gx;
    vy += (float) gy;
    vz += (float) gz;
    vx *= (float) 1-friction;
    vy *= (float) 1-friction;
    vz *= (float) 1-friction;
    move(vx,vy,vz);
    if(bouncing){
      bounce();
    }else if(wrapping){
      wrap();
    }
  }
  void bounce(){
    if(x>global.w/2-r||x<-global.w/2+r){
        vx *= -(1-bounce_friction);
        tvx *= -(1-bounce_friction);
        x = constrain(x,-global.w/2+r,global.w/2-r);
      }
      if(y>global.h/2-r||y<-global.h/2+r){
        vy *= -(1-bounce_friction);
        tvy *= -(1-bounce_friction);
        y = constrain(y,-global.h/2+r,global.h/2-r);
      }
      if(z>-r||z<-global.d+r){
        vz *= -(1-bounce_friction);
        tvz *= -(1-bounce_friction);
        z = constrain(z,-r,global.d-r);
      }
  }
  void wrap(){
    //xy coordinates only
    if(x>global.w/2-r||x<-global.w/2+r){
      x += 3*global.w/2;
      x %= global.w;
      x -= global.w/2;
    }
    if(y>global.h/2-r||y<-global.h/2+r){
      y += 3*global.h/2;
      y %= global.h;
      y -= global.h/2;
    }
  }
  void render(){
    if(r>0.5){
      pg.pushMatrix();
      pg.translate(x,y,z);
      pg.ellipse(0,0,r*2,r*2);
      pg.popMatrix();
      pg.point(x,y,z);
    }else{
      pg.point(x,y,z);
    }
    //pg.line(ox,oy,oz,x,y,z);
  }
}
