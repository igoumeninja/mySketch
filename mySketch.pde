/*
Visualize 23262 Greek vilages data taken from 
 
 * http://www.maxmind.com/app/worldcities
 and edit with emacs to select only greek Cities.
 
 * Import xls file with library
 http://bezier.de/processing/libs/xls/
 * Mapping the values
 * Mouse Interaction
 
 TODO
 * search tool
 
 Aris Bezas Fri, 01 October 2010, 04:03PM
 */

import de.bezier.data.*;
import processing.opengl.*;

XlsReader reader;
PFont font;
char letter;

float[] xPos = new float[23263]; 
float[] yPos = new float[23263]; 
String[] xoria = new String[23263]; 
int count, randomCell, randomCell2;
int radius=1;
boolean viewDrawGreece, viewStepByStepGreece, enaXorio,lista,viewXoria,viewXoria01,searchBool,viewMouseInteraction;
int yLista = 13;  
float yPosRand  = 13;

void setup ()
{
  size(screen.width, screen.height, OPENGL);  
  background( 0 );
  frameRate(500);
  font = createFont("Georgia", 12);  //.ttf in data folder
  textFont(font, 12);       
  smooth();
  reader = new XlsReader( this, "ellinikaXoria3colones.xls" );    
  reader.firstRow();
  reader.nextRow(); // legend
  while ( reader.hasMoreRows() )    // loop thru rows
  {
    reader.nextRow();
    xoria[count] = reader.getString();    // city name
    reader.nextCell();    // lon
    xPos[count] = lonToX( reader.getFloat() );    
    reader.nextCell();    // lat
    yPos[count] = height - latToY( reader.getFloat() ); 
    count++;
  }
}

float lonToX ( float lon ) {    
  return map( lon, 17, 31, 0, width ); 
}// convert a longitude value to screen space
float latToY ( float lat ){    
  return map( lat, 33, 43, 0, height );
}// convert a latitude value to screen space

void draw()  {
  randomCell = int(random(2,23062));  
  randomCell2 = int(random(2,23062));
  if(viewMouseInteraction)  mouseInteraction();  
  if(searchBool)  search();
  if(viewDrawGreece)  drawGreece();
  if(lista)  lista();  
  if(viewStepByStepGreece)  stepByStepGreece();
  if(viewXoria01) xoria01();
  if  (enaXorio)  {
    fill(255,250);
    text(xoria[randomCell], mouseX, mouseY);
    noFill();
    stroke(int(random(255)),int(random(255)),int(random(255)), 125);
    curve(0,0, xPos[randomCell], yPos[randomCell], mouseX, mouseY,  random(width), random(height));
    fill(255,0,0);
    ellipse(xPos[randomCell], yPos[randomCell], 9,9);
    enaXorio = false;    
  }
  fill(255, 12);
  text("Aris Bezas® Igoumeninja 2010", width/2 - 110, height - 50);  
}
void mouseInteraction()  {
  fill(0,32);
  rect(-50, -50, width+100, height+100);
  fill(255);
  noFill();
  for (int i = 0; i < 23062; i++) {
    if(abs(xPos[i]-mouseX) < 2 && abs(yPos[i]-mouseY) < 2)  {
      if  (yPosRand > height-13)  yPosRand = 13;      
      stroke(int(random(255)),int(random(255)),int(random(255)), 125);
      curve(0,height, xPos[i], yPos[i], width - 250, yPosRand,  width - 250, yPosRand);          
      text(xoria[i], width - 250, yPosRand); 
      yPosRand = yPosRand + 13;
    }
    viewMouseInteraction = false;
  }  
}

void search()  {
  for (int i = 0; i < 23062; i++) {
    char c = xoria[i].charAt(0);
    if(c == letter)  background(24);
  };  
  searchBool = false; 
}

void lista()  {
  noStroke();
  fill(0,12);
  rect(-50, -50, width+100, height+100);
  fill(255,250);
  text(xoria[randomCell], 10, yLista);
  text(xoria[randomCell2], width-100, yLista);    
  noFill();
  stroke(int(random(255)),int(random(255)),int(random(255)), 125);
  curve(0, yLista,  100, yLista,  xPos[randomCell], yPos[randomCell],random(width), random(height));
  curve(width, yLista, width - 100, yLista,  xPos[randomCell2], yPos[randomCell2],random(width), random(height));    
  fill(255,0,0);
  ellipse(xPos[randomCell], yPos[randomCell], 9,9);  
  ellipse(xPos[randomCell2], yPos[randomCell2], 9,9);      
  if (yLista > height) {
    yLista = 0;
    noStroke();
    fill(0,10);
    rect(0, 0, 400, height);
    rect(width - 100, 0, 400, height);      
  }
  yLista = yLista + 13;        
}

void drawGreece()  {
  //background(0);
  noFill();
  //stroke(int(random(255)),int(random(255)),int(random(255)));
  stroke(255);  
  for (int i = 0; i < 23262; i++) {
    ellipse(xPos[i], yPos[i], radius, radius);
  };  
}
void stepByStepGreece()  {
  noFill();
  stroke(int(random(255)),int(random(255)),int(random(255)));
  ellipse(xPos[randomCell], yPos[randomCell], radius, radius);
  if (viewXoria)  {
    noStroke();
    fill(255,2);
    text(xoria[randomCell], mouseX, mouseY);
    stroke(255,2);
    line(xPos[randomCell], yPos[randomCell],mouseX, mouseY);
  }
}

void xoria01()  {
  fill(255);
  text("0", xPos[randomCell], yPos[randomCell]);  
  text("1", xPos[randomCell2], yPos[randomCell2]);    
}

void keyPressed()  {
  if (key == '1') {
    viewStepByStepGreece = !viewStepByStepGreece;
  }
  if (key == '2') {
    enaXorio = !enaXorio;
  }
  if (key == '3') {
    viewXoria = !viewXoria;
  }
  if (key == '4') {
    viewDrawGreece = !viewDrawGreece;
  }
  if (key == '5') {
    lista = !lista;
  }
  if (key == '6') {
    viewXoria01 = !viewXoria01;
  }
  if (key == '7') {
    text("type", width/2, 10);
    searchBool = !searchBool;
  }
  if (key == '8') {
  }
  if (key == '+') {
    radius++;
  }
  if (key == '-') {
    radius--;
  }
  if (key == '0') {
    background(0);
  }
  if (key >= 'A' && key <= 'z') {
    letter = key;
  }
}

void mousePressed()  {
    viewMouseInteraction = !viewMouseInteraction;  
//    background(0);        
}



