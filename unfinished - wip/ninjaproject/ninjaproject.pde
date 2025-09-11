public double gravity = -0.2;

boolean m = false;
void mousePressed() {m=true;}
void mouseReleased() {m=false;}

Fruit[] objs = new Fruit[50];

int tally = 0;
void createfruit(double txc, double tyc, double txv, double tyv){
  objs[tally] = new Fruit(txc,tyc,txv,tyv);
  
  tally = (tally+1)%50;
}

int fps = 60;
import java.util.Random;

void setup(){
  frameRate(fps);
  size(1800,900);
}

Random rand = new Random();

void update() {
  for (int i = 0; i<objs.length; i++){
    if (objs[i]!=null){
    objs[i].ptick();
    objs[i].render();}
  }
}

int c = 0;
void draw(){
  c = (c+1)%20;
  
  background(0);
  update();
  
  if (m) ellipse(mouseX,mouseY,10,10);
  int r = rand.nextInt(2);
  double fruitx = (r==0) ? 0 : 900;
  double fruitxv = (r==0) ? 5+rand.nextDouble()*5 : -5-rand.nextDouble()*5;
  
  if (c==12) createfruit(fruitx,400-rand.nextDouble()*100,fruitxv,-5-rand.nextDouble()*5);
}
