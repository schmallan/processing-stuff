class Door{
  int x;
  int y;
  int w;
  int h;
  int dcolor;
    // for knob
  int knobLoc = 1;
  // constants - class properties
  final static int RT = 0;
  final static int LFT = 1;
  // constructor
  Door(int w, int h, int c){
    this.w = w;
    this.h = h;
    this.dcolor = c;
    }
  // draw the door
  void drawDoor(int x, int y) {
    fill(dcolor);
    rect(x, y, w, h);
    int knobsize = w/10;
    if (knobLoc == 0){
      //right side
      ellipse(x+w-knobsize, y+h/2, knobsize, knobsize);
    } else {
      //left side
      ellipse(x+knobsize, y+h/2, knobsize, knobsize);
    }
  }
}
