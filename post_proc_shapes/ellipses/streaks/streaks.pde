import processing.opengl.*;
//draw some randomly filled shapes
//access pixel data and maniuplate it, 
//blending, warping, whatever

int fg[] = new int[3];
int bg = 10;
int opac = 75, total_pts = 5;
PVector pts[];
PVector initpts[];
PVector params[];

void setup() {
  //create canvas
  size(720, 480, OPENGL);
  //define the rgb colour values
  fg[0] = 250;
  fg[1] = 250;
  fg[2] = 222;  
  Init();
}

void draw() {
  Generate();
}

void Generate() {  
  for (int i=0;i<total_pts;i++) {
    colorMode(HSB);
    float h = 57, s=11;
    //float b = 50;
    float b = map(i, 0, total_pts, 35, 100);
    fill(h,s,b,100);
    float x = map(pts[i].x,0,width,-10,10) * params[i].x;
    float y = map(pts[i].y,0,height,-10,10) * params[i].y;
    if (x == 0) x=random(-5,5);
    if (y == 0) y=random(-5,5);     
    PVector new_pt = new PVector(x,y,0);
    println(x + " " + y);  
    new_pt.normalize();
    pts[i].add(new_pt);  
    if (pts[i].x > width || pts[i].x < 0 || pts[i].y > height || pts[i].y < 0){
      initpts[i].add(new PVector(random(-5,5), random(-5,5)));  
      pts[i] = new PVector(initpts[i].x, initpts[i].y);
      params[i].add(new PVector(random(-5,5), random(-5,5)));;      
    }    
    //use the equations for a henon attractor        
    ellipse(pts[i].x, pts[i].y, 1, 1);
  }
}


void Init() {
  //set up the drawing context
  smooth();
  noStroke();  
  fill(fg[0], fg[1], fg[2], opac);
  background(bg);
  initpts = new PVector[total_pts];  
  pts = new PVector[total_pts];
  params = new PVector[total_pts];  
  for (int i=0;i<total_pts;i++) {
    initpts[i] = new PVector(random(width/4,width/4+width/2),random(height/4, height/4+height/2));
    //initpts[i] = new PVector(random(width),random(height));    
    pts[i] = new PVector(initpts[i].x, initpts[i].y);    
    params[i] = new PVector(random(-10,10), random(-10,10));  //these form the a and b vars for the henon attractor
  }
}

