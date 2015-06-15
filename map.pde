
class mapObject{
  int id = -1;
  //int objState;
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
  
}


class Ground extends mapObject{
  private int w;
  public Ground(int g1,int g2){
    super.x1 = g1;
    super.x2 = g2;
    super.y1 = Height;
    super.y2 = Height - 40;
    w = x2 - x1;
  }
  
  public void drawing(int x){
    noStroke();
    fill(139, 79, 0);
    rect(x+super.x1,Height-40,w,40);
  }
}

class blockLg extends mapObject{
  private int num;
  
  void setup(int instance){
    super.objectWidth = 40;
    super.objectHeight = 40 * blockN[instance][2];
    super.x1 = blockN[instance][0];
    super.y1 = blockN[instance][1];
    super.x2 = super.x1 + super.objectWidth;
    super.y2 = super.y1 - super.objectHeight;
    this.num = blockN[instance][2];
    //super.objState = 1;
    super.id = instance;
  }
  
  public void draw(int offset){
    if(super.id == -1 || offset + Width < super.x1 || offset > super.x2){
      super.id = -1;
      return;
    }
    int by = super.y1;
    for(int i = 0 ; i < this.num ; i++){
      drawBlock(super.x1 - offset, by);
      by -= 40;
    }
  }
  
  private void drawBlock(int x, int y){
    noStroke();
    int xw = x + 40;
    int yh = y - 40;
    fill(232,220,204);
    triangle(x, y, x, yh, xw, yh);
    fill(46,29,7);
    triangle(x, y, xw, yh, xw, y);
    stroke(219,137,29);
    strokeWeight(1);
    line(x, yh, xw, y);
    fill(219,137,29);
    rect(x + 10, y - 3*(40 / 4),40 / 2, 40 / 2);
  }
}



class PIPE extends mapObject{
  private int u_x, u_sx, u_y, u_sy;
  private int d_x, d_sx, d_y, d_sy;
  private final int pipe_w = 3;
  private int pipeHeight;
  private int pipeWidth = 80;
  
  void setup(int instance){
    //println("pipe..." + x + "..." + y + "..." + h);
    
    super.x1 = pipeN[instance][0];
    super.y1 = Height;
    super.x2 = super.x1 + this.pipeWidth;
    super.y2 = super.y1 - pipeN[instance][1];
    //super.y2 = Height - 40;
    //this.pipeHeight;
    
    //println("pipe_2..." + x1 + "..." + y1 + "..." + x2 + "..." + y2);
   
    this.u_x  = super.x1;
    this.u_sx = super.x2;
    this.u_y  = super.y2;
    this.u_sy = this.u_y + 50;
    
    this.d_x  = this.u_x + pipe_w;
    this.d_sx = this.u_sx - pipe_w;
    this.d_y  = this.u_sy;
    this.d_sy = Height;
    
    this.pipeHeight = d_sy - d_y;
    
    //super.objState = 1;
    super.id = instance;
  }
  
  void PDraw(int offset){
    if(super.id == -1 || offset + Width < super.x1 || offset > super.x2){
      super.id = -1;
      return;
    }
    int a = this.u_x - offset;
    int b = this.u_y;
    int c = this.d_x - offset;
    int d = this.d_y;
    //println(height + "..." + Height);
    
    
    //println("pipe..." + a + "..." + b + "..." + c + "..." + d);
    stroke(0);
    strokeWeight(3);
    fill(0, 82, 5);
    rect(this.u_x - offset, this.u_y, this.pipeWidth, 50);
    rect(this.d_x - offset, this.d_y, this.pipeWidth - pipe_w * 2, pipeHeight);
  }
  
}


class cloud extends mapObject{
  void setup(int instance){
    super.x1 = cloudN[instance][0];
    super.y1 = cloudN[instance][1];
    super.x2 = super.x1 + 250;
    //super.objState = 1;
    super.id = instance;
  }

  private void draw(int offset){
    if(super.id == -1 || offset + Width < super.x1 -80 || offset > super.x2 + 20){
      super.id = -1;
      return;
    }
    noStroke();
    fill(200);
    int r = 80;
    int px = x1;
    ellipse(px - offset, y1, r, r);
    px += r / 2;
    r += 10;
    ellipse(px - offset, y1, r, r);
    px += r / 2;
    r += 10;
    ellipse(px - offset, y1, r, r);
    px += r / 2;
    ellipse(px - offset, y1, r, r);
    px += r / 2;
    r -= 10;
    ellipse(px - offset, y1, r, r);
    px += r / 2;
    r -= 10;
    ellipse(px - offset, y1, r, r);     
  }
}


class invisibleBlock extends mapObject{ 
  boolean visibleFlg;
  void bInvisible(){
    visibleFlg = false;
    //println("bbb");
  }
  void bVisible(){
    visibleFlg = true;
    //println("aaa");
  }
  
  private int dx, dy, ex, ey;
  private int num;
  
  void setup(int[] objArray, int instance){
    super.objectWidth = 40;
    super.objectHeight = 40 * invBlockN[2];
    super.x1 = objArray[0];
    super.y1 = objArray[1];
    super.x2 = super.x1 + super.objectWidth;
    super.y2 = super.y1 - super.objectHeight;
    this.num = objArray[2];
    
    //super.objState = 1;
    super.id = instance;
  }
  
  public void draw(int offset){
    //if(offset + Width < super.x1 || offset > super.x2){
      //super.id = -1;
      //return;
    //}
    if(!visibleFlg) return;
    int by = super.y1;
    for(int i = 0 ; i < this.num ; i++){
      drawBlock(super.x1 - offset, by);
      by -= 40;
    }
  }
  
  private void drawBlock(int x, int y){
    noStroke();
    int xw = x + 40;
    int yh = y - 40;
    fill(232,220,204);
    triangle(x, y, x, yh, xw, yh);
    fill(46,29,7);
    triangle(x, y, xw, yh, xw, y);
    stroke(219,137,29);
    //strokeWeight(2);
    line(x, yh, xw, y);
    fill(219,137,29);
    rect(x + 10, y - 3*(40 / 4),40 / 2, 40 / 2);
  }
}



class lastFlag extends mapObject{
  lastFlag(int x, int y, int h){
    super.x1 = x;
    super.y1 = y;
    super.y2 = y - h;
  }
  
  void draw(int offset){
    if(offset + Width + 200 < super.x1 || offset > super.x1) return;
    strokeWeight(10);
    stroke(125);
    line(super.x1 - offset, super.y1, super.x1 - offset, super.y2);
    fill(255,54,54);
    triangle(super.x1 - offset, super.y2, super.x1 - offset, super.y2 + 40, super.x1 - offset + 40, super.y2 + 20);
  }
}
