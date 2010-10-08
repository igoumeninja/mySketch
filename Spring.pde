//------ SPRING ------//
//springs join and move masses
class Spring extends Segment{
  float k,d,od;
  Mass m1,m2;
  Spring(Mass $m1,Mass $m2,float $k,float $d){
    super($m1,$m2);
    m1 = $m1; m2 = $m2; k = $k; d = od = $d;
  }
  void step(){
    float dd = (get_length()-d)/2;
    float dx,dy,dz,u;
    dx = m2.x-m1.x;
    dy = m2.y-m1.y;
    dz = m2.z-m1.z;
    u = mag(dx,dy,dz);
    if(!m1.locked&&!m2.locked){
      m1.fx += (dd*k*dx/u)/m1.m;
      m1.fy += (dd*k*dy/u)/m1.m;
      m1.fz += (dd*k*dz/u)/m1.m;
      m2.fx -= (dd*k*dx/u)/m2.m;
      m2.fy -= (dd*k*dy/u)/m2.m;
      m2.fz -= (dd*k*dz/u)/m2.m;
    }else if(m1.locked){
      m2.fx -= (dd*k*dx/u)/m2.m;
      m2.fy -= (dd*k*dy/u)/m2.m;
      m2.fz -= (dd*k*dz/u)/m2.m;
    }else if(m2.locked){
      m1.fx += (dd*k*dx/u)/m1.m;
      m1.fy += (dd*k*dy/u)/m1.m;
      m1.fz += (dd*k*dz/u)/m1.m;
    }
  }
  void render(boolean $zigzag){
    if($zigzag&&m1.z==0&&m2.z==0){
      float l = get_length();
      int kinks = max(6,ceil(od/10));
      pg.pushMatrix();
      pg.translate(m1.x,m1.y);
      pg.rotateZ(get_angle());
      pg.beginShape();
      for(int i=0;i<kinks;i++){
        if(i<=3||i>=kinks-4){
          pg.vertex(i*l/(kinks-1),0);
        }else{
          if(i%2==0){
            pg.vertex(i*l/(kinks-1),15);
          }else{
            pg.vertex(i*l/(kinks-1),-15);
          }
        }
      }
      pg.endShape();
      pg.popMatrix();
    }else{
      render();
    }
  }
  void render(){
    pg.line(m1.x,m1.y,m1.z,m2.x,m2.y,m2.z);
  }
}
