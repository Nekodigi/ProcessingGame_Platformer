Player player;
float g = 0.2;
float camx = 600;
float camy = 0;
float tempVelx = 0;
PImage back;

class Player{
  PVector pos, vel = new PVector();
  int onGround = 0;
  float w=16, h=32;//w=w/2
  PImage[] idles = new PImage[4];
  PImage[] runs = new PImage[6];
  PImage[] jumps = new PImage[2];//up=0 down=1
  int fb = 5;//frame between new sprite
  int dir = 1;
  
  Player(float x, float y){
    back = loadImage("Sunnyland/artwork/Environment/back.png");
    String Sprites = "Sunnyland/artwork/Sprites/";
    println(loadImage(Sprites+"player/idle/player-idle-1.png").width);
    for(int i=1; i<=4; i++){
      idles[i-1] = loadImage(Sprites+"player/idle/player-idle-"+i+".png");
    }
    for(int i=1; i<=6; i++){
      runs[i-1] = loadImage(Sprites+"player/run/player-run-"+i+".png");
    }
    for(int i=1; i<=2; i++){
      jumps[i-1] = loadImage(Sprites+"player/jump/player-jump-"+i+".png");
    }
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
    //image(back, 0-(player.pos.x/2)%width, 0, width, height);//should show first
    //image(back, width-(player.pos.x/2)%width, 0, width, height);
    
    pushMatrix();
    if(dir==1){
      translate(camx-w/2, pos.y+camy);
    }else{
      translate(camx-w/2+w*2, pos.y+camy);
      scale( -1, 1 );
    }
    if(onGround >= 0){
      if(vel.x == 0){
        image(idles[(frameCount/fb)%4],0,0, w*2, h);
      }else{
        image(runs[(frameCount/fb)%6],0,0, w*2, h);
      }
    }else{
      if(vel.y > 0){
        image(jumps[1],0,0, w*2, h);
      }else{
        image(jumps[0],0,0, w*2, h);
      }
    }
    popMatrix();
    //rect(camx, pos.y+camy, w, h);
  }
}
