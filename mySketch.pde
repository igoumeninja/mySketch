/*
Memory Allocation 3D
 Aris Bezas Tue, 21 September 2010, 09:44AM
 */

import processing.opengl.*;

float[][][] xGrid = new float[64][64][64];
float[][][] yGrid = new float[64][64][64];
float[][][] zGrid = new float[64][64][64];

void setup() {
  size(screen.width, screen.height, OPENGL);
  translate(width/2, height/2);
  smooth();
  float cellX = 0, cellY = 0, cellZ = 0;
  for (int i = 0; i < 64; i++)	{
    for (int j = 0; j < 64; j++)	{
      for (int k = 0; k < 64; k++)	{
        xGrid[i][j][k] = cellX;
        yGrid[i][j][k] = cellY;			
        zGrid[i][j][k] = cellZ;							
        cellX = cellX + 20;
      }
      cellX = 0;
      cellY = cellY + 20;		
    }
    cellY = 0;
    cellZ = cellZ + 20;		
  }
}
    
void draw() {
  background(0);
  lights();
  fill(255);
  stroke(255);
  //
  beginShape(POINTS);
  for (int i = 0; i < 64; i++)	{
    for (int j = 0; j < 64; j++)	{
      for (int k = 0; k < 64; k++)	{
        vertex(xGrid[i][j][k], yGrid[i][j][k], zGrid[i][j][k]);
      }
    }
  }
  endShape();
  
  camera(2*mouseX, 2*mouseY, 2*mouseX, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ
}

void mousePressed()	{

}


