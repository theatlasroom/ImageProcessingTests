import processing.opengl.*;

int img_w = 320, img_h = 394;
String img_file = "../../data/bowl_small.jpg";
PImage orig_img, img, new_img;

/* calculations
 *  
 * total pixels = width * height 
 * location = x + y * width
 */

void setup(){
  //the image is in potrait size, use a canvas of these dimensions
  size(img_w, img_h);  //setup the canvas
  orig_img = loadImage(img_file);  //load the image file
  img = loadImage(img_file);  //load the image file
  new_img = loadImage(img_file);  //load the image file    
}

void draw(){
  background(0);  //clear the background
  img.loadPixels();  //load the pixel array for this file
  new_img.loadPixels();
  int loc = 0, nloc = 0, total_px = img_w*img_h;  
  int offset = (int)random(10);
  for (int x = 0; x < img_w; x++){
    for (int y = 0; y < img_h; y++){
      loc = x+y*img_w;
      int argb = img.pixels[loc];
      int a = (argb >> 24) & 0xFF;
      int r = (argb >> 16) & 0xFF;  // Faster way of getting red(argb)
      int g = (argb >> 8) & 0xFF;   // Faster way of getting green(argb)
      int b = argb & 0xFF;          // Faster way of getting blue(argb)
      nloc = (loc+offset)%total_px;      
      new_img.pixels[nloc] = color(r, g, b, a);      
    }    
  }
  img.updatePixels();  //update the pixels array
  new_img.updatePixels();  //update the pixels array  
  image(new_img,0,0, img_w, img_h);  //draw the image to the screen
}
