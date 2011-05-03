/*
Template for OSC control
 
 Aris Bezas Tue, 03 May 2011, 18:17
 */

import processing.opengl.*;
import oscP5.*;  
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

PFont  font;
int varName;

void setup() {
  //size(screen.width, screen.height, OPENGL);  
  size(600, 600, OPENGL);
  font = createFont("Georgia", 12);  //.ttf in data folder
  textFont(font, 12);       

  background(0);
  stroke(255);
  fill(255);
  noFill();

  oscP5 = new OscP5(this, 12000);   //listening
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);  //  speak to
  
  // The method plug take 3 arguments. Wait for the <keyword>
  oscP5.plug(this, "varName", "keyword");
}

void draw() {
  OscMessage newMessage = new OscMessage("mouseX position");  
  newMessage.add(mouseX); 
  oscP5.send(newMessage, myRemoteLocation);
 
  println(varName);
}

public void varName(int _varName) {
  varName = _varName;
}

