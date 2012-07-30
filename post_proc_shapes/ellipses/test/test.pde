import processing.opengl.*;
//draw some randomly filled shapes
//access pixel data and maniuplate it, 
//blending, warping, whatever

int fg[] = new int[3];
int bg = 10;
int opac = 75, total_pts = 10;
PVector pts[];

void setup(){
  //create canvas
  size(720, 480, OPENGL);
  //define the rgb colour values
  fg[0] = 250;fg[1] = 250;fg[2] = 222;  
  Init();  
}

void draw(){
  Generate(); 
  Effects();  
}

void Generate(){
  for(int i=0;i<total_pts;i++){
    pts[i].add(random(-1,1), random(-1,1),0);
    ellipse(pts[i].x,pts[i].y,1,1);
  }
}

void Effects(){  
  Lighten();  //lighten every pixel
  //Darken();  //darken every pixel  
  Deform(); //deform shapes - find the centre of the most recent point and deform the bounding box of the shape...
}

void Lighten(){  
  loadPixels();  //load the pixel buffer
  int[] px = pixels.clone();  
  int r, g, b, col;
  for (int i=0;i<pixels.length;i++){
    col = px[i];
    r = (col >> 16) & 0xff;
    g = (col >> 8) & 0xff;
    b = col & 0xff;
    r = (r<255) ? r+=1 : r;
    g = (g<255) ? g+=1 : g;
    b = (b<255) ? b+=1 : b;
    pixels[i] = color(r, g, b);    
  }
  updatePixels(); //update the pixel buffer  
}

void Darken(){
  loadPixels();  //load the pixel buffer
  int[] px = pixels.clone();  
  int r, g, b, col;
  for (int i=0;i<pixels.length;i++){
    col = px[i];
    r = (col >> 16) & 0xff;
    g = (col >> 8) & 0xff;
    b = col & 0xff;
    r = (r>0) ? r-=1 : r;
    g = (g>0) ? g-=1 : g;
    b = (b>0) ? b-=1 : b;
    pixels[i] = color(r, g, b);    
  }
  updatePixels(); //update the pixel buffer  
}

void Deform(){
  loadPixels();  //load the pixel buffer
  int[] px = pixels.clone();  
  //offset pixel rows by a random amount  
  int r, g, b, col, loc = 0, offset = 0, row_start, row_end, new_loc;
  for (int y=0;y<height;y++){
    offset = (int)random(-5, 5);   //calculate a new offset for the row
    row_start = width*y;  //calculate the pixel value for the row start
    for (int x=0;x<width;x++){  
      loc = (x + (y*width));  //generate the location 
      col = px[loc];   //get the pixel value from the current location     
      new_loc = ((loc + offset) % width) + row_start;
      new_loc = (new_loc < 0) ? new_loc+width : new_loc;  
      //println(loc + " " + new_loc);   
      r = (col >> 16) & 0xff;
      g = (col >> 8) & 0xff;
      b = col & 0xff;
      pixels[new_loc] = color(r, g, b);   
    }  
  }
  updatePixels(); //update the pixel buffer  
}


void RandomDeform(){
}

void Init(){
  //set up the drawing context
  smooth();
  noStroke();  
  fill(fg[0], fg[1], fg[2], opac);
  background(bg);
  pts = new PVector[total_pts];
  for (int i=0;i<total_pts;i++)
    pts[i] = new PVector(random(width), random(height));
}
