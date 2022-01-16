//How to use: Move mouse to move bar.
//You will never go game over but how fast you can break everything?

Ball ball;
Bar bar;
ArrayList<Block> blocks = new ArrayList<Block>();

public void setup(){
  size(500, 500);
  /* size commented out by preprocessor */;
  
  ball = new Ball();
  bar = new Bar();
  
  float xspacing = 35;
  float yspacing = 35;
  for(int x=0; x<width; x+=xspacing){
    for(int y=0; y<height/2; y+=yspacing){
      Block block = new Block(x, y);
      blocks.add(block);
    }
  }
}

 public void draw(){
  background(255);
  
  ball.show();
  ball.update();
  if(bar.isCollide(ball)){
    bar.processCollide(ball);
  }
  
  bar.show();
  
  for(Block block : blocks){
    block.show();
  }
  
  
}

class Ball{
  float radius = 20;
  float x = 100; 
  float y = 400;
  float vx = 4;  
  float vy = 4;
  
   public void show(){
     fill(255, 0, 0);
    ellipse(x, y, radius, radius);
  }
  
   public void update(){
    for(Block block : blocks){
      if(block.active && block.isCollide(ball)){
        block.processCollide(ball);
        block.active = false;
      }
    }
    
    if(x < 0 || x > width)vx = -vx;
    if(y < 0 || y > height)vy = -vy;
    x += vx; y += vy;
  }
}

class Block{
  float x;
  float y;
  float w=30;
  float h=30;
  boolean active = true;
  
  Block(float x, float y){
    this.x = x; 
    this.y = y;
  }
  
   public void show(){
    if(active){
      fill(0);
      rect(x, y, w, h);
    }
  }
  
   public boolean isCollide(Ball ball){
    return x<ball.x && y<ball.y && x+w>ball.x & y+h>ball.y;
  }
  
  public void processCollide(Ball ball){
    float dx = ball.x-(x+w/2);
    float dy = ball.y-(y+h/2);
    float mag = sqrt(dx*dx+dy*dy);
    dx/=mag;
    dy/=mag;
    ball.vx = dx*4;
    ball.vy = dy*4;
  }
}

class Bar{
  float y = 450;
  float w = 100;
  float h = 20;
  
  void show(){
    fill(0);
    rect(mouseX-w/2, y-h/2 , w, h);
  }
  
  public boolean isCollide(Ball ball){
    return mouseX-w/2<ball.x && y-h/2<ball.y && mouseX+w/2>ball.x & y+h/2>ball.y;
  }
  
  public void processCollide(Ball ball){
    float dx = ball.x-(mouseX);
    float dy = ball.y-(y);
    float mag = sqrt(dx*dx+dy*dy);
    dx/=mag;
    dy/=mag;
    ball.vx = dx*4;
    ball.vy = dy*4;
  }
}
