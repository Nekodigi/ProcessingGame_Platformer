ArrayList<Item> items = new ArrayList<Item>();

class Item extends Object{
  
  PImage[] itemfeed = new PImage[4];
  boolean used = false;
  int spIndex;//sprite index
  int heal;
  
  Item(float x, float y, int heal, int count, String sprites){
    super(x, y, 32, 32);
    String Items = "Sunnyland/artwork/Sprites/Items/";
    String Sprites = "Sunnyland/artwork/Sprites/";
    images = getSprites(Items+sprites+"/"+sprites+"-");
    itemfeed = getSprites(Sprites+"Fx/item-feedback/item-feedback-");
    size.y = size.x/((float)images[0].width/images[0].height);//keep aspect align to width
    this.heal = heal;
    
  }
  
  void update(){
    if(!used && isCollide(player)){
      used = true;
      player.addHp(heal);
    }
  }
  
  void show(){
    if(notInScreen(this))return;
    
    pushMatrix();
    translate(pos.x+getCamx(), pos.y+getCamy());
    if(!used)image(images[(frameCount/fb)%images.length],0,0, size.x, size.y);
    if(used && spIndex < itemfeed.length-1){
      if(frameCount%fb == 0)spIndex++;
      image(itemfeed[spIndex],0,0, size.x, size.y);
    }
    popMatrix();
  }
}
