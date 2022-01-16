import java.util.Arrays;//ymd

PImage[] getSprites(String dir){
  int count = 0;
  while(true){
    String path = dir+(count+1)+".png";
    Boolean exsist = dataFile(path).isFile();
    if(!exsist){ break;}
    count++;
  }
  if(count == 0)println("INVALID SPRITE DIRECTORY");
  
  PImage[] images = new PImage[count];//image count
  for(int i=1; i<=count; i++){
    String path = dir+i+".png";
    images[i-1] = loadImage(path);
  }
  return images;
}

boolean notInScreen(Object A){
  float xl = A.pos.x+getCamx();
  float yl = A.pos.y+getCamy();
  float xm = xl+A.size.x;
  float ym = yl+A.size.y;
  return !(xl <= width && xm >= 0 && yl <= height && ym >= 0);
}

boolean isCollide_(Object A, Object B){
  float axl = A.pos.x;//A x least(left)
  float ayl = A.pos.y;//A y least(up)
  float axm = A.pos.x+A.size.x;//A x most(right)
  float aym = A.pos.y+A.size.y;//A y most(down)
  float bxl = B.pos.x;//B x least(left)
  float byl = B.pos.y;//B y least(up)
  float bxm = B.pos.x+B.size.x;//B x most(right)
  float bym = B.pos.y+B.size.y;//B y most(down)
  return bxl < axm && axl<bxm && byl < aym && ayl<bym;
}

//Override A velocity when collide obstacle B
int collide_(Object A, Object B){
  float bounciness = 0;
    //if(cooldown <= 0){
    //  player.addHp(-dmg);
    //  cooldown = cbd;
    //}
    
    float axl = A.pos.x;//A x least(left)
    float ayl = A.pos.y;//A y least(up)
    float axm = A.pos.x+A.size.x;//A x most(right)
    float aym = A.pos.y+A.size.y;//A y most(down)
    float bxl = B.pos.x;//B x least(left)
    float byl = B.pos.y;//B y least(up)
    float bxm = B.pos.x+B.size.x;//B x most(right)
    float bym = B.pos.y+B.size.y;//B y most(down)
    
    float dxl = abs(bxl-axm);//Distance between B left and A right
    float dxm = abs(bxm-axl);//Distance between B right and A left
    float dyl = abs(byl-aym);//Distance between B up and A down
    float dym = abs(bym-ayl);//Distance between B down and A up
    
    float[] dists = {dxl, dxm, dyl, dym};
    Arrays.sort(dists);
    //println(dists[0], dists[1], dists[2], dists[3], dxl);
    if(dists[0] == dxl){
      A.pos.x -= dxl+EPSILON;
    }else if(dists[0] == dxm){
      A.pos.x += dxm+EPSILON;
    }else if(dists[0] == dyl){
      A.pos.y -= dyl+EPSILON;
    }else if(dists[0] == dym){
      A.pos.y += dym+EPSILON;
    }
    //player.pos.add(PVector.mult(player.vel, 1.0001));
    if(dists[0] == dxl){
      A.vel.x = -A.vel.x*bounciness;
    }else if(dists[0] == dxm){
      A.vel.x = -A.vel.x*bounciness;
    }else if(dists[0] == dyl){
      A.vel.y = -A.vel.y*bounciness;
    }else{
      A.vel.y = -A.vel.y*bounciness;
    }
    
    if(dists[0] == dxl)return 0;
    else if(dists[0] == dxm)return 1;
    else if(dists[0] == dyl)return 2;
    else return 3;
    
  }
