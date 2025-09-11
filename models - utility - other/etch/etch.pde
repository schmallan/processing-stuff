void setup()
{
  

  size(200,200);
  background(250);
}
  int posX = 100;
  int posY = 100;
  
  int hue = 0;
void draw()
{
  hue++;
  if (hue==100)
  {
    hue = 0;
  }
  noStroke();
  colorMode(HSB, 100, 100, 100);
  //hue
  fill(100,100,0);
  ellipse(posX,posY,5,5);
}

void mousePressed()
{
  background(0,0,100);
}

void keyPressed()
{
  print(key);
  switch(key) {
  case (char)'w':
    posY=posY-2;
    break;
  case 'd':
  posX=posX+2;
    // code block
    break;
  case 'a':
  posX=posX-2;
    // code block
    break;
  case 's':
  posY=posY+2;
    // code block
    break;
  default:
  }
}
