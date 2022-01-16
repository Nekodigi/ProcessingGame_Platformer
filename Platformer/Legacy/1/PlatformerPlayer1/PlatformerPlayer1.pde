
Palette palette;
Stage stage;
boolean building = true;

void setup(){
  
  
  size(1152, 720);//768+384, 480+240 playing size
  palette = new Palette();
  stage = new Stage(25*16, 0*16, 1024, 32);
  stage.Load();
  
  player = new Player(0, 300, 10);
}

void draw(){
  background(46, 189, 252);
  //player.showBG();//very heavy
  
  //palette.show();
 //stage.show();
 if(mousePressed){
   if(mouseButton == LEFT){
     stage.pick();
   }
   
 }
 
 //if(!building){
   for(ObstacleCube tile : obstacles){
      tile.show();
      tile.update();
    }
 //}
 
 player.show();
 
 loadPixels();
 color[] npixels = pixels.clone();//new color[pixels.length];
 for(int i=0; i<width/2; i++){
   for(int j=0; j<height/2; j++){
     color col = npixels[(i+width/4)+(j+height/4)*width];
     pixels[(i*2)+(j*2)*width] = col;
     pixels[(i*2+1)+(j*2)*width] = col;
     pixels[(i*2)+(j*2+1)*width] = col;
     pixels[(i*2+1)+(j*2+1)*width] = col;
   }
 }
 //pixels = npixels;
 updatePixels();
 text(frameRate, 100, 500);
 
 
 
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
  if(key == 's'){
    //stage.Save();
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
     //stage.Save();
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
