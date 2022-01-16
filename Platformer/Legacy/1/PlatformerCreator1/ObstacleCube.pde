import java.util.Arrays;
ArrayList<ObstacleCube> obstacles = new ArrayList<ObstacleCube>();

class ObstacleCube{
  int x, y;
  int w=16, h=16;
  float bounciness=0;
  
  ObstacleCube(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  boolean isCollide(Player player){
    float pxl = player.pos.x;
    float pyl = player.pos.y;
    float pxm = player.pos.x+player.w;
    float pym = player.pos.y+player.h;
    return x < pxm && pxl<(x+w) && y < pym && pyl<(y+h);
  }
  
  int collide(Player player){
    float pxl = player.pos.x;
    float pyl = player.pos.y;
    float pxm = player.pos.x+player.w;
    float pym = player.pos.y+player.h;
    float dxl = abs(x-pxm);
    float dxm = abs((x+w)-pxl);
    float dyl = abs(y-pym);
    float dym = abs((y+h)-pyl);
    
    float[] dists = {dxl, dxm, dyl, dym};
    Arrays.sort(dists);
    println(dists[0], dists[1], dists[2], dists[3], dxl);
    if(dists[0] == dxl){
      player.pos.x -= dxl+EPSILON;
    }else if(dists[0] == dxm){
      player.pos.x += dxm+EPSILON;
    }else if(dists[0] == dyl){
      player.pos.y -= dyl+EPSILON;
    }else if(dists[0] == dym){
      player.pos.y += dym+EPSILON;
    }
    //player.pos.add(PVector.mult(player.vel, 1.0001));
    if(dists[0] == dxl){
      player.vel.x = -player.vel.x*bounciness;
    }else if(dists[0] == dxm){
      player.vel.x = -player.vel.x*bounciness;
    }else if(dists[0] == dyl){
      player.vel.y = -player.vel.y*bounciness;
    }else{
      player.vel.y = -player.vel.y*bounciness;
    }
    
    if(dists[0] == dxl)return 0;
    else if(dists[0] == dxm)return 1;
    else if(dists[0] == dyl)return 2;
    else return 3;
    
  }
  
  void show(){
    rect(x-player.pos.x+camx, y+camy, w, h);
  }
}
