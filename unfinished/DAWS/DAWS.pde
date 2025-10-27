int xspeed = 9;
int yspeed = 13;
int x = 0;
int y = 0;

void setup(){
  background(255);
  size(900,900);
  colorMode(HSB,900,100,100);
}

void draw(){
  move();
  xspeed = bounce(xspeed,x);
  yspeed = bounce(yspeed,y);
  render();
}

void move(){
  x+=xspeed;
  y+=yspeed;
}

int bounce(int cspeed, int c){
  if (c<=0 || c>= width) {
    return cspeed *= -1;
  }
  return cspeed;
}

void render(){
  background(0,0,100);
  fill(x,100,100);
  ellipse(x,y,50,50);
}
