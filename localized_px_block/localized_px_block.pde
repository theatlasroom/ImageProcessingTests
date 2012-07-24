import processing.opengl.*;

//int img_w = 320, img_h = 394;
int img_w = 640, img_h = 788;
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
  img.resize(img_w, img_h);
  new_img = createImage(img_w, img_h, ARGB);  //load the image file
  img.loadPixels();  //load the pixel array for this file  
}

void draw(){
  background(0);  //clear the background
  new_img.loadPixels();  //load the pixel array for this file  
  int px_block = (int)random(1, 20);  //set the block size to a random value
  int px_block_w = px_block;
  int px_block_h = px_block;
  int new_w = (int)(img_w / px_block);  //calculate new width / height based on the block size
  int new_h = (int)(img_h / px_block);  
  int loc = 0, total_px = new_w*new_h;
  int new_x, new_y;  
  int rgb, r, g, b;
  int start_x = (int)random(img_w), start_y = (int)random(img_h);  
  int end_x = (int)random(start_x,img_w), end_y = (int)random(start_y,img_h);
  //println("total " + total_px);
  for (int x = 0; x < img_w; x+=px_block){
    for (int y = 0; y < img_h; y+=px_block){  
      if (x>start_x && x<end_x && y>start_y && y<end_y){
        //only operate on pixels within the region
        if (x+px_block < img_w && (y+px_block) < img_h){
          loc = x+y*img_w;
          rgb = img.pixels[loc];  //get the argb colour value of the specified pixel
          //int a = (argb >> 24) & 0xFF;
          r = (rgb >> 16) & 0xFF;  // Faster way of getting red(argb)
          g = (rgb >> 8) & 0xFF;   // Faster way of getting green(argb)
          b = rgb & 0xFF;          // Faster way of getting blue(argb)
          //for each pixel in the block, set the value to the one taken for the first pixle 
          for (int bx=0;bx<px_block_w;bx++){
            for (int by=0;by<px_block_h;by++){
              loc = (x+bx)+(y+by)*img_w;  //use the mod of the image width / height to wrap the block around
              new_img.pixels[loc] = color(r,g,b);  //set the pix colour value
            }
          }
        }
      }
      else {
        //pixels outside the region are unchanged
        loc = x+y*img_w;
        new_img.pixels[loc] = img.pixels[loc];        
      }
    }    
  }
  //img.updatePixels();  //update the pixels array
  new_img.updatePixels();  //update the pixels array
  image(new_img,0,0, img_w, img_h);  //draw the image to the screen
}

