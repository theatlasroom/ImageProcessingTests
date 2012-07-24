import processing.opengl.*;

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
  size(img_w, img_h);  //setup the canvas
  img = loadImage(img_file);  //load the image file
  new_img = loadImage(img_file);  //load the image file  
}

void draw(){
  background(0);  //clear the background
  img.loadPixels();  //load the pixel array for this file
  new_img.loadPixels();  //load the pixel array for this file  
  int loc = 0, total_px = img_w*img_h;  
  for (int x = 0; x < img_w; x++){
    for (int y = 0; y < img_h; y++){
      loc = x+y*img_w;
      int argb = img.pixels[loc];
      int a = (argb >> 24) & 0xFF;
      int r = (argb >> 16) & 0xFF;  // Faster way of getting red(argb)
      int g = (argb >> 8) & 0xFF;   // Faster way of getting green(argb)
      int b = argb & 0xFF;          // Faster way of getting blue(argb)
      //int dice = (int)random(2);
      //println(dice);
      if (dice == 0)
        new_img.pixels[loc] = color(r,g,b,a);
      else
        new_img.pixels[loc] = color(0,0,0,a);        
    }    
  }
  new_img.updatePixels();  //update the pixels array  
  image(new_img,0,0);  //draw the image to the screen
}
