//REQUIRES SUNNY LAND
//put under data/SunnyLand get here:https://assetstore.unity.com/packages/2d/characters/sunny-land-103349

//How to use: Click on palette(left top) to pick. Click grid to make stage.
//[ key to rotate. shift key to make no collider object. Z/X key to set damage when on it.
//press S to save. press L to load stage.

//if you want to test play, press B key.
//Then, arrow key to move. space key to jump.

//TODO: MOVING BLOCK //PROJECTILE BLOCK
//SAVE POINT //ITEM META
Palette palette;
Stage stage;
boolean building = true;

void setup(){
  
  
  size(1152, 720);//768+384, 480+240 playing size
  palette = new Palette();
  stage = new Stage(25*16, 0*16, 1024, 32);
  stage.Load();
  
  player = new Player(0, 300);
}

void draw(){
  background(46, 189, 252);
  
  //META DATA VISUALIZER
  
  int si = stage.si; int sj = stage.sj;
  int type = stage.tiles[si][sj];
  int meta = stage.metas[si][sj];
  int rot = stage.rots[si][sj];
  int dmg = stage.dmgs[si][sj];
  fill(0);
  int size = 30;
  textSize(size);
  int y = 500;
  text("Collider:"+((meta==0 && type!=0) ? "ON" : "OFF"), 10, y);y+=size;
  text("Rotation:"+rot*90, 10, y);y+=size;
  text("Damage:"+dmg, 10, y);y+=size;
  textSize(30);
  text("FPS:"+(int)frameRate, 10, height-size);
  
  stage.toIndex();
  
  palette.show();
 stage.show();
 if(mousePressed){
   if(mouseButton == LEFT){
     stage.pick();
   }
   
 }
 
 if(!building){
   for(ObstacleCube tile : obstacles){
      //tile.show();
    }
 }
 
 player.show();
  player.update();
  player.vel.x = tempVelx;
}

void mousePressed(){
  palette.pick();
  
   
}



void keyPressed(){
  if(keyCode == SHIFT){
     stage.meta();
   }
  if(key == '['){
     stage.rot();
   }
   if(key == 'z'){
     stage.dmg(1);
   }
   if(key == 'x'){
     stage.dmg(-1);
   }
  if(key == 's'){
    stage.Save();
  }
  if(key == 'a'){
    stage.vi--;
  }
  if(key == 'd'){
    stage.vi++;
  }
  if(keyCode == UP){
     palette.sj--;
   }
  if(keyCode == DOWN){
     palette.sj++;
   }
  if(keyCode == LEFT){
     palette.si--;
     player.dir = -1;
   }
  if(keyCode == RIGHT){
     palette.si++;
     player.dir = 1;
   }
   if(key == 'b'){
     building = !building;
     stage.Save();
     stage.Load();
   }
   
   palette.si = constrain(palette.si, 0, 25-1);
   palette.sj = constrain(palette.sj, 0, 25-1);
  
  stage.vi = constrain(stage.vi, 0, stage.w-32);
  
  if(key == ' ' && player.onGround >= 0){
    
    player.vel.y = -4;
    player.pos.add(player.vel);
  }
  if(keyCode == LEFT){
      tempVelx = -2;
  }else if(keyCode == RIGHT){
    tempVelx = 2;
  }
}

void keyReleased(){
  if(keyCode == LEFT){
      tempVelx = 0;
  }else if(keyCode == RIGHT){
    tempVelx = 0;
  }
}
