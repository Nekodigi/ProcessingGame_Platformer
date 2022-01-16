
ArrayList<ObstacleCube> obstacles = new ArrayList<ObstacleCube>();

class ObstacleCube extends Object{
  float bounciness=0;
  
  ObstacleCube(int x, int y){
    this(x, y, 0, 0);
  }
  
  ObstacleCube(int x, int y, int dmg, int cbd){
    super(x, y, 32*10, 32);
    this.dmg = dmg;
    this.cbd = cbd;
  }
  
  
  
  void update(){
    
    super.update();
  }
  
  void show(){
    if(notInScreen(this))return;
    fill(255);
    float tx = pos.x+getCamx();
    float ty = pos.y+getCamy();
    rect(tx, ty, size.x, size.y);
  }
}
