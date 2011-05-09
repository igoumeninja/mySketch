/*
Computer Vision example with OSC sender
 
Aris Bezas Mon, 09 May 2011, 15:37
*/

import hypermedia.video.*;
import java.awt.*; 

import processing.opengl.*;
import oscP5.*;  
import netP5.*;

OpenCV opencv;

OscP5 oscP5;
NetAddress myRemoteLocation;

int w = 320;
int h = 240;
int threshold = 80;

boolean find=true;

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

  // OpenCV stuff
  opencv = new OpenCV( this );
  opencv.capture(w,h);
  
  //OSC stuff
  oscP5 = new OscP5(this, 12000);   //listening
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);  //  speak to
  
  // The method plug take 3 arguments. Wait for the <keyword>
  oscP5.plug(this, "varName", "keyword");
}

void draw() {
    // OpenCV stuff
    opencv.read();
    opencv.absDiff();
    opencv.threshold(threshold);
    image( opencv.image(OpenCV.GRAY), 20+w, 20+h ); // absolute difference image
    
    Blob[] blobs = opencv.blobs( 50, w*h, 1, false );
    noFill();
    
    for( int i=0; i<blobs.length; i++ ) {
        Point centroid =  blobs[i].centroid;
        // OSC stuff
        OscMessage blobXmsg = new OscMessage("blobPosX");  
        blobXmsg.add(centroid.x); 
        oscP5.send(blobXmsg, myRemoteLocation);

        OscMessage blobYmsg = new OscMessage("blobPosY");  
        blobYmsg.add(centroid.y); 
        oscP5.send(blobYmsg, myRemoteLocation);
    } 
}



void keyPressed() {
    if ( key==' ' ) opencv.remember();
}

void mouseDragged() {
    threshold = int( map(mouseX,0,width,0,255) );
}

public void stop() {
    opencv.stop();
    super.stop();
}

public void varName(int _varName) {
  varName = _varName;
}

