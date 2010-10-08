//------ VECTOR ------//
class Vector{
  float vx,vy,vz,m;
  Vector(float $vx,float $vy,float $vz){
    vx = $vx;
    vy = $vy;
    vz = $vz;
    m = get_magnitude();
  }
  Vector(Point $p){
    vx = $p.x;
    vy = $p.y;
    vz = $p.z;
    m = get_magnitude();
  }
  float get_magnitude(){
    return mag(vx,vy,vz);
  }
  void unitize(){
    m = get_magnitude();
    if(m==0){ return; }
    vx = vx/m; vy = vy/m; vz = vz/m;
    m = 1;
  }
  void rotate(float $cosa,float $sina,String $axis){
    float tx,ty,tz;
    if($axis=="x"){
      tz = vz*$cosa-vy*$sina; ty = vy*$cosa+vz*$sina;
      vz = tz; vy = ty;
    }else if($axis=="y"){
      tx = vx*$cosa-vz*$sina; tz = vz*$cosa+vx*$sina;
      vx = tx; vz = tz;
    }else if($axis=="z"){
      tx = vx*$cosa-vy*$sina; ty = vy*$cosa+vx*$sina;
      vx = tx; vy = ty;
    }
  }
  void add(Vector $v){
    vx += $v.vx; vy += $v.vy; vz += $v.vz;
  }
  void add(Point $p){
    vx += $p.x; vy += $p.y; vz += $p.z;
  }
  void subtract(Vector $v){
    vx -= $v.vx; vy -= $v.vy; vz -= $v.vz;
  }
  void subtract(Point $p){
    vx -= $p.x; vy -= $p.y; vz -= $p.z;
  }
  void scale(float $s){
    vx *= $s; vy *= $s; vz *= $s;
  }
  void render(Point $p){
    pg.line($p.x,$p.y,$p.z,$p.x+vx,$p.y+vy,$p.z+vz);
  }
}

float dot_product(Vector $v1,Vector $v2){
  return ($v1.vx*$v2.vx)+($v1.vy*$v2.vy)+($v1.vz*$v2.vz);
}
float dot_product(Vector $v1,Point $p1){
  return ($v1.vx*$p1.x)+($v1.vy*$p1.y)+($v1.vz*$p1.z);
}
float dot_product(Point $p1,Point $p2){
  return ($p1.x*$p2.x)+($p1.y*$p2.y)+($p1.z*$p2.z);
}

Vector cross_product(Vector $v1,Vector $v2){
  return new Vector($v1.vy*$v2.vz-$v1.vz*$v2.vy,$v1.vz*$v2.vx-$v1.vx*$v2.vz,$v1.vx*$v2.vy-$v1.vy*$v2.vx);
}
