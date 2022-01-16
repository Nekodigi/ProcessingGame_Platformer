class Stage{
  int x, y;
  int si, sj;
  int w, h;
  int vi;//viewport offset
  int[][] tiles;
  int[][] metas;//0=enable,1=disable;
  int[][] rots;
  
  Stage(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    tiles = new int[w][h];
    rots = new int[w][h];
    metas = new int[w][h];
  }
  
  void pick(){
    if(toIndex())tiles[si][sj] = palette.selected();
  }
  
  void rot(){
    if(toIndex())rots[si][sj] = (rots[si][sj]+1)%4;;
  }
  
  void meta(){
    if(toIndex())metas[si][sj] = (1-metas[si][sj]);
  }
  
  void Load(){
    String[] strss = new String[h];
    strss = loadStrings("stage.txt");
    for(int j=0; j<strss.length; j++){
      String[] strs = strss[j].split(",");
      for(int i=0; i<strs.length; i++){
        String str = strs[i];
        String[] datas = str.split("/");
        tiles[i][j] = int(datas[0]);
        rots[i][j] = int(datas[1]);
        metas[i][j] = int(datas[2]);
        if(tiles[i][j]!=0 && metas[i][j] == 0)obstacles.add(new ObstacleCube(i*16, j*16));
      } 
    }
  }
  
  void Save(){
    String[] strs = new String[h];
    for(int j=0; j<h; j++){
      String str = "";
      for(int i=0; i<w; i++){
        str += str(tiles[i][j])+"/"+str(rots[i][j])+"/"+str(metas[i][j]);
        
        if(i!=w-1)str += ',';
      } 
      strs[j] = str;
      println(str);
    }
    saveStrings("stage.txt", strs);
  }
  
  
  
  boolean toIndex(){
    int i= (mouseX-x)/16+vi;
    int j = (mouseY-y)/16;
    if(i < 32+vi && j < h && vi<=i&& 0<=j){
      this.si = i;
      this.sj = j;
      return true;
    }
    return false;
  }
  
  void show(){
    stroke(0, 10);
    noFill();
    
    pushMatrix();
    if(building) translate(x, y);
    else translate(-player.pos.x+camx, 0);
    int ilim = 32;
    if(!building)ilim = w;
    for(int i=0; i<ilim; i++){
      for(int j=0; j<h; j++){
        
        pushMatrix();
        translate(i*16+8  , j*16+8);
        rotate(rots[i+vi][j]*PI/2);
        if(tiles[i+vi][j]!=0)  image(palette.tiles[tiles[i+vi][j]], -8, -8);
        if(metas[i+vi][j]==1)fill(255, 0, 0, 100);
        else noFill();
        if(building)rect(-8, -8, 16, 16);
        popMatrix();
      }
    }
    stroke(255, 0, 0);
    rect((si-vi)*16, sj*16, 16, 16);
    popMatrix();
  }
}
