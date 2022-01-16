//USER DEFINED CONSTANT
int maxhp_ = 6;
float g = 0.2;
float camadjx;//camera position  adjust
float camadjy = -20;
float staggerV = 40;//amount of stagger
//VARIABLE
ArrayList<Object> players = new ArrayList<Object>();
Player player_;

float camx;
float camy;
float camoffx;
float camoffy;
float tempVelx = 0;
PImage back;

int stagger;//stagga camera

float getCamx(){
  return camx+camoffx+camadjx;//-player.pos.x;
}

float getCamy(){
  return camy+camoffy+camadjy;
}

class Player extends Object{
  int onGround = 0;
  int dir = 1;
  int hp;
  int maxhp;
  
  PVector spawn;
  
  PImage[] idles = new PImage[4];
  PImage[] runs = new PImage[6];
  PImage[] jumps = new PImage[2];//up=0 down=1
  PImage[] hearts = new PImage[3];
  
  
  boolean dead = false;
  
  PImage[] deaths = new PImage[6];
  int fb = 5;//frame between new sprite
  
  Player(Object object, Client c){this(object);this.client = c;}
  
  Player(Object object){
    this(0, 0, "", object.hash);
    setDatas(object);
  }
  
  Player(float x, float y, String name, int hash, Client c){
    this(x, y, name, hash);
    this.client = c;
  }
  
  Player(float x, float y, String name, int hash){
    super(x, y, 16, 32);//collider size graphic width is 2x large(special)
    back = loadImage("Sunnyland/artwork/Environment/back.png");
    String Sprites = "Sunnyland/artwork/Sprites/";
    idles = getSprites(Sprites+"player/idle/player-idle-");
    runs = getSprites(Sprites+"player/run/player-run-");
    jumps = getSprites(Sprites+"player/jump/player-jump-");
    deaths = getSprites(Sprites+"Fx/enemy-death/enemy-death-");
    hearts = getSprites("Nekoland/heart/heart-");
    this.spawn = new PVector(x, y);
    this.maxhp = maxhp_;
    this.hp = maxhp_/2;
    this.hash = hash;
    this.name = name;
  }
  
  void setDatas(Object obj){
    ints = obj.ints;
    strs = obj.strs;
    pos = new PVector(ints[0], ints[1]);
    vel = new PVector(ints[2], ints[3]);
    onGround = ints[4];
    dir = ints[5];
    hp = ints[6];
    name = strs[0];
  }
  
  Object getDatas(){
    int[] ints_ = {int(pos.x), int(pos.y), int(vel.x), int(vel.y), onGround,  dir, hp};
    String[] strs_ = {name};
    ints = ints_;
    strs = strs_;
    return this;
  }
  
  String toString(int op){
    getDatas();
    return datasToStr(op, this);
  }
  
  void update(){
    super.update();
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
    
    if(stagger >= 0){
      camoffx = noise(stagger)*staggerV;
      camoffy = noise(stagger, 1)*staggerV;
    }
    if(dead){
      hp = maxhp;
      pos = spawn.copy();
      dead = false;
    }
    
    camx = lerp(camx, -pos.x+width/2, 0.1);
    camy = lerp(camy, -pos.y+height/2, 0.1);
    stagger--;
    calcDir();
    if(pos.y > height*2)addHp(-maxhp);
    
  }
  
  void calcDir(){
    if(vel.x == 0)return;
    else if(vel.x < 0)dir = -1;
    else dir =  1;
  }
  
  void addHp(int value){
    if(value < 0){
      stagger = 10;
    }
    hp += value;
    hp = min(hp, maxhp);
    if(hp <= 0){
      dead = true;
    }
  }
  
  void shoot(){
    println("shoot");
    //if(dir==1)projectiles.add(new Projectile(pos.x+size.x/2, pos.y+size.y/2, 5, 0, -1, "Bolt/bolt"));
    //else projectiles.add(new Projectile(pos.x-size.x/2, pos.y+size.y/2, -5, 0, 1, "Bolt/bolt"));
  }
  
  void showBG(){//very heavy action
    image(back, (0+(camx)%width+staggerV+camoffx)/2+width/4, (-staggerV+camoffy)/2+height/4, (width+staggerV*2)/2, (height+staggerV*2)/2);
    image(back, (-width+(camx)%width-staggerV+camoffx)/2+width/4, (-staggerV+camoffy)/2+height/4, (width+staggerV*2)/2, (height+staggerV*2)/2);
  }
  
  void show(){
    //show background
    //maybe it works crop half*half area
    
    //show hp
    if(clientSide){
      for(int i=0; i<(maxhp+1)/2; i++){
        if((maxhp-i*2)>hp+1){
        image(hearts[2], width/4*3-16-i*16, height/4, 16, 16);
        }else if((maxhp-i*2)>hp){
          image(hearts[1], width/4*3-16-i*16, height/4, 16, 16);
        }else{
          image(hearts[0], width/4*3-16-i*16, height/4, 16, 16);
        }
      }
    }
    
    //show player
    if(stagger<0 || (stagger>=0 && (frameCount)%2==0)){//display or flicker
    pushMatrix();
    //if(mine)translate(-pos.x, 0);
    translate(getCamx()+pos.x-size.x/2, pos.y+getCamy());
    
    //show name
    textSize(10);
    fill(0);text(name, 1, 5+1);text(name, 1, 5+1);
    fill(255);text(name, 0, 5);text(name, 0, 5);
    
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
