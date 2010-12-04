/*
Stylus-Fantasticus WebSite Development

Aris Bezas Fri, 03 December 2010, 21:46


*/


Kykloi k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15, k16, k17, k18; 

int prosimo = 1, ypsos = 30, megethos = 25;
boolean update = false, start = false;


void setup() { 
  size(600, 800); 
  frameRate(20);
  rectMode(CENTER);
  strokeJoin(ROUND);
  smooth(); 
  strokeWeight(2);
  background(0); 
  k1 = new Kykloi(width/2, 20 + 0*ypsos, 0, 40);
    k1.colorize(#844800);
  k2 = new Kykloi(width/2, 20 + 1*ypsos, 0, 40);
  k3 = new Kykloi(width/2, 20 + 2*ypsos, 0, 40);
  k4 = new Kykloi(width/2, 20 + 3*ypsos, 0, 40);
  k5 = new Kykloi(width/2, 20 + 4*ypsos, 0, 40);
  k6 = new Kykloi(width/2, 20 + 5*ypsos, 0, 40);
  k7 = new Kykloi(width/2, 20 + 6*ypsos, 0, 40);
  k8 = new Kykloi(width/2, 20 + 7*ypsos, 0, 40);
  k9 = new Kykloi(width/2, 20 + 8*ypsos, 0, 40);
  k10 = new Kykloi(width/2, 20 + 9*ypsos, 0, 40);
  k11 = new Kykloi(width/2, 20 + 10*ypsos, 0, 40);
  k12 = new Kykloi(width/2, 20 + 11*ypsos, 0, 40);
  k13 = new Kykloi(width/2, 20 + 12*ypsos, 0, 40);
  k14 = new Kykloi(width/2, 20 + 13*ypsos, 0, 40);
  k15 = new Kykloi(width/2, 20 + 14*ypsos, 0, 40);
  k16 = new Kykloi(width/2, 20 + 15*ypsos, 0, 40);
  k17 = new Kykloi(width/2, 20 + 16*ypsos, 0, 40);
  k18 = new Kykloi(width/2, 20 + 17*ypsos, 0, 40);
  k1.colorize(#844800);
  k2.colorize(#C07800);
  k3.colorize(#481800);
  k4.colorize(#FC9C00);
  k5.colorize(#0C0000);
  k6.colorize(#FCC048);
  k7.colorize(#FCFCF0);
  k8.colorize(#FCE4B4);
  k9.colorize(#844800);
  k10.colorize(#E37575);
  k11.colorize(#240421);
  k12.colorize(#C0B4A8);
  k13.colorize(#9C603C);
  k14.colorize(#844800);
  k15.colorize(#C07800);
  k16.colorize(#481800);
  k17.colorize(#FC9C00);
  k18.colorize(#0C0000);
    k1.update();
    k2.update();
    k3.update();
    k4.update();
    k5.update();
    k6.update();
    k7.update();
    k8.update();
    k9.update();
    k10.update();
    k11.update();
    k12.update();
    k13.update();
    k14.update();
    k15.update();
    k16.update();
    k17.update();
    k18.update();
} 
void draw() { 
  
  if (update)  {
    background(0); 
    k1.update();
    k2.update();
    k3.update();
    k4.update();
    k5.update();
    k6.update();
    k7.update();
    k8.update();
    k9.update();
    k10.update();
    k11.update();
    k12.update();
    k13.update();
    k14.update();
    k15.update();
    k16.update();
    k17.update();
    k18.update();
  }
} 

void mousePressed()  {
  if (start == false){
    k1.s = int(random(30));
    k2.s = int(random(30));
    k3.s = int(random(30));
    k4.s = int(random(30));
    k5.s = int(random(30));
    k6.s = int(random(30));
    k7.s = int(random(30));
    k8.s = int(random(30));
    k9.s = int(random(30));
    k10.s = int(random(30));
    k11.s = int(random(30));
    k12.s = int(random(30));
    k13.s = int(random(30));
    k14.s = int(random(30));
    k15.s = int(random(30));
    k16.s = int(random(30));
    k17.s = int(random(30));
    k18.s = int(random(30));
    println("takis");
    start = true;
  }
  if (start == true){
    k1.x = width/2;
    k2.x = width/2;
    k3.x = width/2;
    k4.x = width/2;
    k5.x = width/2;
    k6.x = width/2;
    k7.x = width/2;
    k8.x = width/2;
    k9.x = width/2;
    k10.x = width/2;
    k11.x = width/2;
    k12.x = width/2;
    k13.x = width/2;
    k14.x = width/2;
    k15.x = width/2;
    k16.x = width/2;
    k17.x = width/2;
    k18.x = width/2;
    start = true;
  }
}
void mouseMoved() {
  update = true;
}
class Kykloi { 
  int x, y, s;
  color instanceColorClass = 255;
  Kykloi(int xpos, int ypos, int speed, int megethos) { 
    x = xpos; 
    y = ypos;
    s = speed; 
  } 
  void update() {

    x = x + s; 
    rect(x,y, megethos, megethos);
    fill(instanceColorClass);
    ellipse(x, y, megethos, megethos);
    if (x> (width - 200) || x<200) s = -s;
  } 
  void colorize(color instanceColor) {
    instanceColorClass = instanceColor;
    
  }
} 



