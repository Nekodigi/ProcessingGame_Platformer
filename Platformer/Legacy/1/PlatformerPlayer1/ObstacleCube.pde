
ArrayList<ObstacleCube> obstacles = new ArrayList<ObstacleCube>();

class ObstacleCube extends Object{
  float bounciness=0;
  int dmg;
  int cbd;//cooldown between damage
  int cooldown;
  boolean collidable = true;
  PImage image;
  
  
  ObstacleCube(int x, int y, PImage image){
    this(x, y, 0, 0, image);
  }
  
  ObstacleCube(int x, int y, int dmg, int cbd, PImage image){
    super(x, y, 16, 16);
    this.dmg = dmg;
    this.cbd = cbd;
    this.image = image;
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
    float tx = pos.x+getCamx();
    float ty = pos.y+getCamy();
    image(image, tx, ty, size.x, size.y);
  }
}
