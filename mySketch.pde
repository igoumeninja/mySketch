//import processing.opengl.*;
//import processing.video.*;

// http://www.openprocessing.org/visuals/?visualID=6888

Global global; //always create the global variable before using any of the default classes (created by Don)

PApplet pg;
//PGraphics pg;
PFont font;
//MovieMaker mm;

boolean RENDERING = true;
boolean RECORDING = false;
boolean CLOCKING = true;
boolean WORKING = true;

int timer = 0;

float rx = 0;
float rz = 0;
float trx = 0;
float trz = 0;

Particle[] particles = new Particle[30];
Particle puller,pusher;
Cloud cl;
Delaunay de;
Voronoi vo;

boolean click = false;

void setup(){
  //initialize stage
  size(500,500,P3D);
  pg = this;
  //pg = createGraphics(3000,3000,P3D);
  pg.background(255);
  //if(RECORDING){ frameRate(24); }
  font = loadFont("ArialMT-18.vlw");
  textFont(font,18);
  textAlign(CENTER,CENTER);
  //initialize global
  global = new Global(pg.width,pg.height,pg.height);
  global.init();
  //initialize moviemaker
  //if(RECORDING){ mm = new MovieMaker(pg,global.w,global.h,"mov.mov",24,MovieMaker.JPEG,MovieMaker.HIGH); }
  //initialize sketch
  for(int i=0;i<particles.length;i++){
    particles[i] = new Particle(random(pg.width)-pg.width/2,random(pg.height)-pg.height/2,0,2,true);
  }
  cl = new Cloud(particles);
  de = new Delaunay(particles,global.circumscribed_face);
  vo = new Voronoi(de);
}

void draw(){
   render();
}

void render(){
  rx += (trx-rx)*.05;
  rz += (trz-rz)*.05;
  if(RENDERING){
    pg.background(200);
    pg.pushMatrix();
    pg.translate(global.w/2,global.h/2,0);
    pg.rotateX(rx);
    pg.rotateZ(rz);
    pg.stroke(0,100);
    pg.fill(255);
    particles[0].move_to(pg.mouseX-global.w/2,pg.mouseY-global.h/2,0);
    cl.wander();
    cl.repel();
    cl.step();
    de.synchronize();
    vo.synchronize();
    vo.render();
    cl.render();
    pg.popMatrix();
  }
  if(CLOCKING&&frameCount%100==0){
    println(100/((millis()-timer)/1000.0f));
    timer = millis();
  }
  //if(RECORDING){ mm.addFrame(); }
}
