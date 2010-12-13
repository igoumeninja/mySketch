/*
Spiral Class
 
Aris Bezas Mon, 13 December 2010, 20:09

Also in this sketch
  * Run applet to a second monitor
    from http://workshop.evolutionzone.com/2007/01/10/code-framesetundecoratedtrue/ 
    check out screen arrangment and screen dimensions
    processing forum not useful at: http://processing.org/discourse/yabb2/YaBB.pl?board=Syntax;action=display;num=1185318989
*/

import processing.opengl.*;
float b = 0.1, th, step = 0.1,r,x,y; 
int numSpires = 400;
int[] prosimo = new int[4];

Spira[]  s = new Spira[numSpires];

PFont  font;

void setup()  {
  //size(screen.width, screen.height, OPENGL);  
  size(1280,1024, OPENGL);
  font = createFont("Georgia", 12);  //.ttf in data folder
  textFont(font, 12);       
  frame.setLocation(1440,0);

  background(0);
  stroke(255);
  fill(255);
  noFill();
  frameRate(50);
  smooth();
  prosimo[0] = 1;
  prosimo[1] = -1;
  prosimo[2] = 1;
  prosimo[3] = -1;

  for (int i = 0; i < s.length; i++) { 
    float x = random(width); 
    float y = random(height);
    float a = random(0.01,10);
    float b = 0.1;
    float step = prosimo[int(random(4))]*random(0.1, 0.15);
    if (step < 0)  {
      b = -0.1;
    }
    s[i] = new Spira(x, y, a, b, step);
  }

}

void draw()  {
  for (int i = 0; i < s.length; i++) { 
    s[i].calculate();     // Move each object 
    s[i].display();  // Display each object
  } 

}
public void init() {
  frame.removeNotify();
  frame.setUndecorated(true); // works.

  // call PApplet.init() to take care of business
  super.init();
} 




void mousePressed()  {
  background(0);
}
class Spira { 
  float xInit, yInit;
  float a;     // Diameter of the circle 
  float b;        // Distance moved each frame 
  float step; 
  float th;
  float x, y;         // X-coordinate, y-coordinate   

  // Constructor 
  Spira(float xInitVar, float yInitVar, float aVar, float bVar, float stepVar) { 
    xInit = xInitVar; 
    yInit = yInitVar; 
    a = aVar;
    b = bVar;
    step = stepVar;
  } 

  void calculate() { 
    if(r > width/2 || r < -width/2) {
      th = 0;
    }
    r = a * exp(b*th);  
    th = th + step;
    x = xInit + r*cos(th);
    y = yInit + r*sin(th);
  } 

  void display() {
    stroke(255,25-r/10);
    noFill();
    rect(x,y, th,th);
  } 
} 









