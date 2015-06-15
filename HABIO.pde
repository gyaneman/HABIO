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
