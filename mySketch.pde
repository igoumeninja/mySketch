/*
This is initial processing file like a template

Aris Bezas Sat, 02 October 2010, 07:51PM
*/

import processing.opengl.*;

PFont  font;

void setup()  {
  //size(screen.width, screen.height, OPENGL);  
  size(600,600, OPENGL);
  font = createFont("Georgia", 12);  //.ttf in data folder
  textFont(font, 12);       
  
  background(0);
  stroke(255);
  fill(255);
  noFill();
}

void draw()  {
  
}

void keyPressed()  {
  
}
