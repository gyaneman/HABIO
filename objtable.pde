
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
