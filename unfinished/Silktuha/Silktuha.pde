entity shaw;
ArrayList<object> grounds = new ArrayList<>();
void setup(){
  frameRate(60);
  size(800,800);
  grounds.add(new object(width/3,250,width,100));
  shaw = new entity(width/2,500,50,100);
}

void draw(){
  background(255);
  
  for (object o :grounds){
    o.render();
    
  }
  
  shaw.render();
  shaw.upd();
}
