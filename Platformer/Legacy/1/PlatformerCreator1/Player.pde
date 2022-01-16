Player player;
float g = 0.2;
float camx = 600;
float camy = 0;
float tempVelx = 0;

class Player{
  PVector pos, vel = new PVector();
  int onGround = 0;
  float w=16, h=32;
  
  Player(float x, float y){
    this.pos = new PVector(x, y);
  }
  
  void update(){
    vel.add(0, g);
    boolean coli = false;
    for(ObstacleCube tile : obstacles){
      if(tile.isCollide(this)){ 
        int stat = tile.collide(this);
        if(stat == 2)onGround=1;
        coli = true;
      }
    }
    if(!coli)onGround--;
    pos.add(vel);
  }
  
  void show(){
    fill(255);
    rect(camx, pos.y+camy, w, h);
  }
}
