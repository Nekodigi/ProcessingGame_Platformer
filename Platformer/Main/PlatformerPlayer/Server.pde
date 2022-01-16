Server server;

void recieveServer(){
  while(true){
    Client c = server.available();
    if(c == null)break;
    String s = c.readStringUntil('\n'); if(s == null)break;
    Object datas = strToDatas(s);
    if(!update(players, datas)){players.add(new Player(datas, c));}
  }
}

void initServer(){
  server = new Server(this, 12345);
  println("start server at address: " + server.ip());
  player_ = new Player(0, 300, playerName, server.hashCode());
}

void sendServer(){
  for(Object player : players) server.write(player.toString(0));
}

void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
  println(someClient.hashCode());
}

void disconnectEvent(Client someClient) {
  println("DISCONNECT:"+someClient.hashCode());
  for(int i=0; i<players.size(); i++){
    Object player = players.get(i);
    if(player.getClientHash() != someClient.hashCode())continue;
    players.remove(player);
    server.write(player.toString(1));
  }
}
