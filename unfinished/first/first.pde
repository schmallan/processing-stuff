void setup(){
  background(#FFFFFF);
  size(500,500);
  strokeWeight(0);
  
  smooth();
}


int l = 0;
void draw(){
  
  
  for (int i = 0; i<50; i++) 
  {
    
    fill(255,i*5,l);
    rect(0,i*10,500,10);
  }  
  
  l++;
  
  if (l>255)
  {
    l=0;
  }
  rect(mouseX-50,mouseY-50,100,100);
  //exit();
  
  
}

//inline comment

//fourth arg is alpha channel
