void setup(){
  frameRate(60);
  
  //size
  size(1900,800);
}

void render(){
  
  //draw sky and grass
  fill(#55A749);
  rect(0,550,1900,300);
  
  fill(#64a2d3);
  rect(0,0,1900,550);
  
  
  //annenberg science
  //x and y of building
  int x1 = 430;
  int y1 = 400;
  House sciencebody;
  sciencebody = new House(220,180,#bd8668);
  sciencebody.drawHouse(x1,y1);
  
  //layers(?)
  fill(215);
  rect(x1,y1,230,10);
    rect(x1,y1+50,230,10);
      rect(x1,y1+100,230,10);
  
  //anennberg side
  fill(100);
  arc(x1,y1+180,200,700,PI,1.5*PI);
  fill(80);
  arc(x1,y1+180,170,670,PI,1.5*PI);
  
  Door sciencedoor;
  sciencedoor = new Door(50,80,200);
  sciencedoor.drawDoor(x1,y1+100);
  
  //longstreet library
  //x and y
  int x2 = 30;
  int y2 = 400;
  
  House libpole;
  libpole = new House(80,190,#a65b42);
  libpole.drawHouse(x2+200,y2);
  
  Roof libproof;
  libproof = new Roof(80,100,#a7ccbf,true);
  libproof.drawRoof(x2+200,y2);
  
  House libhouse;
  libhouse = new House(200,145,#a65b42);
  libhouse.drawHouse(x2,y2+45);
  
  Roof libroof;
  libroof = new Roof(200,55,#3E4D45,false);
  libroof.drawRoof(x2,y2+45);
  Roof libroof2;
  libroof2 = new Roof(140,35,#6d7671,false);
  libroof2.drawRoof(x2+30,y2+45);
  
  Door libdoor;
  libdoor = new Door(30,60,#673434);
  libdoor.drawDoor(x2+85,y2+130);
  
  
  Window lwin1;
  lwin1 = new Window(20,40,#2d372d);
  lwin1.drawWindow(x2+10,y2+60);
  Window lwin2;
  lwin2 = new Window(20,40,#2d372d);
  lwin2.drawWindow(x2+50,y2+60);
  Window lwin3;
  lwin3 = new Window(20,40,#2d372d);
  lwin3.drawWindow(x2+90,y2+60);
  Window lwin4;
  lwin4 = new Window(20,40,#2d372d);
  lwin4.drawWindow(x2+130,y2+60);
  Window lwin5;
  lwin5 = new Window(20,40,#2d372d);
  lwin5.drawWindow(x2+170,y2+60);
  
  //annenberg hall
  //x and y
  int x3 = 730; int y3 = 350;
  
  House ahall;
  ahall = new House(320,200,#956d68);
  ahall.drawHouse(x3,y3);
  
  fill(#FCF9E5);
  rect(x3,y3,320,30);
  //no intellisense///??
  Roof hallroof1;
  hallroof1 = new Roof(120,80,#FCF9E5,false);
  hallroof1.drawRoof(x3+100,y3+30);
  
  Roof hallroof2;
  hallroof2 = new Roof(80,50,#956d68,false);
  hallroof2.drawRoof(x3+120,y3+30);
  
  fill(#FCF9E5);
  
  rect(x3+108,y3+30,10,170);
    rect(x3+138,y3+30,10,170);
  rect(x3+170,y3+30,10,170);

  rect(x3+200,y3+30,10,170);
  
  fill(#956d68);
  rect(x3+100,y3+130,115,70);
  
  Door ahalldoor;
  ahalldoor = new Door(25,40,160);
  ahalldoor.drawDoor(x3+143,y3+160);

//athletic center
  int x4 = 1090; int y4 = 400;
  
  House ac1 = new House(290,170,#4BD0E0);
  ac1.drawHouse(x4,y4);
  
  House ac2 = new House(80,170,#5CBBC6);
  ac2.drawHouse(x4+290,y4);
  
  fill(255);
  rect(x4,y4,370,3);
  rect(x4,y4+30,370,3);
  rect(x4,y4+60,370,3);
  rect(x4,y4+90,370,3);
  rect(x4,y4+120,370,3);
  rect(x4,y4+150,370,3);
  
  rect(x4+60,y4,3,170);
  rect(x4+90,y4,3,170);
  rect(x4+120,y4,3,170);
  rect(x4+150,y4,3,170);
  rect(x4+180,y4,3,170);  
  rect(x4+210,y4,3,170);
  rect(x4+240,y4,3,170);
  rect(x4+270,y4,3,170);
  rect(x4+315,y4,3,170);
  rect(x4+345,y4,3,170);



  
  Door acdoor = new Door(30,40,200);
  acdoor.drawDoor(x4+20,y4+130);

  
  //chapel
  //x and y
  int x5 = 1500; int y5 = 350;
  
  House chapel;
  chapel = new House(320,170,#956d68);
  chapel.drawHouse(x5,y5+30);
  
  fill(255);
  rect(x5+120,y5-100,80,120);
  
  fill(#FCF9E5);
  Roof croof;
  croof = new Roof(320,80,255,false);
  croof.drawRoof(x5,y5+30);
  
  
  
  Roof croof2;
  croof2 = new Roof(80,140,255,false);
  croof2.drawRoof(x5+120,y5-100);
  
  fill(255);
  rect(x5+100,y5+30,115,170);
  
  fill(#FCF9E5);
  
    rect(x5+128,y5+30,10,170);
  rect(x5+180,y5+30,10,170);

  
  
  Door cdoor;
  cdoor = new Door(25,40,160);
  cdoor.drawDoor(x5+143,y5+160);
  
  //flagpole
  fill(180);
  rect(670,30,30,700);
 


}

int t = 0;

void draw(){
  
  render();
  
  int k = 15;
  
  t = (t+1)%30;
  
  fill(#0b2343);
  stroke(#0b2343);
  
  
  //draw flag according to sine wave
  for (int i = 0; i<=400; i++){
    
    rect(700+i,50-sin((float)i/40+t/5)*k,1,250);
  }
  
  //draw the flag emblem
  int flagx = 490; int flagy = -150; 
 
 fill(#b88d2e);
  beginShape();
  vertex(flagx+313,flagy+252);vertex(flagx+314,flagy+267);vertex(flagx+333,flagy+276);vertex(flagx+335,flagy+379);vertex(flagx+315,flagy+385);vertex(flagx+313,flagy+401);vertex(flagx+420,flagy+400);vertex(flagx+420,flagy+387);vertex(flagx+390,flagy+380);vertex(flagx+391,flagy+344);vertex(flagx+462,flagy+342);vertex(flagx+493,flagy+324);vertex(flagx+501,flagy+291);vertex(flagx+489,flagy+269);vertex(flagx+460,flagy+254);vertex(flagx+313,flagy+252);
  endShape();
  
  fill(#0b2343);
  beginShape();
  vertex(flagx+391,flagy+273);vertex(flagx+391,flagy+320);vertex(flagx+439,flagy+317);vertex(flagx+448,flagy+297);vertex(flagx+433,flagy+276);
  endShape();
  
  
}
