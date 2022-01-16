class Object{
  PImage[] images;
  int fb = 5;//frame between new sprite
  PVector pos, size, vel;
  float tempVelx;//instead of force
  int maxhp, hp;
  boolean dead;
  int lifetime,age;
  int dir;
  int dmg,cbd;//cooldown between damage
  int cooldown;
  
  Object(float x, float y, float w, float h){
    this(x, y, w, h, 0, 0);
  }
  
  void update(){
    pos.add(vel);
    age++;
    cooldown--;
    if(lifetime != 0 && age > lifetime)dead = true;
  }
  
  boolean isCollide(Object object){
    return !dead && isCollide_(object, this);
  }
  
  int collide(Object object){//DAMAGE SELF on collide
    if(cooldown <= 0){
      object.addHp(-dmg);
      cooldown = cbd;
    }
    
    return collide_(object, this);
  }
  
  void addHp(int value){
    hp += value;
    hp = min(hp, maxhp);
    if(hp <= 0){
      if(dead == false){
        dead = true;
        cooldown = 5*fb;
      }
    }
  }
  
  Object(float x, float y, float w, float h, float vx, float vy){
    this.pos = new PVector(x, y);
    this.size = new PVector(w, h);
    this.vel = new PVector(vx, vy);
  }
}
