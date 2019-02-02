Ball ball;
Box box;
float i;
PVector wind = new PVector(0.01,0);
PVector gravity = new PVector(0,0.2,0);
float rx = 0, ry = 0, rz = 0;
void setup(){
  size(800,800,P3D);
  box = new Box();
  ball = new Ball();
 
}
void draw(){


  background(127,127,127);
  translate(width/2, height/2, 0);
  rotateX(rx);
  rotateY(ry);
  rotateZ(rz);
  if(keyPressed && keyCode == UP){
    rx += 0.01;
  }
  if(keyPressed && keyCode == DOWN){
    rx -= 0.01;
  }
  if(keyPressed && keyCode == LEFT){
    ry -= 0.01;
  }
  if(keyPressed && keyCode == RIGHT){
    ry += 0.01;
  }
 
 
  lights();
  float dz = map(mouseY, 0, height, -0.1, 0.1);
  float dx = map(mouseX, 0, width, -0.1, 0.1);
  wind = new PVector(dx, 0);

  if(mousePressed && keyPressed && keyCode == SHIFT){
    wind = new PVector(dx,0,dz);
  }
  if(mousePressed){
    ball.applyForce(wind);
  }

  box.display();

  
  ball.applyForce(gravity);
  ball.checkEdges();
  ball.update();
  ball.display();
  
  
}
class Box{
  float hit = 0;
  void display(){

    // x right
 
    beginShape(QUADS);
    stroke(0);
    if(box.hit == 1){
      fill(255,0,0,150);
    }else{
      noFill();
    }
    vertex( 150, -150,  150, 0, 0); 
    vertex( 150, -150, -150, 150, 0); 
    vertex( 150,  150, -150, 150, 150); 
    vertex( 150,  150,  150, 0, 150); 
    endShape();
  
    beginShape(QUADS);
    stroke(0);
    if(box.hit == 2){
      fill(255,0,0,150);
    }else{
      noFill();
    }    
    // x left
    vertex(-150, -150, -150, 0, 0); 
    vertex(-150, -150,  150, 150, 0); 
    vertex(-150,  150,  150, 150, 150); 
    vertex(-150,  150, -150, 0, 150); 
    endShape();
    
    beginShape(QUADS);
    stroke(0);
    if(box.hit == 3){
      fill(255,0,0,150);
    }else{
      noFill();
    }     
    // y bottom 
    vertex(-150,  150,  150, 0, 0); 
    vertex( 150,  150,  150, 150, 0); 
    vertex( 150,  150, -150, 150, 150); 
    vertex(-150,  150, -150, 0, 150); 

    endShape();
    
    beginShape(QUADS);
    stroke(0);
    if(box.hit == 4){
      fill(255,0,0,150);
    }else{
      noFill();
    }  
    // y top
    vertex(-150, -150, -150, 0, 0); 
    vertex( 150, -150, -150, 150, 0); 
    vertex( 150, -150,  150, 150, 150); 
    vertex(-150, -150,  150, 0, 150);
    endShape();
    
    beginShape(QUADS);
    stroke(0);
    if(box.hit == 5){
      fill(255,0,0,150);
    }else{
      noFill();
    }    
    // z front
    vertex(-150,-150,150,0,0);
    vertex(150,-150,150,150,0);
    vertex(150,150,150,150,150);
    vertex(-150,150,150,0,150);
    endShape();
   
    beginShape(QUADS);
    stroke(0);
    if(box.hit == 6){
      fill(255,0,0,150);
    }else{
      noFill();
    }     
    // z back
    vertex(150,-150,-150,0,0);
    vertex(-150,-150,-150,150,0);
    vertex(-150,150,-150,150,150);
    vertex(150,150,-150,0,150);
    endShape();

  }
}

class Ball{
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float radius;
  float mass;
  
  Ball(){
    velocity = new PVector(0,0.2,0);
    acceleration = new PVector(0,0,0);
    mass = 1.1;
    radius = mass * 20.0;
    location = new PVector(0,0,0);
  }
  void applyForce(PVector force){
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  void update(){
    velocity.add(acceleration); 
    location.add(velocity);
    acceleration.mult(0);
  }
  void display(){
    pushMatrix();
    translate(location.x,location.y,location.z);
    rectMode(CENTER);
    fill(0,200,10);
    noStroke();
    lights();
    sphere(radius);
    popMatrix();
  }
  
  void checkEdges(){
    if(location.x + radius > 150){
      location.x = 150 - radius;
      velocity.x *= -1;
      box.hit = 1;
    }
    if(location.x - radius < -150){
      location.x = -150 + radius;
      velocity.x *= -1;
      box.hit = 2;
    }
    if(location.y + radius > 150){
      location.y = 150 - radius;
      velocity.y *= -1;
      box.hit = 3;
    }
    if(location.y - radius < -150){
      location.y = -150 + radius;
      velocity.y *= -1;
      box.hit = 4;
    }
    if(location.z + radius > 150){
      location.z = 150 - radius;
      velocity.z *= -1;
      box.hit = 5;
    }
    if(location.z - radius < -150){
      location.z = -150 + radius;
      velocity.z *= -1;
      box.hit = 6;
    }
  }
}
