/**
Class study
Aris Bezas Thu, 14 July 2011, 11:35
*/

import processing.opengl.*;

Protypo[] antikeimeno = new Protypo[5];

void setup()  {
  size(600,600,OPENGL);
  background(0);
  noFill();
  stroke(255);
  for (int i=0; i<antikeimeno.length; i++)  {
    antikeimeno[i] = new Protypo();
    antikeimeno[i].init(5 + 10*i);
  }
  
}

void draw()  {
  background(0);
  for (int i=0; i<antikeimeno.length; i++)  {
    antikeimeno[i].update();
    antikeimeno[i].draw();    
  }
}

void mousePressed() {
  
}

class Protypo  {
  
  PVector thesi;
  Protypo()  {
    float xPosVar;
  }
  
  void init(float xPosVar)  {
    thesi = new PVector();
    thesi.x = xPosVar;
    
  }
  void update()  {
  }
  void draw()  {
    thesi.x += sin(frameCount*0.1);
    thesi.y += sin(frameCount*0.13);
    translate(thesi.x,thesi.y+30);
    line(20, 20, 20, 40, 40, 40);
    line(20, -20, 20, 40, -40, 40);
    line(20, 20, -20, 40, 40, -40);
    line(-20, 20, 20, -40, 40, 40);
    line(20, -20, -20, 40, -40, -40);
    line(-20, 20, -20, -40, 40, -40);    
    line(-20, -20, 20, -40, -40, 40);
    line(-20, -20, -20, -40, -40, -40);    
    box(40);
    sphere(thesi.y/4);
    translate(40,40,40);    
    sphere(thesi.y/2);
    
  }
}
