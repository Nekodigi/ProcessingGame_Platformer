//How to use: a/d key to move red bar. Arrow key to move blue bar.
//This version is very simplified and never game over. But how long you can keep ball?


Ball ball;
Player A;
Player B;

void setup(){
  size(500, 500);
  ball = new Ball(new PVector(width/2, height/2), new PVector(random(-5, 5), 2), 20);
  Goal Agoal = new Goal(10, 150);
  A = new Player(height-50, 100, Agoal);
  Goal Bgoal = new Goal(height-10, 150);
  B = new Player(50, 100, Bgoal);
}

void keyPressed(){
  if(key == 'a'){
    A.pos.x -=30;
  }
  if(key == 'd'){
    A.pos.x += 30;
  }
  
  if(keyCode == LEFT){
    B.pos.x -=30;
  }
  if(keyCode == RIGHT){
    B.pos.x += 30;
  }
}

void draw(){
  background(255);
  
  ball.update();
  ball.show();
  fill(255, 0, 0);
  A.update();
  A.show();
  
  fill(0, 0, 255);
  B.update();
  B.show();
}

class Ball{
  PVector pos;
  PVector vel;
  float size;
  
  Ball(PVector pos, PVector vel, float size){
    this.pos = pos;
    this.vel = vel;
    this.size = size;
  }
  
  void update(){
    pos.add(vel);
    if(pos.x < 0 || width < pos.x){vel.x = -vel.x; pos.x += 2*vel.x;}
    if(pos.y < 0 || height < pos.y){vel.y = -vel.y; pos.y += 2*vel.y;}
    if(A.isCollide(this))vel.y = -vel.y; pos.y += 2*vel.y;;
    if(B.isCollide(this))vel.y = -vel.y; pos.y += 2*vel.y;;
  }
  
  void show(){
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, size, size);
  }
}



class Player{
  PVector pos;
  PVector size;
  Goal goal;
  
  Player(float y, float wide, Goal goal){
    this.pos = new PVector(width/2, y);
    this.size = new PVector(wide, 20);
    this.goal = goal;
  }
  
  void update(){
  }
  
  boolean isCollide(Ball ball){
    return pos.x-size.x/2 < ball.pos.x && ball.pos.x < pos.x+size.x/2 && 
    pos.y-size.y/2 < ball.pos.y && ball.pos.y < pos.y+size.y/2 ;
  }
  
  void show(){
    rectMode(CENTER);
    rect(pos.x, pos.y, size.x, size.y);
    goal.show();
  }
}

class Goal{
  PVector pos;
  PVector size;
  int score;
  
  Goal(float y, float wide){
    this.pos = new PVector(width/2, y);
    this.size = new PVector(wide, 20);
  }
  
  void show(){
    rectMode(CENTER);
    rect(pos.x, pos.y, size.x, size.y);
  }
  
  boolean isCollide(){
    return pos.x-size.x/2 < ball.pos.x && ball.pos.x < pos.x+size.x/2 && 
    pos.y-size.y/2 < ball.pos.y && ball.pos.y < pos.y+size.y/2 ;
  }
}
