class Object{
  PVector pos, size, vel;
  int rot;
  int hash;
  String name;
  Client client;
  boolean clientSide = false;
  int header[];
  int[] ints;
  String[] strs;
  
  Object(int[] header, int[] ints, String[] strs){//used to pass datas
    this.header = header;
    this.hash = header[1];
    this.ints = ints;
    this.strs = strs;
  }
  
  Object(float x, float y, float w, float h){
    this(x, y, w, h, 0, 0);
  }
  
  void update(){
    pos.add(vel);
  }
  
  int getClientHash(){
    return client==null ? -1 : client.hashCode();
  }
  
  Object(float x, float y, float w, float h, float vx, float vy){
    this.pos = new PVector(x, y);
    this.size = new PVector(w, h);
    this.vel = new PVector(vx, vy);
  }
  
  //MUST OVERRIDE WHEN USE virtual abstract function
  void setDatas(Object obj){}
  
  Object getDatas(){return this;}
  
  String toString(int i){return "";}
  //***************
  
  
  void show(){}
}
