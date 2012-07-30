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
}

void draw(){
  int block_size = (int)random(1, 50);  //set the block size to a random value
  int px_offset = (int)random(1, 20);  //set the block size to a random value  
  RenderPixelOffsetBlocks(block_size, px_offset);
}

void RenderBlocks(int block_size){
  //would be quicker to render a rectangle at the point instead of pixel by pixel rendering
  background(0);
  int px_block_w = block_size;
  int px_block_h = block_size;  
  int loc = 0;  
  int rgb, r, g, b; 
  noStroke();
  for (int x = 0; x < img_w; x+=block_size){
    for (int y = 0; y < img_h; y+=block_size){
      if (x+block_size < img_w && (y+block_size) < img_h){
        loc = x+y*img_w;
        rgb = img.pixels[loc];  //get the argb colour value of the specified pixel
        fill(rgb);        
        rect(x, y, block_size, block_size);
      }
    }    
  }  
}

void RenderPixelBlocks(int block_size){    
  //renders the pixel block pixel by pixel (naive)
  //draws result to another image object which gets drawn to the screen later
  new_img.loadPixels();  //load the pixel array for this file  
  int px_block_w = block_size, px_block_h = block_size;  
  int loc = 0, rgb, r, g, b;  
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
            new_img.pixels[loc] = color((rgb >> 16) & 0xFF,(rgb >> 8) & 0xFF,rgb & 0xFF);  //set the pix colour value
          }
        }
      }
    }    
  }
  new_img.updatePixels();  //update the pixels array
  image(new_img,0,0, img_w, img_h);  //draw the image to the screen
}

void RenderPixelOffsetBlocks(int block_size, int offset){    
  //renders the pixel block pixel by pixel (naive)
  //draws result to another image object which gets drawn to the screen later
  new_img.loadPixels();  //load the pixel array for this file  
  int px_block_w = block_size, px_block_h = block_size;  
  int loc = 0, rgb, r, g, b;  
  int tot_px = img_w*img_h;
  for (int x = 0; x < img_w; x+=block_size){
    for (int y = 0; y < img_h; y+=block_size){
      if (x+block_size < img_w && (y+block_size) < img_h){
        loc = x+y*img_w;
        rgb = img.pixels[loc];  //get the argb colour value of the specified pixel 
        for (int bx=0;bx<px_block_w;bx++){
          for (int by=0;by<px_block_h;by++){
            loc = (x+bx)+(y+by)*img_w;  //use the mod of the image width / height to wrap the block around
            loc += offset;
            loc %= tot_px; 
            //for each pixel in the block, set the value to the one taken for the first pixel
            //use bitshifting operations to extract the rgb components 
            new_img.pixels[loc] = color((rgb >> 16) & 0xFF,(rgb >> 8) & 0xFF,rgb & 0xFF);  //set the pix colour value
          }
        }
      }
    }    
  }
  new_img.updatePixels();  //update the pixels array
  image(new_img,0,0, img_w, img_h);  //draw the image to the screen
}


void RenderRandomPixelOffsetBlocks(int block_size){    
  //renders the pixel block pixel by pixel (naive)
  //draws result to another image object which gets drawn to the screen later
  //the results are drawn in a semi random place in the new image
  new_img.loadPixels();  //load the pixel array for this file  
  int px_block_w = block_size, px_block_h = block_size;  
  int loc = 0, rgb, r, g, b;  
  int tot_px = img_w*img_h;
  for (int x = 0; x < img_w; x+=block_size){
    for (int y = 0; y < img_h; y+=block_size){
      if (x+block_size < img_w && (y+block_size) < img_h){
        loc = x+y*img_w;
        rgb = img.pixels[loc];  //get the argb colour value of the specified pixel 
        for (int bx=0;bx<px_block_w;bx++){
          for (int by=0;by<px_block_h;by++){
            loc = (x+bx)+(y+by)*img_w;  //use the mod of the image width / height to wrap the block around
            //loc += offset;
            //loc %= tot_px; 
            //for each pixel in the block, set the value to the one taken for the first pixel
            //use bitshifting operations to extract the rgb components 
            new_img.pixels[loc] = color((rgb >> 16) & 0xFF,(rgb >> 8) & 0xFF,rgb & 0xFF);  //set the pix colour value
          }
        }
      }
    }    
  }
  new_img.updatePixels();  //update the pixels array
  image(new_img,0,0, img_w, img_h);  //draw the image to the screen
}
