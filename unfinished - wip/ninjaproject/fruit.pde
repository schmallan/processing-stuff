class Fruit {
  double xc, yc; //x, y current position
  double xv, yv; //x,y velocity
  int rx = 0;
  int ry = 0;
  int fruitcolor;
  boolean iscut = false;
  double cd = rand.nextDouble();
  int tt = 0;
  
  double sa = (2*PI)*cd;
  double sb = (sa+PI)%(2*PI);

  Fruit(double txc, double tyc, double txv, double tyv) {
    xc = txc;
    yc = tyc;
    xv = txv;
    yv = tyv;

    switch(rand.nextInt(5)) {
    case 0:
      rx = 100;
      ry = 80;
      fruitcolor = #bf3100;
      break;
    case 1:
      rx = 150;
      ry = 120;
      fruitcolor = #d76a03;
      break;
    case 2:
      rx = 100;
      ry = 100;
      fruitcolor = #ec9f05;
      break;
    case 3:
      rx = 123;
      ry = 148;
      fruitcolor = #f5bb00;
      break;
    case 4:
      rx = 60;
      ry = 80;
      fruitcolor = #8ea604;
      break;

    default:
      fruitcolor = -1;
    }
  }

  void cut() {
    iscut = true;
  }

  void ptick() {
    
    if (yc>950) return;
      yv -= gravity;

      xc += xv;
      yc += yv;
    
    if (iscut){
      tt++;
    }
  }
  
  //public boolean intersect(){
  //  return ((mouseX)&());
  //}

  public void render() {
    fill(fruitcolor);
    if (yc>950) return;
    
    
    if (!iscut) {
      ellipse((float)xc, (float)yc, rx, ry);
    } else {
      arc((float)xc+tt, (float)yc, rx, ry,(float)sa,(float)sa+PI);
      arc((float)xc-tt, (float)yc, rx, ry,(float)sb,(float)sb+PI);
    }
  }
  
  
}
