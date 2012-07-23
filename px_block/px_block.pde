import processing.opengl.*;

int img_w = 320, img_h = 394;
String img_file = "../data/bowl_small.jpg";
PImage img, new_img;

//this breaks the image into blocks of a specified size
//each block takes on the colour value of the first pixel in the block

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
  img.loadPixels();  //load the pixel array for this file  
}

void draw(){
  background(0);  //clear the background
  new_img.loadPixels();  //load the pixel array for this file  
  int px_block = (int)random(1, 40);  //set the block size to a random value
  int new_w = (int)(img_w / px_block);  //calculate new width / height based on the block size
  int new_h = (int)(img_h / px_block);  
  int loc = 0, total_px = new_w*new_h;  
  //println("total " + total_px);
  for (int x = 0; x < img_w; x+=px_block){
    for (int y = 0; y < img_h; y+=px_block){
      //println(x + " " + y + " " + img_w + " " + img_h);      
      loc = x+y*img_w;
      int argb = img.pixels[loc];  //get the argb colour value of the specified pixel
      int a = (argb >> 24) & 0xFF;
      int r = (argb >> 16) & 0xFF;  // Faster way of getting red(argb)
      int g = (argb >> 8) & 0xFF;   // Faster way of getting green(argb)
      int b = argb & 0xFF;          // Faster way of getting blue(argb)
      //for each pixel in the block, set the value to the one taken for the first pixle 
      for (int bx=0;bx<px_block;bx++){
        for (int by=0;by<px_block;by++){  
          loc = ((x+bx)%img_w)+((y+by)%img_h)*img_w;  //use the mod of the image width / height to wrap the block around
          new_img.pixels[loc] = color(r,g,b,a);  //set the pix colour value
        }
      }
    }    
  }
  //img.updatePixels();  //update the pixels array
  new_img.updatePixels();  //update the pixels array
  image(new_img,0,0);  //draw the image to the screen
}
