class entity extends object{
  float vx = 0;
  float vy = 0;
  float ax = 0;
  float ay = -2;
  boolean grounded = false;
  boolean jumping = false;
  
  entity(int x, int y, int lx, int ly){
    super(x,y,lx,ly);
   }
  
  void upd(){
    vx+=ax;
    vy+=ay;
    
    if (posy<200){
      grounded = true;
      jumping = false;
      vy = Math.max(vy,0);
    } else {
      
      grounded = false;
      
    }
    
    
    posx+=vx;
    posy+=vy;
    
    if (key(' ') & grounded){
      vy = 30;
      jumping = true;
    }
    
    if (jumping & !key(' ')){
      jumping = false;
      vy = Math.min(0,vy);
    }
    
    vx = 0;
    
    if (key('a')){
      vx = -10;
    } else if (key('d')){
      vx = 10;
    }
    
  }
  
  
}
