ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

class Projectile extends Object{
  int spIndex;//sprite index
  
  
  Projectile(float x, float y, float vx, float vy, int dir, int lifetime, String sprites){//should reduce count;
    this(x, y, vx, vy, dir, lifetime, 32, sprites);
  }
  
  Projectile(float x, float y, float vx, float vy, int dir, int lifetime, float w, String sprites){
    super(x, y, w, w, vx, vy);
    String effects = "Warped Shooting Fx/Pixel Art/";
    
    
    images = getSprites(effects+sprites);
    size.y = size.x/((float)images[0].width/images[0].height);//keep aspect align to width
    this.pos = new PVector(x, y);
    this.dir = dir;
    this.lifetime = lifetime;
    this.dmg = 1;
  }
  
  
  
  void update(){
    super.update();
  }
  
  void show(){
    if(notInScreen(this))return;
    if(dead) return;
    pushMatrix();
    translate(pos.x+getCamx(), pos.y+getCamy());
    if (dir == -1){
      translate(size.x, 0);
      scale( -1, 1 );
    }
    image(images[(frameCount/fb)%images.length],0,0, size.x, size.y);
    popMatrix();
  }
}
