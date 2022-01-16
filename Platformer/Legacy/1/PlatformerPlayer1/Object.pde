class Object{
  PVector pos, size, vel;
  
  Object(float x, float y, float w, float h){
    this(x, y, w, h, 0, 0);
  }
  
  void update(){
    pos.add(vel);
  }
  
  Object(float x, float y, float w, float h, float vx, float vy){
    this.pos = new PVector(x, y);
    this.size = new PVector(w, h);
    this.vel = new PVector(vx, vy);
  }
}
