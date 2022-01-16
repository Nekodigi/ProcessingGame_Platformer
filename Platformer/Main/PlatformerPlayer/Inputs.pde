void keyPressed(){
  if(key == ' ' && player_.onGround >= 0){
    
    player_.vel.y = -4;
    player_.pos.add(player_.vel);
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
