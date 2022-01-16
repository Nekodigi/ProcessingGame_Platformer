class Palette{
  PImage rawStage;
  PImage[] tiles = new PImage[25*25];
  int x, y;
  int si, sj;//selected
  
  
  void pick(){
    int i=mouseX/16;
    int j = mouseY/16;
    if(i < 25 && j < 25){
      this.si = i;
      this.sj = j;
      //println(i, j);
    }
  }
  
  int selected(){
    return si+sj*25;
  }
  
  void show(){
    rawStage = loadImage("tileset.png");
    for(int i=0; i<25; i++){
      for(int j=0; j<25; j++){
        tiles[i+j*25] = rawStage.get(i*16, j*16, 16, 16);
        image(tiles[i+j*25], i*16, j*16);
      }
    }
    stroke(255, 100, 100);
    noFill();
  rect(si*16, sj*16, 16, 16);
  } 
}
