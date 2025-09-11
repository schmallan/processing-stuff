class Roof{
  float x;
  float y;
  float w;
  float h;
  int dcolor;
  boolean dome;
  // constants - class properties
  final static int RT = 0;
  final static int LFT = 1;
  
  // constructor
  Roof(int w, int h, int c, boolean dome){
    this.w = w;
    this.h = h;
    this.dcolor = c;
    this.dome = dome;
    }
  // draw the door
  void drawRoof(int x, int y) {
    fill(dcolor);
    if (dome){
      
      arc(x+w/2, y, w, h, PI, 2*PI);
      return;
    }
    triangle(x,y,x+w,y,x+w/2,y-h);
    
  }
}
