
ArrayList<ObstacleCube> obstacles = new ArrayList<ObstacleCube>();

class ObstacleCube extends Object{
  float bounciness=0;
  int dmg;
  int cbd;//cooldown between damage
  int cooldown;
  boolean collidable = true;
  PImage image;
  
  
  ObstacleCube(int x, int y, int rot, PImage image){
    this(x, y, rot, 0, 0, image);
  }
  
  ObstacleCube(int x, int y, int rot, int dmg, int cbd, PImage image){
    super(x, y, 16, 16);
    this.dmg = dmg;
    this.cbd = cbd;
    this.image = image;
    this.rot = rot;
  }
  
  boolean isCollide(Player player){
    return collidable && isCollide_(player, this);
  }
  
  int collide(Player player){
    if(cooldown <= 0){
      player.addHp(-dmg);
      cooldown = cbd;
    }
    
    return collide_(player, this);
  }
  
  void update(){
    cooldown--;
    super.update();
  }
  
  void show(){
    if(notInScreen(this))return;
    //fill(255);
    int tx = int(pos.x+getCamx());
    int ty = int(pos.y+getCamy());
    pushMatrix();
    translate(tx+size.x/2, ty+size.y/2);
    rotate(rot*PI/2);
    image(image, -size.x/2, -size.y/2, size.x, size.y);
    popMatrix();
  }
}
