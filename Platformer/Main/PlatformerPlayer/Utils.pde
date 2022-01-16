import java.util.Arrays;//ymd

boolean update(ArrayList<Object> objects, Object datas){
  for(Object object : objects){
    if(object.hash == datas.hash){
      if(object.clientSide)return true;
      object.setDatas(datas);return true;
    }
  }//but should make object when nothing;
  return false;
}

boolean Remove(ArrayList<Object> objects, int hash){
  for(Object object : objects) if(object.hash == hash){objects.remove(object);return true;}
  return false;
}

//HEADER 
//0:Operation = 0:update 1:delete

Object strToDatas(String str){
  String[] rdatas = str.trim().split("/");
  String[] rheader = rdatas[0].split(",");
  int[] header = {int(rheader[0]), int(rheader[1])};
  int[] ints = null;
  String [] strs = null;
  
  if(!rdatas[1].equals("")){
    String[] rints = rdatas[1].split(",");
    ints = new int[rints.length];
    for(int i=0; i<rints.length; i++){
      ints[i] = int(rints[i]);
    }
  }
  if(!rdatas[2].equals("")){
    String[] rstrs = rdatas[2].split(",");
    strs = new String[rstrs.length];
    for(int i=0; i<rstrs.length; i++){
      strs[i] = rstrs[i];
    }
  }
  Object obj = new Object(header, ints, strs);
  return obj;
}

String datasToStr(int op, Object datas){//toObject?
  String result = "";
  int hash = datas.hash;
  int[] ints = datas.ints;
  String[] strs = datas.strs;
  result += op+","+hash+"/";//header
  if(ints != null){
    for(int i=0; i<ints.length; i++){
      int Int = ints[i];
      result += Int;
      if(i != ints.length-1)result+=",";
    }
  }
  result += "/";
  if(strs != null){
    for(int i=0; i<strs.length; i++){
      String str = strs[i];
      result += str;
      if(i != strs.length-1)result+=",";
    }
  }
  result+= '\n';
  return result;
}

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
  float xl = A.pos.x+getCamx();//-player.pos.x
  float yl = A.pos.y+getCamy();
  float xm = xl+A.size.x;
  float ym = yl+A.size.y;
  return !(xl <= width/4*3 && xm >= width/4 && yl <= height/4*3 && ym >= height/4);
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
  //println(dists[0], dxl, dxm, dyl, dym);
  if(dists[0] == dxl){
    A.pos.x -= dxl+EPSILON;
    if(A.vel.x <= 0)return -1;//should not collide
  }else if(dists[0] == dxm){
    A.pos.x += dxm+EPSILON;
    if(A.vel.x >= 0)return -1;//should not collide
  }else if(dists[0] == dyl){
    A.pos.y -= dyl+EPSILON;
    if(A.vel.y <= 0)return -1;//should not collide
  }else if(dists[0] == dym){
    A.pos.y += dym+EPSILON;
    if(A.vel.y >= 0)return -1;//should not collide
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
  
void doubleSize(){
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
 updatePixels();
}
