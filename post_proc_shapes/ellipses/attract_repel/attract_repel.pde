import processing.opengl.*;
//create a point in the field that is an attractor
//each particle moves along the x-axis and its y value is effected by its distance from the 'sink' point
//further radius from the centre lessens the effects

int fg[] = new int[3];
int bg = 10;
int opac = 75, total_pts = 50;
PVector pts[], initpts[];
PVector attractor;
float force_at_centre;

void setup() {
  //create canvas
  size(720, 480, OPENGL);
  total_pts = height;
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
    float h = 57, s=11, b = map(i, 0, total_pts, 35, 100);
    stroke(h,s,b,100);   
    float newy = Attract(pts[i]) + pts[i].y;
    float newx = pts[i].x+1;
    if (newx >= width || (newy > height || newy < 0)){
      pts[i] = new PVector(0, initpts[i].y);
    }
    else {
      pts[i] = new PVector(newx, newy);
    } 
    println(newx + " " + newy);
    //line(prev.x, prev.y, pts[i].x, pts[i].y);   
    ellipse(pts[i].x, pts[i].y, 1, 1);
  }
}


void Init() {
  //set up the drawing context
  smooth();
  noStroke();  
  fill(fg[0], fg[1], fg[2], opac);
  background(bg);
  GenerateAttractor();
  GeneratePoints();
}

void GenerateAttractor(){
  attractor = new PVector(width/2, height/2);
  force_at_centre = 10; 
}

void GeneratePoints(){
  pts = new PVector[total_pts];
  initpts = new PVector[total_pts];  
  for (int i=0;i<total_pts;i++){
    pts[i] = new PVector(0, (height/total_pts)*i);
    initpts[i] = new PVector(0, (height/total_pts)*i);
  }
}

float Attract(PVector pt){
  //return the new y value based on the current points distance from the centre of the attractor
  float y_dist = 0, new_y;
  if (pt.y < attractor.y){
    y_dist = attractor.y - pt.y;
    new_y = y_dist/100;
  }
  else {    
    y_dist = pt.y - attractor.y;
    new_y = (y_dist/100)*-1;    
  }
  return new_y;  
}


float Repel(PVector pt){
  //return the new y value based on the current points distance from the centre of the attractor
  float y_dist = 0, new_y;
  if (pt.y < attractor.y){
    y_dist = attractor.y - pt.y;
    new_y = y_dist/100*-1;
  }
  else {    
    y_dist = pt.y - attractor.y;
    new_y = (y_dist/100);    
  }
  return new_y;  
}

