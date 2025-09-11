class node{
  int value;
  public int xpos;
  public int ypos;
  
  public int depth;
  
  node upchild;
  node rightchild;
  
 node(int v, int x, int y, int d){
   value = v;
    xpos  =x;
    ypos = y;
    depth = d;
 }
 
 void render(){
   
   
  int t = xpos+xoff;
  
  if (t>width || t<0) return;
  colorMode(HSB,100,100,100);
  fill((int)(log(value*100)),80,100);
  fill(value%2*50,50,100);
  if ((value-1)%3==0){
    fill(25,80,100);
  }if ((value)%3==0){
    fill(15,80,100);
  }
  
  ellipse(t,ypos+yoff,ms,ms);
  fill(0);
  int log0 = (int)(log(value)+0.5)+1;
  log0 = Math.max(2,log0);
  float ts = (3*ms/(log0));
  textSize(ts);
  
  text(value,t-ts*(log0)/2+ms,ypos+yoff+ms/3);
  
  if (upchild!=null){
    line(t,ypos+yoff-ms/2,upchild.xpos+xoff,upchild.ypos+yoff+ms/2);
    triangle(t,ypos+yoff-ms/2,t-5,ypos+yoff-ms/2-3,t+5,ypos+yoff-ms/2-3);
  }
  
  if (rightchild!=null){
    line(t+ms/2,ypos+yoff,rightchild.xpos+xoff-ms/2,rightchild.ypos+yoff);
    triangle(t+ms/2,ypos+yoff,t+ms/2+3,ypos+yoff+5,t+ms/2+3,ypos+yoff-5);
  }
  
 }
 
 void spawnoff(){
   if (depth>md) return;
   
   
   upchild = new node(value*2,0,0,depth+1);
   add(upchild,upchild.depth);
   
   
   int l = value-1;
   if (l%3==0 && l!=0 ){
     if (value!=4 && value/3%2!=0){
     
     rightchild = new node(l/3,0,ypos+yoff,depth);
     
   add(rightchild,rightchild.depth);
   
     }
   }
   
 }
 
}
