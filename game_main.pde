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
