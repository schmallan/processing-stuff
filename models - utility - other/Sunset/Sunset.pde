void setup(){
  background(#FFFFFF);
  size(500,500);
  strokeWeight(0);
  rectMode(CORNER);
  smooth();
  
  for (int i = 0; i<25; i++) 
  {
    int c = i-0;
    stroke(155+i*4,0,200-i*8);
    fill(155+i*4,0,200-i*8);
    rect(0,i*5,500,5);
  }
  
  for (int i = 25; i<60; i++) 
  {
    int inte = 7;
    int c = i-30;
    stroke(255,c*inte,l);
    fill(255,c*inte,l);
    rect(0,i*5,500,5);
  }  
  
  fill(#FCF4D1);
  ellipse(250,300,80,80);
  
}


int l = 0;
void draw(){
  rectMode(CORNER);
  int b = (int)Math.round(Math.random()*10);
  fill(10,10,60+b);
  rect(0,300,500,200);
  
  rectMode(CENTER);
  for (int i = 60; i<90; i++) 
  {
    int r = (int)Math.round(Math.random()*10);
    int c = 90-i;
    
    stroke(252,246,219,c*8);
    fill(252,246,219,c*8);
    rect(250,i*5,c*2+r*5,5);
  }  
  
  //exit();
  
  
}
