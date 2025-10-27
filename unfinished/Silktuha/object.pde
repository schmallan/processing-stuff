class object{
  
  float posx;
  float posy;
  float lenx;
  float leny;
  
   
  object(int x, int y, int lx, int ly){
    posx = x;
    posy = y;
    lenx = lx;
    leny = ly;
    
   }
  
  
  void render(){
    rectMode(CENTER);
    rect(posx,height-posy,lenx,leny);
  }
}
