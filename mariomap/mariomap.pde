
boolean key_a;
boolean key_d;
static int Width=960;
static int Height=540;
void setup(){
  size(960,540);
  background(129,170,255);
  //Width = width;
  //Height = height;
}

int x=0,y=0;
//block BLOCK1 = new block(500,height-40);
ground Ground = new ground(0,700);
MAP map = new MAP();


void draw(){
  background(129,170,255);
  if(key_a == true){x-=5;} else
  if(key_d == true) x+=5;
  //if(map.mapscrol(x) == false) println(x);
  map.mapscrol(-x);
  println(-x);
  //BLOCK1.drawing(x+BLOCK1.getXpos(),BLOCK1.getYpos());
  //Ground.drawing(x+Ground.getXpos());
  //BLOCK1.drawing(100,100);
}

void keyPressed(){
  switch(key){
    case 'a':
    key_d = false;
    key_a = true;
    break;
    case 'd':
    key_a = false;
    key_d = true;
    break;
  }
}

void keyReleased(){
  switch(key){
    case 'a':
    key_a = false;
    break;
    case 'd':
    key_d = false;
    break;
  }
}

class MAP{
  private int mapWIDTH = 3000;
  private int mapHEIGHT = Height;
  private int gh = Height-40;
  private block[] BLOCK = new block[45];
  private ground[] Ground = new ground[3];
  private int ofset = 200;
  
  public MAP(){
    int count = 0;
    for(int i=9;i>=0;i--){
      for(int j=0;j<i;j++){
        BLOCK[count] = new block(100+(9-j)*40, gh-(9-i)*40);
       // println(BLOCK[count].getXpos());
        count++;
      }
    }/*
    for(count = 0;count < BLOCK.length;count++){
      BLOCK[count] = new block(100 + count*40,gh);
    }
    println(count);*/
    //println(Height);
    Ground[0] = new ground(0,300);
    Ground[1] = new ground(360,500);
    Ground[2] = new ground(550,700);
  }
  
  
  /*
   * map scrol method !!!!!
   */
  public void mapscrol(int x){
    int ex = 0;
    int dx = 0;
    int marioPos = ofset;
    
    if(x > 0){
      marioPos -= x;
      x = 0;
    }
    if(x <= -(mapWIDTH - Width)){
      marioPos += -x + Width - mapWIDTH;
      x = (mapWIDTH - Width);
    }
    fill(0);
    rect(marioPos,200,300,300);
    
    for(int i=0;i < BLOCK.length;i++){
      if((-50 < (ex = x + BLOCK[i].getXpos())) && (ex < Width + 10)){
        BLOCK[i].drawing(ex,BLOCK[i].getYpos());
      }
    }
    for(int i=0;i < Ground.length;i++){
      Ground[i].drawing(x + Ground[i].getXpos());
    }
  }
}



class mapObject{
  public int objectWidth;
  public int objectHeight;
  
  public int x1,y1,x2,y2;

  public int Xpos;
  public int Ypos;
  
  public int objW;
  public int objH;
  
  public int getXpos(){
    return Xpos;
  }
  public int getYpos(){
    return Ypos;
  }
  
  public void drawing(){}
  
  /*
  // mada dekite inaiyo
  public void objatari(int mx1,int my1,int mx2,int my2){
     if((mx1<=x1 && x1<=mx2) && ((my2<=y1 && y1<=my1) || (my2<=y2 && y2<=my1) || (y2<=my2 && my2<=y2))){
       x = bx - magnification * 16;
     }
     if((mx1<=x2 && x2<mx2) && ((my2<=y1 && y1<=my1) || (my2<=y2 && y2<=my1) || (y2<=my2 && my2<=y1))){
       x = bxw;
     }
     if((y2<=my1 && my1<=y1) && ((x1<=mx1 && mx1<=x2) || (x1<=mx2 && mx2<=x2) || (mx1<=x1 && x1<=mx2))){
       y = byh;
     }
     if((y2<=my2 && my2<=y1) && ((x1<=mx1 && mx1<=x2) || (x1<=mx2 && mx2<=x2) || (mx1<=x1 && x1<=mx2))){
       y = by + magnification * 16;
     }
  }
  */
}


class ground extends mapObject{
  private int g1,g2,w;
  public ground(int x1,int x2){
    g1 = x1;
    g2 = x2;
    w = g2 - g1;
  }
  
  public void drawing(int x){
    fill(125);
    rect(x+g1,Height-40,w,40);
  }
}

class block extends mapObject{
  private int dx;
  private int dy;
  private int ex;
  private int ey;
  
  public block(int x,int y){
    super.objectWidth = 40;
    super.objectHeight = 40;
    super.Xpos = x;
    super.Ypos = y;
  }


/*
 * henkou tochuuuuuuuuuuuu!!!!!!!!!!!!!!!!!
 * hensuu no irekae ha atari hantei no tokini suru!!!!!!!
 */
  public void drawing(int x,int y){
    super.x1 = x;
    super.y1 = y;
    super.x2 = x + objectWidth;
    super.y2 = y - objectHeight;
    fill(232,220,204);
    triangle(x, y, x, y - objectHeight, x + objectWidth, y - objectHeight);
    fill(46,29,7);
    triangle(x, y, x + objectWidth, y - objectHeight, x + objectWidth, y);
    stroke(219,137,29);
    //strokeWeight(2);
    line(x, y - objectHeight, x + objectWidth, y);
    fill(219,137,29);
    rect(x + objectWidth / 4, y - 3*(objectHeight / 4),objectWidth / 2, objectHeight / 2);
  }
}
