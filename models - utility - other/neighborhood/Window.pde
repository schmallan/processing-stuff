class Window{
  int x;
  int y;
  int w;
  int h;
  int dcolor;
  // constants - class properties
  final static int RT = 0;
  final static int LFT = 1;
  // constructor
  Window(int w, int h, int c){
    this.w = w;
    this.h = h;
    this.dcolor = c;
    }
  // draw the door
  void drawWindow(int x, int y) {
    fill(dcolor);
    rect(x, y, w, h);
  }
}
