import processing.opengl.*;

int controlPoints = 50;
float[][] xControlPoints = new float[controlPoints][controlPoints];
float[][] yControlPoints = new float[controlPoints][controlPoints];

void setup()  {
  size(600,600, OPENGL);
  frameRate(2);
  float xStep = width/controlPoints;
  float yStep = height/controlPoints;  
  background(0);
  stroke(255);
  fill(255);
  noFill();
  float xCount = 0, yCount = 0;  
  for (int i = 0; i < controlPoints; i++)  {
    for (int j = 0; j < controlPoints; j++)  {
      xControlPoints[i][j] = xCount;
      yControlPoints[i][j] = yCount;
      xCount = xCount + xStep;      
    }
  xCount = 0;
  yCount = yCount + yStep;
  }    
}

void draw()  {
  for (int i = 0; i < controlPoints; i++)  {
    beginShape();
    for (int j = 0; j < controlPoints; j++)  {
      curveVertex(xControlPoints[i][j], yControlPoints[i][j]);
    }
    endShape();
  }  
  
}

void keyPressed()  {

}

