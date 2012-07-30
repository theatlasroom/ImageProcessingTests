import toxi.physics2d.constraints.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.*;
import toxi.geom.*;
import toxi.math.*;

import processing.opengl.*;

//create a point in the field that is an attractor
//each particle moves along the x-axis and its y value is effected by its distance from the 'sink' point
//further radius from the centre lessens the effects

int fg[] = new int[3];
int bg = 10;
int opac = 75, total_pts = 100;
VerletPhysics2D world;
Rect world_bounds;
Vec2D[] initpts, endpts;

void setup() {
  //create canvas
  size(720, 480);
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
  float h = 57, s=11, b=0;
  int i=0; 
  world.update();  //update the world
  for (VerletParticle2D pt : world.particles) {
    b = map(i, 0, total_pts, 35, 100);
    fill(h, s, b);   
    if (!world_bounds.containsPoint(pt)) {
      world.removeParticle(pt);      
      //pt = new VerletParticle2D(initpts[i].x, initpts[i].y);
      //world.addParticle(pt);
    }    
    else
      ellipse(pt.x, pt.y, 1, 1);
    i++;
  }
}


void Init() {
  //set up the drawing context
  smooth();
  noStroke();  
  //fill(fg[0], fg[1], fg[2], opac);
  background(bg);
  //setup the world
  GenerateWorld();
}

void GenerateWorld() { 
  colorMode(HSB);  
  float yinc = (height/total_pts);
  //float y = height/4;
  float y = 0;
  world = new VerletPhysics2D();  //default world
  initpts = new Vec2D[total_pts];
  endpts = new Vec2D[total_pts];  
  println("total pts: " + total_pts);
  for (int i=0;i<total_pts;i++) {
    VerletParticle2D pt = new VerletParticle2D(1, y);
    Vec2D end_pt = new Vec2D(width, y);
    pt.addBehavior(new AttractionBehavior(end_pt, height, 10));
    world.addParticle(pt);
    initpts[i] = new Vec2D(1, y);
    endpts[i] = new Vec2D(width, y);    
    y+=yinc;     
    println(y + " " + yinc);
  }
  world_bounds = new Rect(0, 0, width, height);  
  world.setDrag(1);
  world.setWorldBounds(world_bounds);  //set the world boundary
  world.addBehavior(new ConstantForceBehavior(new Vec2D(1, 0))); //add a force from left to right
  //generate the attractor
  world.addBehavior(new AttractionBehavior(new Vec2D(width/2, height/2), 100, -5));
}

