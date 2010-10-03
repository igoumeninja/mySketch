/*
Interaction with twitter
Press s to start visualization
using keyWord for searching tweets 

Aris Bezas Thu, 16 September 2010, 03:13PM
*/

import com.twitter.processing.*;
import processing.opengl.*;
import processing.pdf.*;

PFont font;

int tweets = 0;
String tweetText = "";
String tweetID = "";
String keyWord = " ";


boolean viewLines, viewTweet;
float x1, x2, y2, y1;
char h;

void setup() {
  size(screen.width, screen.height, OPENGL);
  frameRate(20);
  noCursor();
  //beginRecord(PDF, "twitterP5.pdf");  
  background(0);  
  font = createFont("Andale Mono", 12);  //.ttf in data folder
  textFont(font, 12);       
  TweetStream s = new TweetStream(this, 
  "stream.twitter.com", 
  80, 
  "1/statuses/sample.json", 
  "username",
  "password@");
  s.go();
}

void draw() {
  noStroke();
  fill(0,10);
  //rect(-40, -40, width+300, height+400);
  if (viewTweet)  { 
    String[] m1 = match(tweetText, keyWord);
    if (m1 != null) {
      x1 = 950;    //random(width-30);
      x2 = 50;      //random(width)-30;  
      y1 = random(50, height-50);
      y2 = height/2;//random(height);
      noStroke();
      fill(0,20);
      rect(x2,y2-10, 100,30);    
      fill(255, 255, 255,150);
      text(tweetText, x1, y1);
      fill(255, 30, 0, 150);
      text(tweetID, x2, y2);
    }  
  }
  if (viewLines)  {
    noFill();
    stroke(255, 255, 255, 180);
    curve(random(1000), random(1000), x1, y1, x2+120, y2, random(1000), random(1000));
  }


//  if  (kodikos = "h")  {
//    background(0);
//  }
}

void keyPressed()  {
  if (key == 's' || key == 'S') {
    println("Start post");    
    viewLines = true;
    viewTweet = true;
  }  
  if (key == 'b' || key == 'B') {
    background(0);
  }  
  if (key == 'r' || key == 'R') {
    //endRecord();
  }  
}

void tweet(Status tweet) {
  tweetID = str(tweet.id());
  tweetText = tweet.text();
  tweets += 2;

  //  tweetID = str(tweet.statusesCount()); 
}



