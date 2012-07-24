import processing.opengl.*;

boolean clear_bg_flag = true;
int img_w = 320, img_h = 394;
String img_file = "../../data/bowl_small.jpg";
PImage img, new_img;

/* calculations
 *  
 * total pixels = width * height 
 * location = x + y * width
 */

void setup(){
  //the image is in potrait size, use a canvas of these dimensions
  noStroke();
  smooth();
  noFill();
  size(img_w, img_h);  //setup the canvas
  img = loadImage(img_file);  //load the image file
  frameRate(15);  
}

//replaces each pixel with a line?

void draw(){  
  if (clear_bg_flag)
    background(0);  //clear the background  
  int loc = 0;
  int argb, r, g, b;      
  int esize = (int)random(2,10);  //set the size of each ellipse
  for (int x = 0; x < img_w; x+=esize){
    for (int y = 0; y < img_h; y+=esize){
      loc = x+y*img_w;
      argb = img.pixels[loc];
      r = (argb >> 16) & 0xFF;  // Faster way of getting red(argb)
      g = (argb >> 8) & 0xFF;   // Faster way of getting green(argb)
      b = argb & 0xFF;          // Faster way of getting blue(argb)
      //render every pixel group as a ellipse
      stroke(r,g,b, 100);
      int dice = (int)random(2);
      if (dice == 0)      
        line(x,y,x,y+(esize/2));
      //ellipse(x,y,x,y+(esize/2));
      else
        rect(x,y,esize, esize);       
    }    
  }  
}

void keyPressed(){
  if (key == 'c')
    clear_bg_flag = (clear_bg_flag) ? false : true;    //toggle the clear background flag 
}
