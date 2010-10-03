import processing.opengl.*;

float[][] xControlPoints;
float[][] yControlPoints;
int controlPoints = 10;
float xCount, yCount, xStep, yStep;

void setup()  {
  size(600,600, OPENGL);
  xStep = width/controlPoints;
  yStep = height/controlPoints;  
  background(0);
  for (int i = 1; i < controlPoints-1; i++)  {
    for (int j = 1; j < controlPoints-1; j++)  {
      xControlPoints[i][j] = xCount;
      yControlPoints[i][j] = yCount;
      xCount = xCount + xStep;      
    }
  }  
  xCount = 0;
  yCount = yCount + yStep;
}

void draw()  {
  
}

void keyPressed()  {
  
}
