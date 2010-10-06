/*
Rotate line with potensiometer
Aris Bezas Sat, 02 October 2010, 07:51PM
*/

import processing.opengl.*;
import processing.serial.*;
import cc.arduino.*;

PFont font;
Arduino arduino;
int val;      // Data received from the serial port

void setup()  {
  //size(screen.width, screen.height, OPENGL);  
  size(600,600, OPENGL);
  arduino = new Arduino(this, Arduino.list()[0], 57600);  
  for (int i = 0; i <= 13; i++)  {
    arduino.pinMode(i, Arduino.INPUT);
  }

  font = createFont("Georgia", 12);  //.ttf in data folder
  textFont(font, 18);       
  

  stroke(255);
  fill(255);
  noFill();

}

void draw()  {
  background(0); 
  text(arduino.analogRead(0), 100,100);  
  for (int i = 0; i <= 13; i++) {
    if (arduino.digitalRead(i) == Arduino.HIGH)  {
      // make things
    }  else  {
      // make othe things
    }
  }
  
  for (int i = 0; i <= 5; i++) {
//    ellipse(280 + i * 30, 240, arduino.analogRead(i) / 16, arduino.analogRead(i) / 16);
  }
  println(arduino.analogRead(0));
  translate(width/2, height/2);
  rotate(map(arduino.analogRead(0), 0, 1023, 0, 2*PI));  
  box(200);
//  line(width/2, 0, width/2, height);
  //
}

void keyPressed()  {
  
}
