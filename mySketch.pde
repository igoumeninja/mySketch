/*
Stylus-Fantasticus WebSite Development

Aris Bezas Fri, 03 December 2010, 21:46
*/


Kykloi k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15, k16; 

int prosimo = 1;

void setup() { 
  size(600, 600); 
  smooth(); 
  // Inputs: x, y, speed
  k1 = new Kykloi(0, 20, prosimo*5); 
  k2 = new Kykloi(0, 50, prosimo*9); 
  k3 = new Kykloi(0, 80, prosimo*3); 
  k4 = new Kykloi(0, 110, prosimo*7); 
  k5 = new Kykloi(0, 140, prosimo*2);   
  k6 = new Kykloi(0, 170, prosimo*23);   
  k7 = new Kykloi(0, 200, prosimo*6);   
  k8 = new Kykloi(0, 230, prosimo*8);   
  k9 = new Kykloi(0, 260, prosimo*12);     
  k10 = new Kykloi(0, 290, prosimo*1);     
  k11 = new Kykloi(0, 320, prosimo*2);     
  k12 = new Kykloi(0, 350, prosimo*4);     
  k13 = new Kykloi(0, 380, prosimo*3);     
  k14 = new Kykloi(0, 410, prosimo*7);     
  k15 = new Kykloi(0, 440, prosimo*13);     
  k16 = new Kykloi(0, 470, prosimo*22);     
} 
void draw() { 
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
} 

void mousePressed()  {
}
class Kykloi { 
  int x, y, s; 
  Kykloi(int xpos, int ypos, int speed) { 
    x = xpos; 
    y = ypos;
    s = speed; 
  } 
  void update() {
    colorKyklou();
    x = x + s; 
    ellipse(x, y, 20, 20);
    if (x>600) s = -s;
    if (x<0) s = -s;
  } 
  void colorKyklou()  {
     fill(random(200));
  }
} 

