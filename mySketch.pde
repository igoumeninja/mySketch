Kykloi k1, k2, k3, k4, k5, k6, k7, k8, k9; 

int prosimo = 1;

void setup() { 
	frameRate(20);
  size(screen.width, screen.height); 
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
    x = x + s; 
    ellipse(x, y, 20, 20);
    if (x>screen.width) x = 0;
  } 
} 

