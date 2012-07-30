import processing.opengl.*;

boolean clear_bg_flag = false;
//int img_w = 320, img_h = 394;
int img_w=0, img_h=0;
String img_file = "../../data/carr-kigbo-720.jpg";
PImage img, new_img;

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
  noStroke();
  noFill();
  size(img_w, img_h, P3D);  //setup the canvas
  frameRate(20);   
}

void draw(){
  if (clear_bg_flag)
    background(0);  //clear the background  
  int loc = 0,argb, r, g, b;      
  int esize = (int)random(2,20);  //set the size of each ellipse
  for (int x = 0; x < img_w; x+=esize){
    for (int y = 0; y < img_h; y+=esize){
      loc = x+y*img_w;
      argb = img.pixels[loc];
      if (loc % 100 == 0)
        fill(0,0,0);
      else
        fill((argb >> 16) & 0xFF, (argb >> 8) & 0xFF, argb & 0xFF);
      ellipse(x,y,esize,esize);      
      /*stroke((argb >> 16) & 0xFF, (argb >> 8) & 0xFF, argb & 0xFF);
      line(x,y,x,y+esize);*/      
    }    
  }  
  saveFrame("data/####.tiff");
}

void keyPressed(){
  if (key == 'c')
    clear_bg_flag = (clear_bg_flag) ? false : true;    //toggle the clear background flag 
}
