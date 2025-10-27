void setup(){
  int l = 0;
  background(#FFFFFF);
  size(500,500);
  noStroke();
  rectMode(CORNER);
  smooth();
  
  for (int i = 0; i<25; i++) //purple to red gradient
  {
    int c = i-0;
    noStroke();
    fill(155+i*4,0,200-i*8);
    rect(0,i*5,500,5);
  }
  
  for (int i = 25; i<60; i++)  //red to yellow gradient
  {
    int inte = 7;
    int c = i-30;
    noStroke();
    fill(255,c*inte,l);
    rect(0,i*5,500,5);
  }  
  
  fill(#FCF4D1);
  ellipse(250,300,80,80);
  
}


int t = 0;
void draw(){
  t++;//draw every 3rd frame
  if (t==3){
    t=0;
  }
  if (t==1){
    return;
  }
  
  
  int nume = (int)Math.round(Math.abs(250-mouseX)/9); //takes mouseX, divide 10 and round
  
  
  rectMode(CORNER);
  int b = (int)Math.round(Math.random()*10); //random num 1-10
  fill(10,10,60+b);
  rect(0,298,500,202);
  
  rectMode(CENTER);
  for (int i = 60; i<90; i++) 
  {
    int r = (int)Math.round(Math.random()*10);
    int c = 90-i;
    
    noStroke();
    fill(252,246,219,c*8);
    rect(250,i*5,c*2+r*(2+nume),5);
  }  
  
  //exit();
  
  
}
