//TODO Replace heart with HP bar and drop heart when dmg
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

class Enemy extends Object{
  PVector spawn;
  int onGround = 0;
  PImage[] jumps;
  PImage[] deaths = new PImage[6];
  
  int dir = 1;
  String sprites;
  
  Enemy(float x, float y, int hp, String sprites){
    super(x, y, 64, 64);
    tempVelx = -2;
    
    String Sprites = "Sunnyland/artwork/Sprites/";
    if(sprites == "frog") {
      images = getSprites(Sprites+"Enemies/frog/idle/frog-idle-");
      jumps = getSprites(Sprites+"Enemies/frog/jump/frog-jump-");
    }
    else images = getSprites(Sprites+"Enemies/"+sprites);
    deaths = getSprites(Sprites+"Fx/enemy-death/enemy-death-");
    this.spawn = new PVector(x, y);
    this.maxhp = hp;
    this.hp = hp/2;
    this.sprites = sprites;
    size.y = size.x/((float)images[0].width/images[0].height);//keep aspect align to width
  }
  
  void update(){
    super.update();
    if(dead)return;
    vel.add(0, g);
    boolean coli = false;
    for(ObstacleCube tile : obstacles){//check hitting obstacle
      if(tile.isCollide(this)){ 
        int stat = tile.collide(this);
        if(stat == 2)onGround=1;
        coli = true;
      }
    }
    for(Projectile projectile : projectiles){
      if(projectile.isCollide(this)){
        projectile.collide(this);
      }
    }
    if(player.isCollide(this)){
      if(player.collide(this) == 0){
        player.vel.y = -4;
        addHp(-maxhp);
      }else{
        if(cooldown < 0){
          player.addHp(-1);//cooldown
          cooldown = 30;
        }
      }
    }
    if(!coli)onGround--;
    if(onGround >= 0 && random(100)<1)vel.y = -6;
    if(random(100)<1){tempVelx = 2;dir=-1;}
    if(random(100)<1){tempVelx = -2;dir=1;}
    //vel.x = tempVelx;
    
    //if(dead){
    //  hp = maxhp;
    //  pos = spawn.copy();
    //  dead = false;
    //}
    
  }
  
  void shoot(){
    //if(dir==1)projectiles.add(new Projectile(pos.x+size.x/2, pos.y+size.y/2, 5, 0, -1, 100, "Bolt/bolt"));
    //else projectiles.add(new Projectile(pos.x-size.x/2, pos.y+size.y/2, -5, 0, 1, 100, "Bolt/bolt"));
  }
  
  void show(){
    //println(hp);
    pushMatrix();
    translate(getCamx()+pos.x, pos.y+getCamy());
    if(dead && cooldown>=0)image(deaths[5-(cooldown/fb)],0,0, size.x, size.y);
    popMatrix();
    if(notInScreen(this) || dead)return;
    
    
    pushMatrix();
    translate(getCamx()+pos.x, pos.y+getCamy());
    if(dir==-1){
      translate(size.x, 0);
      scale( -1, 1 );
    }
    if(onGround < 0 && sprites=="frog"){
      if(vel.y > 0){
        image(jumps[1],0,0, size.x, size.y);
      }else{
        image(jumps[0],0,0, size.x, size.y);
      }
    }else{
      image(images[(frameCount/fb)%images.length],0,0, size.x, size.y);
    }
    
    popMatrix();
    //}
  }
}
