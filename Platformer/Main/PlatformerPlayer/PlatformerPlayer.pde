//TODO DELETE PLAYER WHEN DISCONNECT
//MOVING FLOOR
//JUMPING FLOOR
//FIRE BAR

String serverAddress = "localhost";//192.168.54.159.
String playerName = "NEKO";

boolean isClient = true;

void setup(){
  size(760, 480);//1152, 720 768+384, 480+240 playing size
  if(isClient) initClient();
  else initServer();
  
  init();
}

void draw(){
  show();
  
  if(isClient)sendClient();
  else{
    recieveServer();
    sendServer();
  }
  
  update();
}

void init(){
  player_.clientSide = true;
  players.add(player_);
  
  palette = new Palette();
  stage = new Stage(25*16, 0*16, 1024, 32);
  stage.Load();
}

void show(){
  background(46, 189, 252);
  //player.showBG();//very heavy
  for(ObstacleCube tile : obstacles){
    tile.show();
  }
  for(int i=0; i<players.size(); i++){//due to currentModificationException caused by clientEvent
    players.get(i).show();
  }
  doubleSize();
  text(frameRate, 100, 500);//show fps
}

void update(){
  for(ObstacleCube tile : obstacles){
    tile.update();
  }
  player_.update();
  player_.vel.x = tempVelx;
}
