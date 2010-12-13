/*
Spiral Class

Aris Bezas Mon, 13 December 2010, 20:09
*/

import processing.opengl.*;
float b = 0.1, th, step = 0.1,r,x,y; 
int numSpires = 400;

Spira[]  s = new Spira[numSpires];

PFont  font;

void setup()  {
  size(screen.width, screen.height, OPENGL);  
  //size(600,600, OPENGL);
  font = createFont("Georgia", 12);  //.ttf in data folder
  textFont(font, 12);       
  
  background(0);
  stroke(255);
  fill(255);
  noFill();
    frameRate(50);
  smooth();
  for (int i = 0; i < s.length; i++) { 
    float x = random(width); 
    float y = random(height);
    float a = random(10);
    float b = random(1.1);
    float step = random(1.1);    
    s[i] = new Spira(x, y, a, 0.1, 0.1);
  }

}

void draw()  {
  for (int i = 0; i < s.length; i++) { 
    s[i].calculate();     // Move each object 
    s[i].display();  // Display each object
  } 
  
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
    if(x > width) {
      th = 0;
    }
    r = a * exp(b*th);  
    th = th + step;
    x = xInit + r*cos(th);
    y = yInit + r*sin(th);
  } 

  void display() {
    stroke(255,25-th);
    noFill();
    rect(x,y, th,th);
  } 
} 










