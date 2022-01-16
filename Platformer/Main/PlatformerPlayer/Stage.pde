Stage stage;

class Stage{
  int x, y;
  int si, sj;
  int w, h;
  int vi;//viewport offset
  int[][] tiles;
  int[][] metas;//0=enable,1=disable;
  int[][] dmgs;
  int[][] rots;
  
  Stage(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    tiles = new int[w][h];
    rots = new int[w][h];
    metas = new int[w][h];
    dmgs = new int[w][h];
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
  
  void dmg(int dmg){//damage
    if(toIndex())dmgs[si][sj] = dmgs[si][sj]+dmg;
  }
  
  void Load(){
    obstacles = new ArrayList<ObstacleCube>();
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
        if(metas[i][j]==0 && tiles[i][j]!=0 ){//need colider
          dmgs[i][j] = int(datas[3]);
        }
        if(tiles[i][j]!=0){
          ObstacleCube obstacle = new ObstacleCube(i*16, j*16, rots[i][j], palette.tiles[tiles[i+vi][j]]);
          obstacle.dmg = dmgs[i][j];
          obstacle.cbd = 60;//temp
          if(metas[i][j] != 0)obstacle.collidable = false;
          obstacles.add(obstacle);
        }
        
      } 
    }
  }
  
  void Save(){
    String[] strs = new String[h];
    for(int j=0; j<h; j++){
      String str = "";
      for(int i=0; i<w; i++){
        if((metas[i][j]==0 && tiles[i][j]!=0)){//when collider on
          str += str(tiles[i][j])+"/"+str(rots[i][j])+"/"+str(metas[i][j])+"/"+str(dmgs[i][j]);
        }
        else str += str(tiles[i][j])+"/"+str(rots[i][j])+"/"+str(metas[i][j]);
        
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
  
}
