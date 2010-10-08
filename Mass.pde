//------ MASS ------//
//masses are slightly more sophisticated than particles, as they can accept forces
//they can maintain their radius from other masses and can be a part of a spring system
class Mass extends Particle{
  float m,fx,fy,fz;
  float density = 1.3;
  Mass(float $x,float $y,float $z,float $vx,float $vy,float $vz,float $r,float $density){
    super($x,$y,$z,$vx,$vy,$vz,$r,false);
    bouncing = true;
    density = $density;
    m = PI*sq(r)*density;
    fx = fy = fz = 0;
  }
  Mass(float $x,float $y,float $z){
    super($x,$y,$z,2,false);
    bouncing = true;
    m = 1;
    fx = fy = fz = 0;
  }
  void bump(Mass $m){
    //xy coordinates only
    float d = dist($m.x,$m.y,x,y);
    float rr = $m.r+r;
    if(d<rr&&d!=0){
      float a = atan2($m.y-y,$m.x-x);
      float cosa = cos(a);
      float sina = sin(a);
      float vx1p = cosa*vx+sina*vy;
      float vy1p = cosa*vy-sina*vx;
      float vx2p = cosa*$m.vx+sina*$m.vy;
      float vy2p = cosa*$m.vy-sina*$m.vx;
      float p = vx1p*m+vx2p*$m.m;
      float v = vx1p-vx2p;
      vx1p = (p-$m.m*v)/(m+$m.m);
      vx2p = v+vx1p;
      vx = cosa*vx1p-sina*vy1p;
      vy = cosa*vy1p+sina*vx1p;
      $m.vx = cosa*vx2p-sina*vy2p;
      $m.vy = cosa*vy2p+sina*vx2p;
      float diff = bounce_friction*((r+$m.r)-d)/2;
      float cosd = cosa*diff;
      float sind = sina*diff;
      x -= cosd;
      y -= sind;
      $m.x += cosd;
      $m.y += sind;
    }
  }
  void step(){
    vx += fx;
    vy += fy;
    vz += fz;
    super.step();
    fx = fy = fz = 0;
  }
}
