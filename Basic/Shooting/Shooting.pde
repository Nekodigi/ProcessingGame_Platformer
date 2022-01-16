//How to use: Arrow key to move. Space key to shoot.
//If you miss enemy 3 times you will die. How much score you can get?

ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
Player player;
int score;
int life = 3;

 public void setup(){
   size(500, 500);
  /* size commented out by preprocessor */;
  player = new Player(new PVector(250, 400), 50);
  
  
}

 public void draw(){
  fill(255, 50);
  rectMode(LEFT);
  rect(0, 0,width, height);
  fill(255);
  if(frameCount % 60 == 0) enemies.add(new Enemy(new PVector(random(width), 0), new PVector(0, 1), 50));
  player.show();
  
  
  for(Enemy enemy : enemies){
    enemy.update();
    enemy.show();
  }
  
  for(int i=enemies.size()-1; i>=0; i--){
    Enemy enemy = enemies.get(i);
    if(enemy.pos.y > height){enemies.remove(enemy);life--;}
    if(enemy.isCollide(bullets)){enemies.remove(enemy);score++;}
  }
  
  for(Bullet bullet : bullets){
    bullet.update();
    bullet.show();
  }
  
  for(int i=bullets.size()-1; i>=0; i--){
    Bullet bullet = bullets.get(i);
    if(bullet.pos.y < 0)bullets.remove(bullet);
  }
  
  fill(0);
  textSize(100);
  textAlign(LEFT,TOP);
  text(score, 20, 0);
  String str = "";
  for(int i=0; i<life; i++){
    str += "■";
  }
  textAlign(RIGHT,TOP);
  textSize(50);
  fill(255, 0, 0);
  text(str, width, 0);
  
  
  if(life == 0){
    textAlign(CENTER, CENTER);
    textSize(100);
    fill(255, 0, 0);
    background(255);
    text("GAMEOVER", width/2, height/2);
    stop();
  }
}

 public void keyPressed(){
  if(keyCode == LEFT){
    player.pos.x -= 20;
  }
  if(keyCode == RIGHT){
    player.pos.x += 20;
  }
  if(key == ' '){
   player.shoot();
  }
}

class Object{
  PVector pos;
  PVector vel;
  float size;
  color col;
  
  Object(PVector pos, PVector vel, float size){
    this.pos = pos;
    this.vel = vel;
    this.size = size;
  }
  
   public void show(){
     fill(col);
    rectMode(CENTER);
    rect(pos.x, pos.y, size, size);
  }
  
   public void update(){
    pos.add(vel);
  }
}

class Player extends Object{
  
  Player(PVector pos, float size){
    super(pos, new PVector(0, 0), size);
  } 
  
  void shoot(){
    bullets.add(new Bullet(pos.copy(), new PVector(0, -10), 10));
  }
}


class Bullet extends Object{
  Bullet(PVector pos, PVector vel, float size){
    super(pos, vel, size);
    col = color(255, 0, 0);
  }
}

class Enemy extends Object{
  
  Enemy(PVector pos, PVector vel, float size){
    super(pos, vel, size);
    col = color(255);
  }
  
  boolean isCollide(ArrayList<Bullet> bullets){
    for(Bullet bullet : bullets){
      if(pos.x-size/2 < bullet.pos.x && bullet.pos.x < pos.x+size/2
      && pos.y-size/2 < bullet.pos.y && bullet.pos.y < pos.y+size/2)return true;
    }
    return false;
  }
}
