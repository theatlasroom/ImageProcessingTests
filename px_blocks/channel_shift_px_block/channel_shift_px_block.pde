import processing.opengl.*;

//int img_w = 320, img_h = 394;
int img_w, img_h;
String img_file = "../../data/carr-kigbo-720.jpg";
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
  img = loadImage(img_file);  //load the image file
  img_w = img.width;
  img_h = img.height;
  //img.resize(img_w, img_h);
  size(img_w, img_h, P3D);  //setup the canvas  
  new_img = createImage(img_w, img_h, ARGB);  //load the image file
  img.loadPixels();  //load the pixel array for this file  
  //frameRate(20);
  background(0);
}

void draw(){
  //background(0);
  int block_size = (int)random(1, 50);  //set the block size to a random value  
  RenderRGBShiftPixelBlocks(block_size);
}

void RenderRGBShiftPixelBlocks(int block_size){    
  //renders the pixel block pixel by pixel (naive)
  //draws result to another image object which gets drawn to the screen later
  new_img.loadPixels();  //load the pixel array for this file  
  int px_block_w = block_size, px_block_h = block_size;  
  int loc = 0, rgb, r, g, b, tot_px = img_w*img_h; 
  //calculate, colour channel offsets
  int omax = 100;  
  int[] offsets = new int[3];
  int r_offset = (int)random(-omax, omax);
  int g_offset = (int)random(-omax, omax);
  int b_offset = (int)random(-omax, omax);  
  for (int x = 0; x < img_w; x+=block_size){
    for (int y = 0; y < img_h; y+=block_size){
      if (x+block_size < img_w && (y+block_size) < img_h){
        loc = x+y*img_w;
        rgb = img.pixels[loc];  //get the argb colour value of the specified pixel 
        for (int bx=0;bx<block_size;bx++){
          for (int by=0;by<block_size;by++){
            loc = (x+bx)+(y+by)*img_w;  //use the mod of the image width / height to wrap the block around
            //for each pixel in the block, set the value to the one taken for the first pixel
            //use bitshifting operations to extract the rgb components
            Render(tot_px, loc, r_offset, g_offset, b_offset, rgb);
          }
        }
      }
    }    
  }
  new_img.updatePixels();  //update the pixels array
  image(new_img,0,0, img_w, img_h);  //draw the image to the screen
}

void Render(int total_px, int loc, int roff, int goff, int boff, int rgb){
  int rloc = abs((loc+roff)%total_px);
  int gloc = abs((loc+goff)%total_px);
  int bloc = abs((loc+boff)%total_px);        
  //at location r, render the r value from rgb and keep the other values as normal in that area
  new_img.pixels[rloc] = color((rgb >> 16) & 0xFF, green(img.pixels[rloc]), blue(img.pixels[rloc]));
  new_img.pixels[gloc] = color(red(img.pixels[gloc]), (rgb >> 8) & 0xFF, blue(img.pixels[gloc]));
  new_img.pixels[bloc] = color(red(img.pixels[bloc]), green(img.pixels[bloc]), (rgb & 0xFF));    
}


