//TODO Replace heart with HP bar and drop heart when dmg

Player player;
float g = 0.2;
float camx = 600;
float camy = 0;
float camoffx;
float camoffy;

PImage back;
float staggerV = 40;//amount of stagger

float getCamx(){
  return camx+camoffx;//-player.pos.x;
}

float getCamy(){
  return camy+camoffy;
}

class Player extends Object{
  
  PVector spawn;
  int onGround = 0;
  PImage[] idles = new PImage[4];
  PImage[] runs = new PImage[6];
  PImage[] jumps = new PImage[2];//up=0 down=1
  PImage[] hearts = new PImage[3];
  int dof;//stagga camera
  
  PImage[] deaths = new PImage[6];
  int dir = 1;
  
  Player(float x, float y, int hp){
    super(x, y, 32, 64);//collider size graphic width is 2x large(special)
    back = loadImage("Sunnyland/artwork/Environment/back.png");
    String Sprites = "Sunnyland/artwork/Sprites/";
    idles = getSprites(Sprites+"player/idle/player-idle-");
    runs = getSprites(Sprites+"player/run/player-run-");
    jumps = getSprites(Sprites+"player/jump/player-jump-");
    deaths = getSprites(Sprites+"Fx/enemy-death/enemy-death-");
    hearts = getSprites("Nekoland/heart/heart-");
    this.spawn = new PVector(x, y);
    this.maxhp = hp;
    this.hp = hp/2;
  }
  
  void update(){
    vel.add(0, g);
    boolean coli = false;
    for(ObstacleCube tile : obstacles){//check hitting obstacle
      if(tile.isCollide(this)){ 
        int stat = tile.collide(this);
        if(stat == 2)onGround=1;
        coli = true;
      }
    }
    if(!coli)onGround--;
    
    if(dof >= 0){
      camoffx = noise(dof)*staggerV;
      camoffy = noise(dof, 1)*staggerV;
    }
    if(dead){
      hp = maxhp;
      pos = spawn.copy();
      dead = false;
    }
    
    camx = lerp(camx, -pos.x+width/2, 0.1);
    camy = lerp(camy, -pos.y+height/2, 0.1);
    dof--;
    player.vel.x = player.tempVelx;
    super.update();
  }
  
  void addHp(int value){
    if(value < 0){
      dof = 10;
    }
    super.addHp(value);
  }
  
  void shoot(){
    if(dir==1)projectiles.add(new Projectile(pos.x+size.x/2, pos.y+size.y/2, 5, 0, -1, 100, "Bolt/bolt"));
    else projectiles.add(new Projectile(pos.x-size.x/2, pos.y+size.y/2, -5, 0, 1, 100, "Bolt/bolt"));
  }
  
  void show(){
    //show background
    image(back, 0+(camx/2)%width+staggerV+camoffx, -staggerV+camoffy, width+staggerV*2, height+staggerV*2);
    image(back, -width+(camx/2)%width-staggerV+camoffx, -staggerV+camoffy, width+staggerV*2, height+staggerV*2);
    
    //show hp
    for(int i=0; i<(maxhp+1)/2; i++){
      if((maxhp-i*2)>hp+1){
      image(hearts[2], width-32-i*32, 0, 32, 32);
      }else if((maxhp-i*2)>hp){
        image(hearts[1], width-32-i*32, 0, 32, 32);
      }else{
        image(hearts[0], width-32-i*32, 0, 32, 32);
      }
    }
    
    //show player
    if(dof<0 || (dof>=0 && (frameCount)%2==0)){//display or flicker
    pushMatrix();
    translate(getCamx()+player.pos.x-size.x/2, pos.y+getCamy());
    if(dir==-1){
      translate(size.x*2, 0);
      scale( -1, 1 );
    }
    if(onGround >= 0){
      if(vel.x == 0){
        image(idles[(frameCount/fb)%4],0,0, size.x*2, size.y);
      }else{
        image(runs[(frameCount/fb)%6],0,0, size.x*2, size.y);
      }
    }else{
      if(vel.y > 0){
        image(jumps[1],0,0, size.x*2, size.y);
      }else{
        image(jumps[0],0,0, size.x*2, size.y);
      }
    }
    popMatrix();
    }
  }
}
