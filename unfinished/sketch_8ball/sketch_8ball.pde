PFont f;
void setup(){
  
  size(900,900);
  f = createFont("Arial",40,true);
  
  background(255);
  render();
}

void render(){
  
  fill(30);
  ellipse(450,450,800,800);
  fill(60);
  ellipse(450,450,450,450);
  fill(0);
  ellipse(450,450,440,440);
  fill(#2235C4);
  triangle(300, 550, 450, 300, 600, 550);
}


void draw(){
  
}

void mousePressed(){
  fill(0);
  textFont(f);
  render();
  fill(255);
  textAlign(CENTER);
  text(fortune(),450,475);
}

String fortune(){
  int r = (int)random(8);
  
  switch (r){
  case 0:
    return "Yes";
  case 1:
    return "No";
  case 2:
    return "Nuh uh";
  case 3:
    return "On god";
  case 4:
    return "idk";
  case 5:
    return "ha";
  case 6:
    return "sure buddy";
  case 7:
    return "Yup";
  default:
    return "eof";
  }
}
