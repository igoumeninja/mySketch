float[][] xGrid = new float[64][64];
float[][] yGrid = new float[64][64];
PFont font;

void setup() {
  size(600, 600);
  smooth();
  background(0);
  font = createFont("Arial", 12);  //.ttf in data folder
  textFont(font, 12);   
  float cellX = 0, cellY = 0;
  for (int i = 0; i < 64; i++)	{
    for (int j = 0; j < 64; j++)	{
      xGrid[i][j] = cellX;
      yGrid[i][j] = cellY;			
      cellX = cellX + 14;
    }
    cellX = 0;
    cellY = cellY + 14;		
  }
}

void draw() {
  for (int t = 0; t < 1; t++)	{
    int x1i = int(random(0,63));
    int x1j = int(random(0,63));			
    int x2i = int(random(0,63));			
    int x2j = int(random(0,63));			
    int y1i = int(random(0,63));			
    int y1j = int(random(0,63));			
    int y2i = int(random(0,63));																		
    int y2j = int(random(0,63));						
    fill(255,145);	
    text("0", xGrid[x1i][x1j], yGrid[y1i][y1j]);
    text("1", xGrid[x2i][x2j], yGrid[y2i][y2j]);		
    stroke(255,7);			
    line(xGrid[x1i][x1j], yGrid[y1i][y1j], xGrid[x2i][x2j], yGrid[y2i][y2j]);	
    if	(y1i < 40 && y1j < 40)	{							
      stroke(50+mouseX, mouseY-100,0,21);			
      line(mouseX, mouseY, xGrid[x1i][x1j], yGrid[y1i][y1j]);
    }
  }

}

void mousePressed()	{
  background(0);
}
void mouseMoved()	{
  fill(0,1);
  rect(-20,-20,1600,1000);
}

