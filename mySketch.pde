/*
Particles study
Class from http://www.bit-101.com/p5/particles/particles/applet/

Aris Bezas Wed, 08 December 2010, 12:42
*/

import processing.opengl.*;

PFont  font;
Particle[] particles;
int numParticles = 10000;
boolean lines = false;
int w = 600;
int h = 600;


void setup()  {
  //size(screen.width, screen.height, OPENGL);  
  size(w,h, OPENGL);
  font = createFont("Georgia", 12);  //.ttf in data folder
  textFont(font, 12);       
  
  background(0);
  stroke(255);
  fill(255);
  noFill();
  
  particles = new Particle[numParticles];
  for(int i=0;i<numParticles;i++)
  {
    particles[i] = new Particle();
    particles[i].x = random(w);
    particles[i].y = random(h);
    particles[i].vx = random(-1, 1);
    particles[i].vy = random(-1, 1);
  }

}

void draw()  {
  fill(0, 20);
  rect(0, 0, w, h);
  for(int i=0;i<numParticles;i++)
  {
    particles[i].move();
    particles[i].render();
  }  
  
}
void mousePressed()
{
  lines = !lines;
  for(int i=0;i<numParticles;i++)
  {
    particles[i].lines = lines;
  }
}

void keyPressed()  {
  
}
class Particle
{
  public float x = 0;
  public float y = 0;
  public float vx = 0;
  public float vy = 0;
  public float k = .01;
  public boolean lines = false;
  
  public void Particle()
  {
  }
  
  public void move()
  {
    float dx = mouseX - x;
    float dy = mouseY - y;
    float dist = sqrt(dx*dx + dy*dy);
    if(dist < 100)
    {
      float tx = mouseX - dx / dist * 20;
      float ty = mouseY - dy / dist * 100;
      vx += (tx - x) * k;
      vy += (ty - y) * k;
    }
    vx += random(-2, 2);
    vy += random(-2, 2);
    vy += .1;
    vx *= .95;
    vy *= .95;
    x += vx;
    y += vy;
    if(x > width)
    {
      x = width;
      vx *= -1;
    }
    if(x<0)
    {
      x = 0;
      vx *= -1;
    }
    if(y > height)
    {
      y = height;
      vy *= -1;
    }
    if(y < 0)
    {
      y = 0;
      vy *= -1;
    }
  }
  
  public void render()
  {
    stroke(255, 255);
    if(lines)
    {
      line(x, y, x-vx, y-vy);
    }
    else
    {
      point(x, y);
    }
  }
}


