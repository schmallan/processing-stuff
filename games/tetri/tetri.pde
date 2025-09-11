//Alan Li, programming 1
//not tetris

public void setup(){ 
  noStroke();
  background(60);
  frameRate(30);
  size(600,730);
  
  textSize(35);
  
  text("Victris",30,50);
  //text("Legally Distinct Block Stacking Game",30,50);
  
  text("next piece",margins[0]+sqz*12,margins[1]+sqz*5);
  text("hold",margins[0]+sqz*13.3,margins[1]+sqz*12);
  
  
  fill(255);
  text("score: "+score,margins[0]+sqz*12,margins[1]+sqz*15);
  
  
  text("level: "+level,margins[0]+sqz*12,margins[1]+sqz*17);
  
  
  text("[pause]",margins[0]+sqz*14,margins[1]+sqz*20);
  
  //initialise grid arrays to -1
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 10; j++) {
        grid[j][i] = -1;
    }
  }
  clearpgrid();
  
  //define tetronimos (pieces)
  
  //T shape
  pieces[0] = new int[][][]{
    {{0,0},{-1,0},{0,-1},{1,0}},
    {{0,0},{-1,0},{0,-1},{0,1}},
    {{0,0},{-1,0},{0,1},{1,0}},
    {{0,0},{0,-1},{0,1},{1,0}},
  };
  
  
  //{{-1,-1},{-1,0},{-1,1},{0,-1},{0,1},{1,-1},{1,0},{1,1}},
  //{{-1,-1},{-1,0},{-1,1},{0,-1},{0,1},{1,-1},{1,0},{1,1}},
  //{{-1,-1},{-1,0},{-1,1},{0,-1},{0,1},{1,-1},{1,0},{1,1}},
  //{{-1,-1},{-1,0},{-1,1},{0,-1},{0,1},{1,-1},{1,0},{1,1}},
  //square
  pieces[1] = new int[][][]{
  {{0,0},{0,-1},{1,-1},{1,0}},
  {{0,0},{0,-1},{1,-1},{1,0}},
  {{0,0},{0,-1},{1,-1},{1,0}},
  {{0,0},{0,-1},{1,-1},{1,0}},
  };
  
  //line
  pieces[2] = new int[][][]{
  {{0,0},{-1,0},{1,0},{-2,0}},
  {{0,0},{0,2},{0,-1},{0,1}},
  {{0,0},{-1,0},{1,0},{2,0}},
  {{0,0},{0,-2},{0,-1},{0,1}},
  };
  
  //reverse L
  pieces[3] = new int[][][]{
  {{0,0},{-1,0},{1,0},{-1,-1}},
  {{0,0},{0,-1},{0,1},{-1,1}},
  {{0,0},{-1,0},{1,0},{1,1}},
  {{0,0},{0,-1},{1,-1},{0,1}},
  };
  
  //Z shape
  pieces[4] = new int[][][]{
  {{0,0},{0,-1},{-1,-1},{1,0}},
  {{0,0},{-1,0},{0,-1},{-1,1}},
  {{0,0},{-1,0},{0,1},{1,1}},
  {{0,0},{0,1},{1,0},{1,-1}},
  };
  
  //S shape
  pieces[5] = new int[][][]{
  {{0,0},{-1,0},{1,-1},{0,-1}},
  {{0,0},{-1,-1},{-1,0},{0,1}},
  {{0,0},{1,0},{0,1},{-1,1}},
  {{0,0},{0,-1},{1,0},{1,1}},
  };
  
  //L shape
  pieces[6] = new int[][][]{
  {{0,0},{-1,0},{1,0},{1,-1}},
  {{0,0},{0,-1},{-1,-1},{0,1}},
  {{0,0},{-1,0},{1,0},{-1,1}},
  {{0,0},{0,-1},{0,1},{1,1}},
  };
  
  //bag randomize once
  pqueue[7] = (int)Math.floor(Math.random()*7);
  bagrandomize();
  
  
  previewdrawpiece(pqueue[cq],0,12,0);
  previewdrawpiece(currenthold,0,12,7);
}

  //initialise array pieces[piece no][rotation][coord instance][x/y]
  int pieces[][][][] = new int[7][4][][];
 
  //initialise cursor tuple
  int cdX = 5;
  int cdY = 2;
  int cursor[] = new int[]{cdX,cdY};
  
  //define piece grid (only for current moving piece)
  int pgrid[][] = new int[10][20];
  
  //define game grid 
  int grid[][] = new int[10][20];
  
  //square size and game board margins
  int sqz = 30;
  int margins[] = new int[]{30,100};
  
  //define current piece and rotation (will be updated)
  int currentpiece = 0;
  int currentrotation = 0;
  
  int totallines = 0;
  
  //hold variables
  int currenthold = -1;
  int swaps = 1;
  
  int score = 0;
  int level = 1;
  int lastwin = -1;
  boolean paused = false;
  
  
  int[][] palettelist = {
    
  //spectrum
  {#f94144,#f3722c,#f8961e,#f9c74f,#90be6d,#43aa8b,#577590,30,40},  
  
  //coffee
  {#ede0d4,#e6ccb2,#ddb892,#b08968,#7f5539,#9c6644,#b08569,30,40},
   
  //lychee
  {#fdf1cb,#f0ccb4,#e3a69d,#d78186,#ca5b6f,#bd3658,#b01041,30,40},
  
  //clay rainbow
  {#588b8b,#ffffff,#ffd5c2,#f28f3b,#c8553d,#62699B,#93b7be,30,40},
  
  //pastel
  {#b6e2dd,#c8ddbb,#e9e5af,#fbdf9d,#fbc99d,#fbb39d,#fba09d,30,40},
  
  //terracotta
  {#797d62,#9b9b7a,#d9ae94,#f1dca7,#ffcb69,#d08c60,#997b66,30,40},
  
  //highlighter
  {#0ad2ff,#2962ff,#9500ff,#ff0059,#ff8c00,#b4e600,#0fffdb,30,40},  
  
  //pink
  {#ff9286,#fbb3a5,#ffc5ba,#ffe5e5,#f4b7c6,#ff92b1,#fe7295,30,40},
  
  
  };
  
  int[] palette = palettelist[0];

//draw square
public void drawsqr(float x, float y,int hue){
    colorMode(RGB,255,255,255);
    
    //fills based on hue arg
    switch(hue){
      case 0:
        fill(palette[0]);
        break;
      case 1:
        fill(palette[1]);
        break;
      case 2:
        fill(palette[2]);
        break;
      case 3:
        fill(palette[3]);
        break;
      case 4:
        fill(palette[4]);
        break;
      case 5:
        fill(palette[5]);
        break;
      case 6:
        fill(palette[6]);
        break;
      case -1:
        if(x%2==0){ fill(palette[7]);}else{ fill(palette[8]);}
       
        break;
      case -2:
        fill(255);
        break;
      case -3:
        fill(0);
        break;
      default:
        fill(255);
    }
    
    
    float cx = margins[0]+x*sqz;
    float cy = margins[1]+y*sqz;
    rect(cx,cy,sqz,sqz);
    
    colorMode(RGB,255,255,255);
}

//reset piece grid to -1
public void clearpgrid(){
  pgrid = new int[10][20];
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 10; j++) {
        pgrid[j][i] = -1;
    }
  }
}

//draw the current piece on the piece grid
public void drawpiece(int pieceno,int rot){
  clearpgrid();
  
  //array of current selected piece and rotation
  int carray[][] = pieces[pieceno][rot];
  
  //for each coordinate in piece map, copy to pgrid
  for (int i = 0; i < carray.length; i++){
    int cx = cursor[0]+carray[i][0];
    int cy = cursor[1]+carray[i][1];
    pgrid[cx][cy] = pieceno;
  }
}

//same function but for drawing the preview window
public void previewdrawpiece(int pieceno,int rot, int x, int y){
  
  //redraw preview box
  fill(palette[7]);
  rect(margins[0]+sqz*x,margins[1]+sqz*y,sqz*5,sqz*4);
  
  if (pieceno == -1){return;}
  
  int carray[][] = pieces[pieceno][rot];
  
  for (int i = 0; i < carray.length; i++){
    float cx = x+2+carray[i][0];
    float cy = y+2+carray[i][1];
    
    if (pieceno == 1){
      cx = cx-0.5;
    }
    if (pieceno == 2){
      cx = cx+0.5;
      cy = cy-0.5;
    }
    
    drawsqr(cx,cy,pieceno);
  }
}

void mousePressed(){
  if (mouseX>margins[0]+sqz*10){
    if ((mouseY>300)&&(mouseY<470)){
      holdswap();
    }
    
    if (mouseY>600){
      
      if (paused){
        fill(60);
        paused=false;
        rect(margins[0]+sqz*13,margins[1]+sqz*19,250,50);
        fill(255);
        text("[pause]",margins[0]+sqz*14,margins[1]+sqz*20);
        print("\nunpaused");

      }else{
        fill(60);
        paused=true;
        rect(margins[0]+sqz*13,margins[1]+sqz*19,250,50);
        
        fill(255);
        text("[unpause]",margins[0]+sqz*13.5,margins[1]+sqz*20);
        print("\npaused");
      }
    }
  } else {
    if (paused) return;
    int mx = (int)Math.floor((mouseX-margins[0])/sqz);
    int my = (int)Math.floor((mouseY-margins[1])/sqz);
    int xd = Math.abs(cursor[0]-mx);
    int yd = Math.abs(cursor[1]-my);
    
    if(xd<=1 && yd<=1){
      int loop;
      if (currentrotation == 0){
          loop = 3;
        } else {
          loop = currentrotation-1;
        }
      if (!(checkcollision(currentpiece,loop,0,0))){
        currentrotation = loop;
      }
    } else {
      if (mouseY<600){
        int xpos = (int)Math.abs((mouseX-margins[0])/sqz);
          if (!(checkcollision(currentpiece,currentrotation,xpos-cursor[0],0))){
            cursor[0] = xpos;
         }
      } else {
       while (!(checkcollision(currentpiece,currentrotation,0,1))){
        cursor[1] = cursor[1]+1;
        cframe = fpt-1;
        score = score+2;
        scoreupdate();
        } 
      }
    }
  }
}

//check collision of piece at provided arguments, return true if collision
public boolean checkcollision(int pieceno,int rot,int offsetX,int offsetY){

  int carray[][] = pieces[pieceno][rot];
 
  //check collision for each point
  for (int i = 0; i < carray.length; i++){
    int cx = cursor[0]+carray[i][0]+offsetX;
    int cy = cursor[1]+carray[i][1]+offsetY;
    
    boolean xinbound = (cx >= 0) && (cx < 10);
    boolean yinbound = (cy >= 0) && (cy < 20);
    
    debugdrawsqr(cx,cy);
    
    if (!(xinbound && yinbound)){
      //if out of bounds return true
      return true;
      
    } else {
      if (!(grid[cx][cy]==-1)){
        //if there is a square already there return true
        return true;
      }
    }
  }
  return false;
}

//run every frame, draws all the squares from each board
public void drawboards(){
  
  for (int py = 0; py < 20; py++) {
    for (int px = 0; px < 10; px++) {
      //!(grid[px][py]==-1)
      if (true){
       
        drawsqr(px,py,grid[px][py]);
      }
    }
  }
  for (int py = 0; py < 20; py++) {
    for (int px = 0; px < 10; px++) {
      if (!(pgrid[px][py]==-1)){
        drawsqr(px,py,currentpiece);
      }
    }
  }
  
}


public void debugdrawsqr(int x, int y){
    //draw square but yellow, for testing
    colorMode(RGB,255,255,255);
    fill(255,255,0);
    float cx = margins[0]+x*sqz;
    float cy = margins[1]+y*sqz;
    //rect(cx,cy,sqz,sqz);
}

void holdswap(){
 if (!(swaps==0)){
      print(currenthold);
      swaps = swaps-1;
      if (currenthold == -1){
        currenthold = currentpiece;
          //draw new piece
          bagrandomize();
          previewdrawpiece(pqueue[cq],0,12,0);
          currentrotation = 0;
      }else{
        int temp = currentpiece;
        currentpiece = currenthold;
        currenthold = temp;
      }
      print(">"+currenthold+".");
      previewdrawpiece(currenthold,0,12,7);
      //reset cursor
      cursor[0] = cdX;
      cursor[1] = cdY;
 }
}

//input handler
void keyPressed(){
  if (paused){return;}
  if (flashing){return;}
  if (key == 'w'){
      holdswap();
  
    
  }
  
  //check collision then move based on key press
  if (key == 'a'){
    if (!(checkcollision(currentpiece,currentrotation,-1,0))){
      cursor[0] = cursor[0]-1;
    }
  }
  if (key == 'd'){
    if (!(checkcollision(currentpiece,currentrotation,1,0))){
      cursor[0] = cursor[0]+1;
    }
  }
  if (key == 's'){
    if (!(checkcollision(currentpiece,currentrotation,0,1))){
      cursor[1] = cursor[1]+1;
      score = score+1;
      scoreupdate();
      cframe = 0;
    }
  }
  if (key == ' '){
    while (!(checkcollision(currentpiece,currentrotation,0,1))){
      cursor[1] = cursor[1]+1;
      cframe = fpt-1;
      score = score+2;
      scoreupdate();
    }
  }
  //same with rotation
  if (key == 'q'){
    int loop;
    if (currentrotation == 3){
        loop = 0;
      } else {
        loop = currentrotation+1;
      }
    if (!(checkcollision(currentpiece,loop,0,0))){
      currentrotation = loop;
    }
  }
  if (key == 'e'){
    int loop;
    if (currentrotation == 0){
        loop = 3;
      } else {
        loop = currentrotation-1;
      }
    if (!(checkcollision(currentpiece,loop,0,0))){
      currentrotation = loop;
    }
  }
  
}

//define current frame
int cframe;

//frames per game tick
int fpt = 30;

int flashticks = 20;
void draw(){
  if (paused){return;}
  
  if (flashing){
    if (flashticks%2==1){
      flashwhite();
      drawboards();
    }else{
      flashblack();
      drawboards();
    }
    
    if (flashticks == 0){
      flashing = false;
      flashticks = 20;
      for (int i = 0; i < 20; i++){
        if (winlines[i] == 1){
          shiftgrid(i);
        }
      }  
    }
    flashticks--;
    return;
  }
  //draw current piece
  drawpiece(currentpiece,currentrotation );
  
  //draw the game interface?
  //fill(20);
  //rect(margins[0],margins[1],300,600);
  
  
  //update screens
  drawboards();
  
  //once every fpt frame, tick the game
  if (cframe == fpt-1){
    cframe = 0;
    print("|");
    gametick();
  } else {
    cframe++;
  }
}

//runs once per tick
void gametick(){
  
  //if piece can move down one,
  if (!checkcollision(currentpiece,currentrotation,0,1)){
    //move down one
    cursor[1] = cursor[1]+1;
  } else {
    
    print("p"+currentpiece+".");
    
    //otherwise flatten
    flatten();
    
    //reset cursor
    cursor[0] = cdX;
    cursor[1] = cdY;
    
    //draw new piece
    bagrandomize();
    previewdrawpiece(pqueue[cq],0,12,0);
    currentrotation = 0;
    
    swaps = 1;
    
    //check win
    checkwin();
    
    //check loss
    if (checkcollision(currentpiece,currentrotation,0,0)){
      
      //will update
      print("lost");
      delay(1000000);
    }
  }
}

//check win
int winlines[] = new int[20];
void checkwin(){
  winlines = new int[20];
  boolean haswin = false;
  int tlines = 0;
  for (int row = 0; row<20; row++){
    boolean winline = true;
    for (int col = 0; col<10; col++){
      if (grid[col][row] == -1){
        winline = false;
      }
    }
    if (winline){
      haswin = true;
      winlines[row]=1;
      tlines++;
      
     
      
    }
  }
  
  int conseq = 0;
  int tc = 0;
  for (int i = 0; i < winlines.length; i++)
  {
    if (winlines[i]==1){
      
      tc = tc+1;
    } else {
      tc=0;
    }
    if (tc>conseq){
        conseq=tc;
    }
  }
  
  if (haswin){
    //tlines is total lines cleared
    //conseq is largest no of conseq
    flashing = true;
    
    
    
    if (lastwin == 4){
      score = score+1200;
      print("+1200");
    }else{
      score = score+scoring(tlines);
      print("+"+scoring(tlines));
    }
    
    lastwin = tlines;
    totallines = totallines+tlines;
    level = (int)Math.floor(totallines/10)+1;
    
    int len = palettelist.length;
    palette = palettelist[(level-1)%len];
    fpt = 30-level*1;
     
    scoreupdate();
  
  //scoring:
  //soft drop: 1/cell
  //hard drop: 2/cell
  //single: 100*level
  //double: 300*level
  //triple: 500*level
  //tetris: 800*level
  //back2back tetris: 1200*level
  
  }
  
}

void scoreupdate(){
  
  //stroke(100);
  fill(60);
  rect(margins[0]+sqz*12,margins[1]+sqz*14,250,50);
   rect(margins[0]+sqz*12,margins[1]+sqz*16,250,50);   
      
  //stroke(0);
  fill(255);
  text("score: "+score,margins[0]+sqz*12,margins[1]+sqz*15);
  
  
  text("level: "+level,margins[0]+sqz*12,margins[1]+sqz*17);
}

int scoring(int lines){
  switch (lines){
    case 1:
      return 100*level;
    case 2:
      return 300*level;
    case 3:
      return 500*level;
    case 4:
      return 800*level;
    default:
      return 0;
  }
}


boolean flashing = false;
void flashwhite(){
  for (int i = 0; i < 20; i++){
    if (winlines[i] == 1){
      for (int j = 0; j < 10; j++){
        grid[j][i] = -2;
      }
    }
  }
}
void flashblack(){
  for (int i = 0; i < 20; i++){
    if (winlines[i] == 1){
      for (int j = 0; j < 10; j++){
        grid[j][i] = -3;
      }
    }
  }
}

void shiftgrid(int row){
  for (int r = row-1; r>0; r--){
    for (int i = 0; i < 10; i++){
      grid[i][r+1] = grid [i][r];
    }
  }
}

//queue is 7 bag randomised pieces, and one extra piece so i can "show next"
int pqueue[] = new int[8];
//current place in queue
int cq = 7;
int bag[] = {0,1,2,3,4,5,6};
void bagrandomize(){
  if (cq == 7){
    cq = 0;
    pqueue[0] = pqueue[7];
    
    //reset bag
    bag = new int[]{0,1,2,3,4,5,6};
    
     
    //bad code but java does not have lists for some reason
    bag[pqueue[0]]=-1;
    for (int i = 1; i<7; i++){
      int temp = (int)Math.floor(Math.random()*7);
       
       
      while (bag[temp]==-1){
        temp = (int)Math.floor(Math.random()*7);
      }
      bag[temp] = -1;
      pqueue[i]=temp;
     
    }
    
    pqueue[7] = (int)Math.floor(Math.random()*7);
    
    print("\nscore: "+score);
    print("\nlvl: "+level);
    print("\ncurrent bag: \n"+pqueue[0]+" "+pqueue[1]+" "+pqueue[2]+" "+pqueue[3]+" "+pqueue[4]+" "+pqueue[5]+" "+pqueue[6]+" -> "+pqueue[7]+"\n");
       
    cq = 0;
    
  }
  currentpiece = pqueue[cq];
  cq++;
}

//copies the pgrid onto the game grid
void flatten(){
  for (int py = 0; py < 20; py++) {
    for (int px = 0; px < 10; px++) {
      if (!(pgrid[px][py]==-1)){
        grid[px][py] = currentpiece;
      }
    }
  }
  clearpgrid();
}
