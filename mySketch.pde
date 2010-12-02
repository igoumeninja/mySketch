/*
  This program scans in a grayscale600x600 image, extracts the 
  pixel color data, and draws this data on a grid of ellipses.
  from: http://visiblevisible.org/teaching/setpixel/students/joseph_l/
  Scanning color data from pixels
  edit by Aris Bezas Thu, 02 December 2010, 13:35
*/

int step = 15, radius = 1;

void setup()  {
  size(600, 600);
  background(0);
  smooth();
}

void draw()  {} // draw void before mousePressed

void mousePressed()  {
 radius  = radius + 1;    // Radius incrementation
 drawPicture();          // Call drawPicture void every timeyou press the mouse
}

void drawPicture()  {
  int pixel_count = 0;
  PImage face = loadImage("puma.jpg");    // load image
  color pixcol;                          // variable fr pixel color
  int facecol;

  //allocate space to save the pixel information from the image
  float[][] pixel_data = new float [600][600]; //600x600=360000

  //scans through the image and saves the pixel data in an array
  if(pixel_count < 359999)  {
    for(int i=0;i<599;i++)  {              //scan each pixels on axis x
      for(int j=0;j<599;j++)  {            //scan each pixels on axis y
        pixcol = face.pixels[pixel_count];
        pixel_data[i][j] = green(pixcol);
        pixel_count++;
      }
      pixel_count++;
    }
  }

  //applies the pixel data to the circles.
  for(int i=0;i<599;i+=step)  {
    for(int j=0;j<600;j+=step)    {
      fill(pixel_data[j][i]);
      ellipse(i,j,radius, radius);
    } 
  }
}


