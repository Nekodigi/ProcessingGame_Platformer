//How to use: arrow key to move. space key to jump. z key to shoot.
//Experimental feature. Item, enemy, bullet.

//this project also requires https://assetstore.unity.com/packages/2d/textures-materials/abstract/warped-shooting-fx-195246
//put [Project Folder]/data/Warped Shooting Fx

void setup(){
  size(768, 480);//384,240
  
  obstacles.add(new ObstacleCube(100, 200));
  
  obstacles.add(new ObstacleCube(150, 136, 0, 30));
  obstacles.add(new ObstacleCube(250, 200, 10, 0));
  
  //projectiles.add(new Projectile(150, 10, 1, 0, -1, 100, "Bolt/bolt"));
  
  ///items.add(new Item(150, 80, 2, 7, "cherry"));
  //items.add(new Item(200, 90, 5, 5, "gem"));
  //player = new Player(100, 50);
  player = new Player(100, 50, 10);
  //enemy = new Enemy(300, 50, 10, "opossum/opossum-");//"eagle/eagle-attack-"
  //enemy = new Enemy(300, 50, 10, "eagle/eagle-attack-");
  //enemies.add(new Enemy(300, 50, 10, "opossum/opossum-"));//frog
  //enemies.add(new Enemy(300, 50, 10, "eagle/eagle-attack-"));//frog
  enemies.add(new Enemy(300, 50, 10, "frog"));//frog
  camx = width/2;
  camy = height/2;
}

void draw(){
  background(255);
  
  if(keyPressed){
    
  }
  
  //should show first
  player.show();
  for(Enemy enemy : enemies){
    enemy.show();
    enemy.update();
  }
  
  for(ObstacleCube tile : obstacles){
    tile.show();
    tile.update();
  }
  
  for(Item item : items){
    item.update();
    item.show();
  }
  
  for(Projectile projectile : projectiles){
    projectile.show();
    projectile.update();
    //println(projectile.pos.y);
  }
  
  player.update();
  
  
  
  
  
}

void keyPressed(){//press multiple key https://stackoverflow.com/questions/21376781/how-processing-knows-that-user-is-pressing-multiple-key-at-the-same-time
  if(key == ' ' && player.onGround >= 0){
    
    player.vel.y = -6;//-4
    player.pos.add(player.vel);
  }
  if(key == 'z'){
    player.shoot();
  }
  if(keyCode == LEFT){
      player.tempVelx = -2;
      player.dir = -1;
  }else if(keyCode == RIGHT){
    player.tempVelx = 2;
    player.dir = 1;
  }
}

void keyReleased(){
  if(keyCode == LEFT){
      player.tempVelx = 0;
  }else if(keyCode == RIGHT){
    player.tempVelx = 0;
  }
}
