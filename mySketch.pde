/*
100909 igoumeninja
Aris Bezas

Try to visualize ampeli.
*/

import processing.opengl.*;
import processing.pdf.*;

int numPoikilies = 21;
boolean eraseBack = true;

float XpremnouStart = 50, YpremnouStart = 50;
float Xpremnou = 50, Ypremnou = 50;
float XpremnouStep = 30, YpremnouStep = 50;
int seires = 8, steiles = 34;
float diametros = 25, diametrosLabel = 5;
PFont font;
float[][] Xpos = new float[8][34];
float[][] Ypos = new float[8][34];
String[] Poikilies= new String[numPoikilies];
color[] Xromata = new color[numPoikilies];


void setup()  {
  size(1200, 800, OPENGL);
  rectMode(CORNER);
 // beginRecord(PDF, "Ampeli.pdf");
  smooth();
  background(25);  
  
  //font = loadFont("Monaco-12.vlw");  
  font = createFont("Andale Mono", 12);  //.ttf in data folder
  //hint(ENABLE_NATIVE_FONTS);
  textFont(font, 12);       
  
  xromata();
  poikiliesOnomata();
  XpremnouStart = width - (width/2 + steiles/2*XpremnouStep );
  labels();
  drawAmpeli(); 

  //endRecord();
 
}

void draw()  {
  if (eraseBack)  {
    fill(25,160);
    rect(-20,-20,width+50, height+50);
    labels();
    drawAmpeli();     
  }

  // Activate text with drawing lines
  stroke(255, 25);
  if (mouseX > (XpremnouStart) & mouseX < (XpremnouStart+ 100) & mouseY > (YpremnouStart*(seires+4) + 25) & mouseY < (YpremnouStart*(seires+4) + 25 + 20))  {   
    for  (int i = 0; i < 3; i++ )  {
      for  (int j = 4; j < steiles; j++)  {
        fill(255);        
        ellipse(Xpos[i][j], Ypos[i][j], diametros + 3, diametros + 3);
        fill(0);
        ellipse(Xpos[i][j], Ypos[i][j], diametros/2, diametros/2);
        fill(255);
        ellipse(Xpos[i][j], Ypos[i][j], diametros/5, diametros/5); 
        stroke(255, 55);
        noFill();
        curve(XpremnouStart, YpremnouStart*(seires+4) , XpremnouStart, YpremnouStart*(seires+4) + 25, Xpos[i][j], Ypos[i][j], 0, 0);        
      }
    }
    Xromata[0] = #FFFFFF;
    labels();    
  }  else  {
    xromata();
  }
}

void   drawAmpeli()  {
  Xpremnou = XpremnouStart;
  Ypremnou = YpremnouStart;  
  stroke(255);
  for (int i = 0; i < seires; i++)  {
    for (int j = 0; j < steiles; j++)  {
      // Arxiki spora 2007 Martios
      if      (i == 0 & j < 2)           {        fill(#FF0000);      } // Monastrello  
      else if (i == 0 & j >= 2 & j < 4)  {        fill(#00FF00);      } // Mazuelo  
      else if (j == 0 & i >= 1 & i < 3)  {        fill(#FF8500);      } // Viura  
      else if (j == 1 & i >= 1 & i < 3)  {        fill(#FF377B);      } // Albariño 
      else if (j == 2 & i >= 1 & i < 3)  {        fill(#7590F7);      } // Petit Verdot 
      else if (j == 3 & i >= 1 & i < 3)  {        fill(#622634);      } // Cabernet Sauvignon 
      else if (j == 0 & i >= 3 & i < 5)  {        fill(#FFFF00);      } // Cayetana
      else if (j == 0 & i >= 5 & i < 8)  {        fill(#7C9FB9);      } // Pedro Himenez
      else if (j == 1 & i >= 3 & i < 5)  {        fill(#0000FF);      } // Garnacha Rioja
      else if (j == 1 & i >= 5 & i < 7)  {        fill(#EAB780);      } // Airen
      else if (i == 7 & j >= 1 & j < 3)  {        fill(#DCEA80);      } // Savignon Blanc
      else if (i == 7 & j >= 3 & j < 5)  {        fill(#B1ABF2);      } // Syrah
      else if (j == 2 & i >= 3 & i < 5)  {        fill(#596395);      } // Bobal      
      else if (j == 2 & i >= 5 & i < 7)  {        fill(#E000FF);      } // Verdejo      
      else if (j == 3 & i >= 3 & i < 5)  {        fill(#649559);      } // Tempranillo      
      else if (j == 3 & i >= 5 & i < 7)  {        fill(#955964);      } // Garnacha Blanca      
      else if (j == 4 & i >= 5 & i < 7)  {        fill(#DB7337);      } // Chardonay           
      else if (i == 3 & j >= 24 & j < 35){        fill(#3D47AD);      } // Mosxato                 
      else if (i == 7 & j >= 9 & j < 34)  {       fill(#7BDB37);      } // Asyrtiko                 
      else if (i == 6 & j >= 9 & j < 34)  {       fill(#7BDB37);      } // Asyrtiko                 
      else if (i == 5 & j >= 9 & j < 34)  {       fill(#FC3D4A);      } // Cabernet Franc                       
      else if (i == 4 & j >= 9 & j < 34)  {       fill(#FC3D4A);      } // Cabernet Franc                       
      else if (i == 3 & j >= 9 & j < 34)  {       fill(#FC3D4A);      } // Cabernet Franc                             
      else  {                                     fill(#B2F3FF);      } // Agiorgitiko
      //Apoleies apo katagrafi 2010
      if      (j == 0 & i >= 6 & i < 8)           {        fill(#000000);      } 
      if      (i == 7 & j >= 3 & j < 5)           {        fill(#000000);      } 
      if      (i == 7 & j >= 6 & j < 8)           {        fill(#000000);      } 
      if      (i == 7 & j == 1)                   {        fill(#000000);      } 
      if      (i == 0 & j == 3)                   {        fill(#000000);      } 
      if      (i == 6 & j == 8)                   {        fill(#000000);      } 
      if      (i == 6 & j == 10)                  {        fill(#000000);      } 

      
      ellipse(Xpremnou, Ypremnou, diametros, diametros);
      fill(0);
      ellipse(Xpremnou, Ypremnou, diametros/2, diametros/2);
      fill(255);
      ellipse(Xpremnou, Ypremnou, diametros/5, diametros/5);      
      Xpos[i][j] = Xpremnou;
      Ypos[i][j] = Ypremnou;
      //println(Xpos[0][0]);
      Xpremnou = Xpremnou + XpremnouStep;
    }
    Xpremnou = XpremnouStart;
    Ypremnou = Ypremnou + YpremnouStep;
  }
}

void   labels()  {
    noStroke();
    fill(Xromata[0]);   
    ellipse(XpremnouStart, YpremnouStart*(seires+4) + 25, diametrosLabel, diametrosLabel);
    text(Poikilies[0], XpremnouStart + 10, YpremnouStart*(seires+4) + 28);
    fill(Xromata[1]);   
    ellipse(XpremnouStart, YpremnouStart*(seires+4) + 50 + 0*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[1], XpremnouStart + 10, YpremnouStart*(seires+4) + 55 + 0*YpremnouStep/2);
    fill(Xromata[2]);   
    ellipse(XpremnouStart, YpremnouStart*(seires+4) + 50 + 1*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[2], XpremnouStart + 10, YpremnouStart*(seires+4) + 55 + 1*YpremnouStep/2);
    fill(Xromata[3]);   
    ellipse(XpremnouStart, YpremnouStart*(seires+4) + 50 + 2*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[3], XpremnouStart + 10, YpremnouStart*(seires+4) + 55 + 2*YpremnouStep/2);
    fill(Xromata[4]);   
    ellipse(XpremnouStart, YpremnouStart*(seires+4) + 50 + 3*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[4], XpremnouStart + 10, YpremnouStart*(seires+4) + 55 + 3*YpremnouStep/2);
    fill(0);   
    ellipse(XpremnouStart, YpremnouStart*(seires+4) + 50 + 4*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text("Missing", XpremnouStart + 10, YpremnouStart*(seires+4) + 55 + 4*YpremnouStep/2);
    fill(Xromata[5]);   
    ellipse(XpremnouStart + 100, YpremnouStart*(seires+4) + 50 + 0*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[5], XpremnouStart + 10 + 100, YpremnouStart*(seires+4) + 55 + 0*YpremnouStep/2);
    fill(Xromata[6]);   
    ellipse(XpremnouStart + 100, YpremnouStart*(seires+4) + 50 + 1*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[6], XpremnouStart + 10 + 100, YpremnouStart*(seires+4) + 55 + 1*YpremnouStep/2);
    fill(Xromata[7]);   
    ellipse(XpremnouStart + 100, YpremnouStart*(seires+4) + 50 + 2*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[7], XpremnouStart + 10 + 100, YpremnouStart*(seires+4) + 55 + 2*YpremnouStep/2);
    fill(Xromata[8]);   
    ellipse(XpremnouStart + 100, YpremnouStart*(seires+4) + 50 + 3*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[8], XpremnouStart + 10 + 100, YpremnouStart*(seires+4) + 55 + 3*YpremnouStep/2);
    fill(Xromata[9]);   
    ellipse(XpremnouStart + 250, YpremnouStart*(seires+4) + 50 + 0*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[9], XpremnouStart + 10 + 250, YpremnouStart*(seires+4) + 55 + 0*YpremnouStep/2);
    fill(Xromata[10]); 
    ellipse(XpremnouStart + 250, YpremnouStart*(seires+4) + 50 + 1*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[10], XpremnouStart + 10 + 250, YpremnouStart*(seires+4) + 55 + 1*YpremnouStep/2);
    fill(Xromata[11]); 
    ellipse(XpremnouStart + 250, YpremnouStart*(seires+4) + 50 + 2*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[11], XpremnouStart + 10 + 250, YpremnouStart*(seires+4) + 55 + 2*YpremnouStep/2);
    fill(Xromata[12]); 
    ellipse(XpremnouStart + 250, YpremnouStart*(seires+4) + 50 + 3*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[12], XpremnouStart + 10 + 250, YpremnouStart*(seires+4) + 55 + 3*YpremnouStep/2);
    fill(Xromata[13]); 
    ellipse(XpremnouStart + 375, YpremnouStart*(seires+4) + 50 + 0*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[13], XpremnouStart + 10 + 375, YpremnouStart*(seires+4) + 55 + 0*YpremnouStep/2);
    fill(Xromata[14]); 
    ellipse(XpremnouStart + 375, YpremnouStart*(seires+4) + 50 + 1*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[14], XpremnouStart + 10 + 375, YpremnouStart*(seires+4) + 55 + 1*YpremnouStep/2);
    fill(Xromata[15]); 
    ellipse(XpremnouStart + 375, YpremnouStart*(seires+4) + 50 + 2*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[15], XpremnouStart + 10 + 375, YpremnouStart*(seires+4) + 55 + 2*YpremnouStep/2);
    fill(Xromata[16]); 
    ellipse(XpremnouStart + 375, YpremnouStart*(seires+4) + 50 + 3*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[16], XpremnouStart + 10 + 375, YpremnouStart*(seires+4) + 55 + 3*YpremnouStep/2);
    fill(Xromata[17]);  
    ellipse(XpremnouStart + 520, YpremnouStart*(seires+4) + 50 + 0*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[17], XpremnouStart + 10 + 520, YpremnouStart*(seires+4) + 55 + 0*YpremnouStep/2);
    fill(Xromata[18]);  
    ellipse(XpremnouStart + 520, YpremnouStart*(seires+4) + 50 + 1*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[18], XpremnouStart + 10 + 520, YpremnouStart*(seires+4) + 55 + 1*YpremnouStep/2);
    fill(Xromata[19]);      
    ellipse(XpremnouStart + 520, YpremnouStart*(seires+4) + 50 + 2*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[19], XpremnouStart + 10 + 520, YpremnouStart*(seires+4) + 55 + 2*YpremnouStep/2);
    fill(Xromata[20]);      
    ellipse(XpremnouStart + 520, YpremnouStart*(seires+4) + 50 + 3*YpremnouStep/2, diametrosLabel, diametrosLabel);
    text(Poikilies[20], XpremnouStart + 10 + 520, YpremnouStart*(seires+4) + 55 + 3*YpremnouStep/2);
}
 
void keyPressed()  {
  if (key == 'b' || key == 'B') {
    noFill();
    stroke(255, 5);
    for  (int i = 0; i < seires; i++ )  {
      for  (int j = 0; j < steiles; j++)  {
        curve(random(width), random(height), Xpos[7][0], Ypos[7][0], Xpos[i][j], Ypos[i][j], random(width), random(height));
      }
    }    
  }
  if (key == 's' || key == 'S') {
//    noFill();
//    stroke(255, 5);
    for  (int i = 0; i < numPoikilies; i++ )  {
      fill(Xromata[i]);
      text(Poikilies[i], random(width), random(height));      
    }    
  }
  if (key == 'a' || key == 'A') {
    drawAmpeli();
  }
  
  if (key == 'l' || key == 'L') {
    labels();
  }
  
  if (key == 'q') {
    eraseBack = true;
  }
  if (key == 'Q') {
    eraseBack = false;
  }
  if (key == 'c' || key == 'C') {
    for  (int i = 0; i < seires; i++ )  {
      for  (int j = 0; j < steiles; j++)  {
        fill(Xromata[int(random(20))]);        
        ellipse(Xpos[i][j], Ypos[i][j], diametros, diametros);
        fill(0);
        ellipse(Xpos[i][j], Ypos[i][j], diametros/2, diametros/2);
        fill(255);
        ellipse(Xpos[i][j], Ypos[i][j], diametros/5, diametros/5);              
      }
    }
  }    
}
void xromata()  {
  Xromata[0] =  #B2F3FF;       // Agiorgitiko
  Xromata[1] =  #FF0000;       // Monastrello  
  Xromata[2] =  #00FF00;       // Mazuelo  
  Xromata[3] =  #FF8500;       // Viura  
  Xromata[4] =  #FF377B;       // Albariño 
  Xromata[5] =  #7590F7;       // Petit Verdot 
  Xromata[6] =  #622634;       // Cabernet Sauvignon 
  Xromata[7] =  #FFFF00;       // Cayetana
  Xromata[8] =  #7C9FB9;       // Pedro Himenez
  Xromata[9] =  #0000FF;       // Garnacha Rioja
  Xromata[10] = #EAB780;       // Airen
  Xromata[11] = #DCEA80;       // Savignon Blanc
  Xromata[12] = #B1ABF2;       // Syrah
  Xromata[13] = #596395;       // Bobal      
  Xromata[14] = #E000FF;       // Verdejo      
  Xromata[15] = #649559;       // Tempranillo      
  Xromata[16] = #955964;       // Garnacha Blanca      
  Xromata[17] = #DB7337;       // Chardonay           
  Xromata[18] = #3D47AD;       // Mosxato                 
  Xromata[19] = #7BDB37;       // Asyrtiko                 
  Xromata[20] = #FC3D4A;       // Cabernet Franc                       
}
void poikiliesOnomata()  {
  Poikilies[0] = "Agiorgitiko";
  Poikilies[1] = "Monastrello";
  Poikilies[2] = "Mazuelo";  
  Poikilies[3] = "Viura";  
  Poikilies[4] = "Albariño"; 
  Poikilies[5] = "Petit Verdot"; 
  Poikilies[6] = "Cabernet Sauvignon"; 
  Poikilies[7] = "Cayetana";
  Poikilies[8] = "Pedro Himenez";
  Poikilies[9] = "Garnacha Rioja";
  Poikilies[10] = "Airen";
  Poikilies[11] = "Savignon Blanc";
  Poikilies[12] = "Syrah";
  Poikilies[13] = "Bobal";      
  Poikilies[14] = "Verdejo";      
  Poikilies[15] = "Tempranillo";      
  Poikilies[16] = "Garnacha Blanca";      
  Poikilies[17] = "Chardonay";           
  Poikilies[18] = "Mosxato";                 
  Poikilies[19] = "Asyrtiko";                 
  Poikilies[20] = "Cabernet Franc";                       
}


