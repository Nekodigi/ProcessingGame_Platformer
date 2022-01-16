import processing.net.*;
Client c;

void clientEvent(Client c) {
  if(!isClient)return;
  while(true){
    String s = c.readStringUntil('\n');
    if(s == null || player_ == null)return;
    Object datas  = strToDatas(s);
    if(datas.header[0] == 0){ if(!update(players, datas)){players.add(new Player(datas));println("newplayer:"+datas.hash);}//update
    }else if(datas.header[0] == 1) Remove(players, datas.hash);//delete
  }
}

void initClient(){
  c = new Client(this, serverAddress, 12345);
  player_ = new Player(0, 300, playerName, c.hashCode());
}

void sendClient(){
  c.write(player_.toString(0));
}
