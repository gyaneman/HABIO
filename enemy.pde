class enemy extends mapObject{
  private int enemyWidth;
  private int enemyHeight;
  private int magnificationX;
  private int magnificationY;
  
  public void draw(){}
}


int[][] kuriboDrawing = {
  { 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0},
  { 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0},
  { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
  { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
  { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
  { 0, 0, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 1, 0, 0},
  { 0, 1, 1, 1, 1, 3, 2, 1, 1, 1, 1, 1, 2, 3, 1, 1, 1, 1, 0},
  { 0, 1, 1, 1, 1, 3, 2, 2, 2, 2, 2, 2, 2, 3, 1, 1, 1, 1, 0},
  { 1, 1, 1, 1, 1, 3, 2, 3, 1, 1, 1, 3, 2, 3, 1, 1, 1, 1, 1},
  { 1, 1, 1, 1, 1, 3, 2, 3, 1, 1, 1, 3, 2, 3, 1, 1, 1, 1, 1},
  { 1, 1, 1, 1, 1, 3, 3, 3, 1, 1, 1, 3, 3, 3, 1, 1, 1, 1, 1},
  { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  { 0, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 0},
  { 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0},
  { 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 0, 0},
  { 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 0, 0},
  { 0, 0, 0, 0, 2, 2, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 0},
  { 0, 0, 0, 0, 2, 2, 2, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 0},
  { 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0},
  };
  

class kuribo extends enemy{

  private final int kw = 19;
  private final int kh = 19;
  private boolean direction = true;
  private int state = 0;
  private int i_x, i_y;
  
  private boolean deadflg = false;
  
  public void setup(int instance){
    super.magnificationX = 2;
    super.magnificationY = 2;
    super.enemyWidth = super.magnificationX * this.kw;
    super.enemyHeight = super.magnificationY * this.kh;
    super.x1 = kuriboN[instance][0];
    super.y1 = kuriboN[instance][1];
    super.x2 = super.x1 + super.enemyWidth;
    super.y2 = super.y1 - super.enemyHeight;
    this.newx1 = super.x1;
    this.newx2 = super.x2;
    this.newy1 = super.y1;
    this.newy2 = super.y2;
    this.count = 0;
    this.yv = 0;
    this.direction = true;
    this.deadflg = false;
    //super.objState = 1;
    super.id = instance;
    if(kuriboflg[id] == true){
      this.deadflg = true;
      super.magnificationY = 1;
    }
  }
  

  private int yv = 0;
  private final int ya = 2;
  int newx1, newy1, newx2, newy2;
  
  
  public boolean update(int offset){
    if(super.id == -1) return false;
    if(!deadflg && x1 - offset + 1 <= Width && x1 - offset >= -60 && Height + 100 <= x1){
      this.yv += this.ya;
      this.newy1 = super.y1 + this.yv;
      if(direction) newx1 = super.x1 - 3;
      else newx1 = super.x1 + 3;
      this.settingPos2();
      return true;
    }
    return false;
  }
  
  
  private boolean collJge(mapObject[] mpobj){
    boolean flg = false;
    if(this.state == 0){
      for(int i=0 ; i < mpobj.length ; i++){
        if(newx1 < mpobj[i].x2 && newy1 > mpobj[i].y2 && newx2 > mpobj[i].x1 && newy2 < mpobj[i].y1){
          if(newy1 >= mpobj[i].y2 && newy1 <= mpobj[i].y2 + this.yv + 5){
            newy1 = mpobj[i].y2 - 1;
            this.yv = 0;
            flg = true;
          }
          if(direction == false && newx2 >= mpobj[i].x1 && newx2 <= mpobj[i].x1 + 4){
            newx1 = mpobj[i].x1 - super.enemyWidth;
            direction = true;
            flg = true;
          }
          if(direction == true && newx1 <= mpobj[i].x2 && newx1 >= mpobj[i].x2 - 4){
            newx1 = mpobj[i].x2 + 1;
            direction = false;
            flg = true;
          }
          this.settingPos2();
          break;
        }
      }
    }
      
    if(this.state == 1){
      super.magnificationY = 1;
      //draw(x1 - offset);
      return false;
    }
    //println("pos-" + x1 + "..." + y1 + "..." + x2 + "..." + y2);
    //println("new-" + newx1 + "..." + newy1  + "..." + newx2 + "..." + newy2);
    return flg;
  }
  
  
  
  private void copyPos(){
    x1 = newx1;
    x2 = newx2;
    y1 = newy1;
    y2 = newy2;
    kuriboN[super.id][0] = x1;
    kuriboN[super.id][1] = y1;
  }
  
  private void settingPos2(){
    newx2 = newx1 + super.enemyWidth;
    newy2 = newy1 - super.enemyHeight;
  }
  
  
  
  
  
  private int count = 0;
  public void draw(int offset){
    if(super.id == -1 || offset + Width < super.x1 || offset > super.x2){
      super.id = -1;
      return;
    }
    int br;
    int bt = super.y1;
    if(count > 17) count = 0;
    
    noStroke();
    if(this.count <= 8){
      for(int j=kh - 1 ; j >= 0 ; j--){
        br = super.x1 - offset;
        bt -= super.magnificationY;
        for(int i=0 ; i < kw ; i++){
          br += super.magnificationX;
          drawBlock(kuriboDrawing[j][i], br, bt);
        }
      }
    }else if(this.count > 8){
      for(int j=kh - 1 ; j >= 0 ; j--){
        br = super.x1 - offset;
        bt -= super.magnificationY;
        for(int i = kw - 1 ; i >= 0 ; i--){
          br += super.magnificationX;
          drawBlock(kuriboDrawing[j][i], br, bt);
        }
      }
    }
    this.count++;
  }
  
  
  
  private boolean collMario(int mx, int my){
    //println("collmario");
    if(mx < super.x2 && my > super.y2 && mx + mario.marioWdt > super.x1 && my - mario.marioBtm < super.y1){
      if(my >= super.y2 && my <= super.y2 + 20){
        //println("yeah");
        deadflg = true;
        kuriboflg[id] = true;
        super.magnificationY = 1;
        super.y1 += 30;
        super.y2 += 30;
        //super.enemyHeight = super.magnificationY * this.kh;
        return true;
      }else gameState = 2;
    }
    return false;
  }
  
  
  private void drawBlock(int c, int x, int y){
    switch(c){
      case 1:
        //fill(245, 82, 0);    //brown
        fill(127, 127, 0);
        break;
      case 2:
        fill(0);              // black
        break;
      case 3:
        fill(255, 220, 162);  //white
        break;
      default:
        return;
       
    }
    rect(x, y, super.magnificationX, super.magnificationY);
  }
  
}
