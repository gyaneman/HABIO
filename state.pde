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
