/** j, d, aキーで操作　　左上の数字が10000になるところがゴールのだいたいの位置<p>
クリアできたら連絡ください<p>
あとあたり判定があれなのは勘弁<p>
4/7 一応旗までたどりつけるようにしたよ*/
// クリアできたらそれバグだから。
class Mario{

  public int x;
  public int y = 499;
  
  public int speed = 0;
  private int maxspeed = 10;
  public  int a = 5;            //kasokudo
  
  private int magnification = 3;
  private int marioWdt = magnification * 15;
  private int marioBtm = magnification * 15;
  
  private int direction = 1;          //Mario direction
  private int timecount = 0;
  private int xw = x + marioWdt;
  private int yh = y - marioBtm;
  
  /* mario dot drawing
      0,white
      1,red
      2,dark brown
      3,brown 
        16 * 16 (dot)  */
  private final int[][] MarioDefault ={
                                 {0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0},
                                 {0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0},
                                 {0,0,0,0,2,2,2,3,3,2,3,0,0,0,0,0},
                                 {0,0,0,2,3,2,3,3,3,2,3,3,3,0,0,0},
                                 {0,0,0,2,3,2,2,3,3,3,2,3,3,3,0,0},
                                 {0,0,0,2,2,3,3,3,3,2,2,2,2,0,0,0},
                                 {0,0,0,0,0,3,3,3,3,3,3,3,0,0,0,0},
                                 {0,0,0,0,2,2,1,2,2,2,0,0,0,0,0,0},
                                 {0,0,0,2,2,2,1,2,2,1,2,2,2,0,0,0},
                                 {0,0,2,2,2,2,1,1,1,1,2,2,2,2,0,0},
                                 {0,0,3,3,2,1,3,1,1,3,1,2,3,3,0,0},
                                 {0,0,3,3,3,1,1,1,1,1,1,3,3,3,0,0},
                                 {0,0,3,3,1,1,1,1,1,1,1,1,3,3,0,0},
                                 {0,0,0,0,1,1,1,0,0,1,1,1,0,0,0,0},
                                 {0,0,0,2,2,2,0,0,0,0,2,2,2,0,0,0},
                                 {0,0,2,2,2,2,0,0,0,0,2,2,2,2,0,0}};
  
  private final int[][] MarioRunning ={
                                 {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                                 {0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0},
                                 {0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0},
                                 {0,0,0,0,0,2,2,2,3,3,2,3,0,0,0,0},
                                 {0,0,0,0,2,3,2,3,3,3,2,3,3,3,0,0},
                                 {0,0,0,0,2,3,2,2,3,3,3,2,3,3,3,0},
                                 {0,0,0,0,2,2,3,3,3,3,2,2,2,2,0,0},
                                 {0,0,0,0,0,0,3,3,3,3,3,3,3,0,0,0},
                                 {0,0,0,0,0,2,2,2,2,1,2,3,3,0,0,0},
                                 {0,0,0,0,3,2,2,2,2,2,2,3,3,3,0,0},
                                 {0,0,0,3,3,2,2,2,2,2,2,3,3,0,0,0},
                                 {0,0,0,2,2,1,1,1,1,1,1,1,0,0,0,0},
                                 {0,0,0,2,1,1,1,1,1,1,1,1,0,0,0,0},
                                 {0,0,2,2,1,1,1,0,1,1,1,0,0,0,0,0},
                                 {0,0,2,0,0,0,0,2,2,2,0,0,0,0,0,0},
                                 {0,0,0,0,0,0,0,2,2,2,2,0,0,0,0,0}};
                          
  private int[][] MarioRunning2={{0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0},
                                 {0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0},
                                 {0,0,0,0,0,2,2,2,3,3,2,3,0,0,0,0},
                                 {0,0,0,0,2,3,2,3,3,3,2,3,3,3,0,0},
                                 {0,0,0,0,2,3,2,2,3,3,3,2,3,3,3,0},
                                 {0,0,0,0,2,2,3,3,3,3,2,2,2,2,3,0},
                                 {0,0,0,0,0,0,3,3,3,3,3,3,3,0,0,0},
                                 {0,0,0,2,2,2,2,1,1,2,2,0,0,0,0,0},
                                 {0,3,3,2,2,2,2,1,1,1,2,2,2,3,3,3},
                                 {0,3,3,3,0,2,2,1,3,1,1,1,2,2,3,3},
                                 {0,3,3,0,0,1,1,1,1,1,1,1,0,0,2,0},
                                 {0,0,0,0,1,1,1,1,1,1,1,1,1,2,2,0},
                                 {0,0,0,1,1,1,1,1,1,1,1,1,1,2,2,0},
                                 {0,0,2,2,1,1,1,0,0,0,1,1,1,2,2,0},
                                 {0,0,2,2,2,0,0,0,0,0,0,0,0,0,0,0},
                                 {0,0,0,2,2,2,0,0,0,0,0,0,0,0,0,0}};
                          
  private final int[][] MarioJumping ={
                                 {0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3},
                                 {0,0,0,0,0,0,1,1,1,1,1,0,0,3,3,3},
                                 {0,0,0,0,0,1,1,1,1,1,1,1,1,1,3,3},
                                 {0,0,0,0,0,2,2,2,3,3,2,3,0,2,2,2},
                                 {0,0,0,0,2,3,2,3,3,3,2,3,3,3,2,2},
                                 {0,0,0,0,2,3,2,2,3,3,3,2,3,3,3,2},
                                 {0,0,0,0,2,2,3,3,3,3,2,2,2,2,0,0},
                                 {0,0,0,0,0,0,3,3,3,3,3,3,3,0,0,0},
                                 {0,0,2,2,2,2,2,1,2,2,2,1,2,0,0,0},
                                 {0,2,2,2,2,2,2,2,1,2,2,2,1,0,0,2},
                                 {3,3,2,2,2,2,2,2,1,1,1,1,1,0,0,2},
                                 {3,3,3,0,0,1,2,1,1,1,3,2,3,1,2,2},
                                 {0,3,0,2,0,1,1,1,1,1,1,1,1,1,2,2},
                                 {0,0,2,2,2,1,1,1,1,1,1,1,1,1,2,2},
                                 {0,2,2,2,1,1,1,1,1,1,1,0,0,0,0,0},
                                 {0,2,0,0,1,1,1,1,0,0,0,0,0,0,0,0}};
                                 
   
  private final int[][] MarioDead = {
                                {0,0,0,0,0,0,2,2,2,2,0,0,0,0,0,0},
                                {0,0,0,2,0,2,1,1,1,1,2,0,2,0,0,0},
                                {0,2,2,3,2,1,1,1,1,1,1,2,3,2,2,0},
                                {2,3,3,3,2,3,2,3,3,2,3,2,3,3,3,2},
                                {2,3,3,1,3,3,2,3,3,2,3,3,1,3,3,2},
                                {2,3,1,1,3,2,3,3,3,3,2,3,1,1,3,2},
                                {0,2,2,1,3,2,3,3,3,3,2,3,1,2,2,0},
                                {0,0,0,2,3,3,2,2,2,2,3,3,2,0,0,0},
                                {0,0,0,2,2,3,3,2,2,3,3,2,2,0,0,0},
                                {0,0,2,2,2,2,3,3,3,3,2,2,2,2,0,0},
                                {0,2,1,1,2,2,1,1,1,1,2,2,1,1,2,0},
                                {0,2,1,1,1,2,2,1,1,2,2,1,1,1,2,0},
                                {0,2,1,1,1,2,3,2,2,3,2,1,1,1,2,0},
                                {0,2,1,1,1,2,2,2,2,2,2,1,1,1,2,0},
                                {0,0,2,1,1,2,2,2,2,2,2,1,1,2,0,0},
                                {0,0,0,2,2,0,0,0,0,0,0,2,2,0,0,0}};
                          

  private int jmpcnt = 0;
  private int ySpeed = 0;
  private int g = 4;
  private int jmpY;
  private boolean jmpflg = false;
 
  //private int direction = 1;
  private int ms=1;
  
  
  //private boolean jmpflg = false;
  private void drawing(int s){
    if(jmpflg == false){
      switch(s){
        case 0:
          nomove();
          break;
        case 1:
          movRight();
          break;
        case 2:
          movLeft();
          break;
        case 3:
          //jumping();
          MarioMoving(MarioJumping);
          break;
        case 4:
          MarioMoving(MarioDead);
          break;
      }
    }/*else{
      jmpflg = jumping();
      MarioMoving(MarioJumping);
    }*/
    //if(Math.abs(state) != 3) state = state / Math.abs(state);
  }
   
   
    
  private void movRight(){
    
    //marioSpeed('R');
    if(this.speed - a > -maxspeed) this.speed -= a;
    else this.speed = -maxspeed;
    
    //state = 2;
    direction = 1;
    if(timecount >= 5){
      timecount = 0;
      ms *= -1;
    }
    if(ms == 1) MarioMoving(MarioRunning);
    if(ms == -1)MarioMoving(MarioRunning2);
    timecount += 1;
  }
  
  private void movLeft(){
    
    //marioSpeed('L');
    if(this.speed + a < maxspeed) this.speed += a;
    else this.speed = maxspeed;
    
    //state = -2;
    direction = -1;
    if(timecount >= 5){
      timecount = 0;
      ms *= -1;
    }
    if(ms == 1) MarioMoving(MarioRunning);
    if(ms == -1)MarioMoving(MarioRunning2);
    timecount += 1;
  }
    
  private void nomove(){
    if(0 < this.speed) this.speed -= a;
    if(0 > this.speed) this.speed += a;
    MarioMoving(MarioDefault);
  }
  
  
  
  
  private void MarioMoving(int[][] mariostate){
    int xc = x,    yc = y;// + magnification;
    for(int i=mariostate.length-1;i>=0;i--){
      if(direction > 0){
        for(int j=0;j<mariostate.length;j++){
          DefaultDraw(i,j,xc,yc,mariostate);
          xc += magnification;
        }
      }else if(direction < 0){
        for(int j=mariostate.length-1;j>=0;j--){
          DefaultDraw(i,j,xc,yc,mariostate);
          xc += magnification;
        }
      }
      xc = x;
      yc -= magnification;
    }
  }
  
  private void DefaultDraw(int blX,int blY,int xc,int yc,int[][] DMario){
    strokeWeight(1);
    switch(DMario[blX][blY]){
      case 0:
        break;
      case 1:
        //stroke(color(255,0,0));
        DrawBlock(xc,yc,'r');
        //colorMode(RGB,255,0,0);
        //rect(xc,yc,xc+1,yc+1);
        break;
      case 2:
        //stroke(color(125,125,0));
        DrawBlock(xc,yc,'b');
        //colorMode(RGB,126,126,0);
        //rect(xc,yc,xc+1,yc+1);
        break;
      case 3:
        //stroke(color(64,64,64));
        DrawBlock(xc,yc,'y');
        //colorMode(RGB,64,64,64);
        //rect(xc,yc,xc+1,yc+1);
        break;
    }
  }
  
  private void DrawBlock(int posX,int posY,char c){
    switch(c){
      case 'r':
        //stroke(color(255, 0, 0));
        stroke(color(0, 0, 255));
        break;
      case 'b':
        //stroke(color(139,69,45));
        stroke(color(255, 0, 0));
        break;
      case 'y':
        stroke(color(244,164,96));
        break;
    }
    for(int i=0;i<magnification;i++){
      for(int j=0;j<magnification;j++){
        point(posX-i,posY-j);
      }
    }
  }
}
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
final int Width =  960;
final int Height = 540;

int gameState = 0;

void setup(){
  size(960,540);
  frameRate(30);
  background(0);
  map = new MAP();
  
  String[] line = loadStrings("kuribopos.txt");
  int l = int(line[0]);
  int c = 1;
  initKuriboN = new int[l][2];
  for(int i = 0 ; i < l ; i++){
    for(int j = 0 ; j < 2 ; j++){
      initKuriboN[i][j] = int(line[c]);
      c++;
    }
  }
  line = loadStrings("blockpos.txt");
  l = int(line[0]);
  c = 1;
  blockN = new int[l][3];
  for(int i = 0 ; i < l ; i++){
    for(int j = 0 ; j < 3 ; j++){
      blockN[i][j] = int(line[c]);
      c++;
    }
  }
  line = loadStrings("pipepos.txt");
  l = int(line[0]);
  c = 1;
  pipeN = new int[l][2];
  for(int i = 0 ; i < l ; i++){
    for(int j = 0 ; j < 2 ; j++){
      pipeN[i][j] = int(line[c]);
      c++;
    }
  }
  kuriboN = new int[initKuriboN.length][2];
  kuriboflg = new boolean[initKuriboN.length];
}


MAP map;
Mario mario = new Mario();


void draw(){
  background(129,170,255);
  switch(gameState){
    case 0:
      startScreen();
      break;
    case 1:
      if(key_a == true){
        map.mapscrol(-10);
        if(!jmp_flg) mario.drawing(2);
        else mario.drawing(3);
      }else
      if(key_d == true){
        map.mapscrol(10);
        if(!jmp_flg) mario.drawing(1);
        else mario.drawing(3);
      }else{
        map.mapscrol(0);
        if(!jmp_flg) mario.drawing(0);
        else mario.drawing(3);
      }
      break;
    case 2:
      map.stopScrol();
      gameOver();
      break;
    default:
      //println("error");
  }
}




boolean key_a = false;
boolean key_d = false;
boolean key_j = false;

void keyPressed(){
  if(key == 'a' || key == LEFT){
    key_d = false;
    key_a = true;
  }else
  if(key == 'd' || key == RIGHT){
    key_a = false;
    key_d = true;
  }else
  if(key == 'j' || key == UP){
    key_j = true;
  }
}


void keyReleased(){
  if(key == 'a' || key == LEFT){
    key_a = false;
  }else
  if(key == 'd' || key == RIGHT){
    key_d = false;
  }else
  if(key == 'j' || key == UP){
    key_j = false;
  }
}


int x = 0,   y = 0;
boolean jmp_flg = false;

final int gh = Height-40;


  private PIPE[] pipe = new PIPE[4];
  private kuribo[] bou = new kuribo[5];
  private cloud[] cld = new cloud[4];
  private blockLg[] bllg = new blockLg[14];
  //private invisibleBlock[] inviBlock = new invisibleBlock[2];
  private lastFlag lflg = new lastFlag(9820, Height - 80, 300);

class MAP{
  private final int mapWIDTH = 10000;
  private final int mapHEIGHT = Height;
  private Ground[] ground = new Ground[8];

  
  private objTable table;
  
  private int offset = 0;
  final private int mario_offset = Width / 2 - 40;
  private final int Gravity = 3;
  private final int initial_v = 35;
  //private boolean jmp_flg = false;
  private final int jmpmax = 7;
  
  
  public MAP(){
    for(int i = 0 ; i < pipe.length ; i++){
      pipe[i] = new PIPE();
    }
    for(int i = 0 ; i < bou.length ; i++){
      bou[i] = new kuribo();
    }
    for(int i = 0 ; i < cld.length ; i++){
      cld[i] = new cloud();
    }
    for(int i = 0 ; i < bllg.length ; i++){
      bllg[i] = new blockLg();
    }
    //for(int i = 0 ; i < inviBlock.length ; i++){
    //  inviBlock[i] = new invisibleBlock();
    //}
    table = new objTable();
    //inviBlock[0].setup(invBlockN, 0);
    
    ground[0] = new Ground(0,    2000);
    ground[1] = new Ground(2100, 3000);
    ground[2] = new Ground(3400, 4400);
    ground[3] = new Ground(4600, 5000);
    ground[4] = new Ground(6600, 7000);
    ground[5] = new Ground(8000, 8500);
    ground[6] = new Ground(9035, 9440);
    ground[7] = new Ground(9780, 10000);
  }
  
  void setup(){
    x = 0;
    y = Height - 41;
    mario.y = Height - 41;
    for(int i = 0; i < kuriboN.length ; i++){
      for(int j = 0; j < 2 ; j++){
        kuriboN[i][j] = initKuriboN[i][j];
      }
      kuriboflg[i] = false;
    }
    for(int i = 0 ; i < bou.length ; i++){
      bou[i].id = -1;
    }
    //inviBlock[0].bInvisible();
  }
  
  /*
   * map scrol method !!!!!
   */
  private int newX, newY;
  private int jmpcount = 0;
  public boolean mapscrol(int mv){
    int ex = 0;
    int dx = 0;
    boolean ret = true;
    //int marioPos = offset;
    int marioPos = mario_offset;
    
    // update marioPos
    if(key_j && jmpcount < jmpmax){
      jmpcount++;
      mario.ySpeed = -18;
      jmp_flg = true;
    }
    else{
      mario.ySpeed += Gravity;
      jmpcount = jmpmax;
    }
    if(mario.ySpeed >= 18) mario.ySpeed = 18;
    newY = mario.y + mario.ySpeed;
    
    
    newX = x + mv;
    //dprintln(mario.ySpeed);
    
    
    if(newX < 0){
      newX = 0;
    }else if(newX > mapWIDTH - 100){
      newX = mapWIDTH - 100;
    }
    
    
    // Collision detection
    for(int i=0; i<ground.length; i++){
      //if(atari_juge(ground[i], newX - x, mario.ySpeed)) println("ground" + i);
      atari_juge(ground[i], newX - x, mario.ySpeed);
    }
    for(int i=0; i<pipe.length; i++){
      //if(atari_juge(pipe[i], newX - x, mario.ySpeed)) println("pipe" + i);
      atari_juge(pipe[i], newX - x, mario.ySpeed);
    }
    for(int i=0; i<bllg.length; i++){
      atari_juge(bllg[i], newX - x, mario.ySpeed);
    }
    //for(int i=0; i<inviBlock.length; i++){
    //  if(atari_juge(inviBlock[0], newX - x, mario.ySpeed)){
    //    inviBlock[0].bVisible();
    //  }
    //}
    //ok
    
    if(newY > Height + 5 * 16){
      gameState = 2;
      newY = Height + 5 * 20;
    }
    
    
    // Coordinate determination
    x = newX;
    y = newY;
    mario.y = newY;
    
    
    // Scrol and determination mario's pos
    if(newX < mario_offset){
      offset = 0;
      marioPos = newX;
    }else if(newX > mapWIDTH - Width + mario_offset){
      offset = mapWIDTH - Width;
      marioPos = newX - offset;
    }else{
      offset = newX - mario_offset;
      marioPos = mario_offset;
    }
    
    
    // kuribo update
    for(int i=0; i<bou.length ; i++){
      if(bou[i].update(offset)){
        bou[i].collJge(bllg);
        bou[i].collJge(ground);
        bou[i].collJge(pipe);
      }
    }
    for(int i=0; i<bou.length ; i++){
      if(!bou[i].deadflg && bou[i].collMario(x, y)){
        mario.ySpeed = -20;
        break;
      }
    }
    
    table.objcheck(offset);
    
    
    for(int i=0; i<bou.length ; i++){
      if(bou[i].id >= 0) bou[i].copyPos();
      bou[i].draw(offset);
    }

    //println("newX = "+ newX + ",  " + "newY = " + newY + ",  " + offset + "..." + marioPos);
    int tst = ground[0].y2 + 33;
    //println("ground[0] = " + ground[0].y2 + "..." + tst);
    mario.x = marioPos;
    
    
    lflg.draw(offset);
    /*for(int i=0;i < BLOCK.length;i++){
      if((-50 < (ex = -offset + BLOCK[i].getXpos())) && (ex < Width + 10)){
        BLOCK[i].drawing(ex,BLOCK[i].getYpos());
      }
    }*/
    for(int i=0; i<pipe.length; i++){
      pipe[i].PDraw(offset);
    }
    for(int i=0;i < ground.length;i++){
      ground[i].drawing(-offset + ground[i].getXpos());
    }
    for(int i=0; i < bllg.length; i++){
      bllg[i].draw(offset);
    }
    for(int i=0; i<cld.length ; i++){
      cld[i].draw(offset);
    }
    //for(int i=0; i<inviBlock.length ; i++){
      //inviBlock[0].draw(offset);
    //}
    
    stroke(0);
    fill(0);
    textSize(25);
    text(x, 40,40);

    return ret;
  }
  
  
  
  private void stopScrol(){
    int ex;
    lflg.draw(offset);
    for(int i=0 ; i < bou.length ; i++){
      bou[i].draw(offset);
    }
    /*for(int i=0 ; i < BLOCK.length ; i++){
      if((-50 < (ex = -offset + BLOCK[i].getXpos()) && (ex < Width + 10))){
        BLOCK[i].drawing(ex, BLOCK[i].getYpos());
      }
    }*/
    for(int i=0 ; i < pipe.length ; i++){
      pipe[i].PDraw(offset);
    }
    for(int i=0 ; i < ground.length ; i++){
      ground[i].drawing(-offset + ground[i].getXpos());
    }
    for(int i=0 ; i < bllg.length ; i++){
      bllg[i].draw(offset);
    }
    for(int i=0 ; i<cld.length ; i++){
      cld[i].draw(offset);
    }
    //for(int i=0 ; i<inviBlock.length ; i++){
    //  inviBlock[i].draw(offset);
    //}
  }
  
  
  
  private boolean atari_juge(mapObject mpobj, int mv_x, int mv_y){
    if(newX < mpobj.x2 && newY > mpobj.y2 && newX + mario.marioWdt > mpobj.x1 && newY - mario.marioBtm < mpobj.y1){
      
      if(mv_y >= 0 && newY >= mpobj.y2 && newY <= mpobj.y2 + 18){
        newY = mpobj.y2 - 1;
        jmp_flg = false;
        mario.ySpeed = 0;
        jmpcount = 0;
        //println("ue");
        return true;
      }
      if(mv_y <= 0 && newY - mario.marioBtm <= mpobj.y1 && newY - mario.marioBtm >= mpobj.y1 - 18){
        newY = mpobj.y1 + mario.marioBtm + 1;
        //println("shita");
        mario.ySpeed *= -1;
        jmpcount = jmpmax;
        return true;
      }
      
      if(mv_x >= 0 && newX + mario.marioWdt >= mpobj.x1 && newX + mario.marioWdt <= mpobj.x1 + 11){
        newX = mpobj.x1 - mario.marioWdt;
        //println("hidari");
        return true;
      }
      if(mv_x <= 0 && newX <= mpobj.x2 && newX >= mpobj.x2 - 11){
        newX = mpobj.x2 + 1;
        //println("migi");
        return true;
      }
      
      return true;
    }
    return false;
  }
}

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

int[][] initKuriboN;
int[][] kuriboN;
boolean[] kuriboflg;

int[][] blockN;
int[][] pipeN;
int[] invBlockN = {9440, gh - 460, 3};
int[][] cloudN = new int[16][2];
  
class objTable{
  
  objTable(){
    int clw = 0;
    int cn = 0;
    for(int i=0; i < 4 ; i++){
      clw = i * 2500;
      cloudN[cn][0] = clw + 300;
      cloudN[cn][1] = Height - 400;
      cn++;
      cloudN[cn][0] = clw + 900;
      cloudN[cn][1] = Height - 450;
      cn++;
      cloudN[cn][0] = clw + 1300;
      cloudN[cn][1] = Height - 380;
      cn++;
      cloudN[cn][0] = clw + 2300;
      cloudN[cn][1] = Height - 430;
      cn++;
    }
  }
  
  
  void objcheck(int offset){
    int newId;
    for(int i = 0 ; i < kuriboN.length ; i++){
      if(offset + Width >= kuriboN[i][0] && offset <= kuriboN[i][0] + 50){
        //bou[unUsedObj(bou)].setup(kuriboN, i);
        newId = unUsedObj(bou, i);
        if(newId >= 0) bou[newId].setup(i);
      }
    }
    for(int i = 0 ; i < blockN.length ; i++){
      if(offset + Width >= blockN[i][0] && offset <= blockN[i][0] + 40){
        //bllg[unUsedObj(bllg)].setup(blockN, i);
        newId = unUsedObj(bllg, i);
        if(newId >= 0) bllg[newId].setup(i);
      }
    }
    for(int i = 0 ; i < pipeN.length ; i++){
      if(offset + Width >= pipeN[i][0] && offset <= pipeN[i][0] + 80){
        //pipe[unUsedObj(pipe)].setup(pipeN, i);
        newId = unUsedObj(pipe, i);
        if(newId >= 0) pipe[newId].setup(i);
      }
    }
    for(int i = 0 ; i < cloudN.length ; i++){
      if(offset + Width >= cloudN[i][0] - 80 && offset <= cloudN[i][0] + 250){
        //cld[unUsedObj(cld)].setup(cloudN, i);
        newId = unUsedObj(cld, i);
        if(newId >= 0) cld[newId].setup(i);
      }
    }
  }
  
  int unUsedObj(mapObject[] obj, int num){
    int unused = -2;
    for(int i = 0 ; i < obj.length ; i++){
      if(obj[i].id == -1) unused = i;
      if(obj[i].id == num) return -1;
    }
    //if(unused == -2) println("error");
    return unused;
  }
  
}
int count = 0;
void startScreen(){
  int select_pointer = 0;
  int string_x = Width / 2;
  int string_y = Height / 2 + 150;
  int title_x = Width / 2 - 230;
  int title_y = Height / 2 - 100;
  
  noStroke();
  fill(255, 214, 183);
  triangle(220, 20, 780, 20, 220, 330);
  fill(26, 11, 0);
  triangle(780, 20, 220, 330, 780, 330);
  fill(149, 65, 0);
  rect(225, 25, 550, 300);
  
  
  int zure = 9;
  //PFont font;
  //font = loadFont("ComicSansMS-Bold-70.vlw");
  textSize(70);
  //textFont(font);
  textAlign(LEFT);
  fill(33, 17, 0);
  text("SUPER", title_x + zure, title_y - 50 + zure);
  text("HABIO BROS." , title_x + zure, title_y + 25 + zure);
  text("(Provisional)", title_x + zure, title_y + 100 + zure);
  fill(255, 214, 183);
  text("SUPER", title_x, title_y - 50);
  text("HABIO BROS.", title_x, title_y + 25);
  text("(Provisional)",  title_x, title_y + 100);
  
  if(count < 20) {
    textSize(30);
    textAlign(CENTER);
    fill(255, 214, 173);
    text("CLICK SCREEN OR PRESS", string_x, string_y);
    text("ANY KEY TO BEGIN", string_x, string_y + 50);
  }else if(count >= 40) count = 0;
  count++;
  
  if(keyPressed || mousePressed){
    map.setup();
    gameState = 1;
  }
}


int gameover_v = -35;
int cnt = 0;
void gameOver(){
  int a = 5;
  if(cnt < 15){
    mario.drawing(4);
    cnt++;
  }else{
    mario.y = mario.y + gameover_v;
    gameover_v += a;
    if(mario.y > Height + 5 * 16){
      mario.y = Height + 5 * 16;
      cnt++;
    }
    mario.drawing(4);
  }
  if(cnt >= 30){
    x = 0;
    y = 0;
    map.setup();
    cnt = 0;
    gameover_v = -35;
    gameState = 0;
  }
}

