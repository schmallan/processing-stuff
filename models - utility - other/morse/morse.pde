
String p = "";
String f = "";

//input sensitivity (in ms)

int unit = 100;

//  > new input | new letter | new word
//              A            B
int A = unit*2;
int B = unit*4;

//  >   dit   |   dah
//            C
int C = unit*2;

void setup(){
  size(1000,150);
  frameRate(50);
  
  background(255);
}

void mousePressed(){
  f = "";
  fconseq = 100;
  c = 0;
  p = "";
  
  background(255);
  fp = true;
}

int c = 0;
int tconseq = 0;
int fconseq = 100;
int offset = 0;

boolean fp = true;
void draw(){
  
  
  
  
  int xc = c%1000;
  
  offset = 12+12*(c-xc)/1000;
  
  noStroke();
  fill(255);
  rect(0,60,1000,90);
  c++;
  fill(0);
  
  textSize(60);
  
  String cursor = ((int)(c/30)%2==0) ? "|" : "";
  if (fconseq<B/20) cursor = "|";
  text(f+p+cursor,20,110);
  
  textSize(18);
  text("unit length: "+unit+"ms (use +/- to change)   -   click anywhere to clear",20,142);
  
  
  
  boolean k = keyPressed;
  if (k & key=='=') unit+=1;
  if (k & key=='-') unit-=1;
  A = unit*2;
  B = unit*4;
  C = unit*2;
  
  if (k){
    tconseq++;
    
    ellipse(xc,12-12*((xc-c)/1000),3,5);

    fconseq = 0;
  }else{
    fconseq++;
    
    if (0<tconseq&tconseq<C/20) {p+= "."; fill(#FF0000);}
    if (C/20<=tconseq) {p+= "-"; fill(#0000FF);}
    
    if (tconseq != 0) {
      
      ellipse(xc,offset,3,5);
      
    
    }
    tconseq = 0;
  }
  
  
    if (fconseq==A/20) {
      //interp letter
      f+= letter(p);
      p = "";
      
        fill(230);
       ellipse(xc,12-12*((xc-c)/1000),3,10);
      
    }
  if (fconseq==B/20) {
       p = "";
       f+=" ";
       
       fill(200);
       ellipse(xc,12-12*((xc-c)/1000),3,10);
       
     };
  print(f+p+"|\n\n");
  
}


String letter(String i){
  
  switch (i) {
        case ".-":
            return "A";
        case "-...":
            return "B";
        case "-.-.":
            return "C";
        case "-..":
            return "D";
        case ".":
            return "E";
        case "..-.":
            return "F";
        case "--.":
            return "G";
        case "....":
            return "H";
        case "..":
            return "I";
        case ".---":
            return "J";
        case "-.-":
            return "K";
        case ".-..":
            return "L";
        case "--":
            return "M";
        case "-.":
            return "N";
        case "---":
            return "O";
        case ".--.":
            return "P";
        case "--.-":
            return "Q";
        case ".-.":
            return "R";
        case "...":
            return "S";
        case "-":
            return "T";
        case "..-":
            return "U";
        case "...-":
            return "V";
        case ".--":
            return "W";
        case "-..-":
            return "X";
        case "-.--":
            return "Y";
        case "--..":
            return "Z";
        case ".----":
            return "1";
        case "..---":
            return "2";
        case "...--":
            return "3";
        case "....-":
            return "4";
        case ".....":
            return "5";
        case "----.":
            return "6";
        case "---..":
            return "7";
        case "--...":
            return "8";
        case "-....":
            return "9";
        case "-----":
            return "0";
        case ".-.-.-":
            return ".";
        case "--..--":
            return ",";
        case "..--..":
            return "?";
        case "-..-.":
            return "/";
        case ".--.-.":
            return "@";
        case "---...":
            return ":";
        case "-....-":
            return "-";
        case "-...-":
            return "=";
        case "-.-.--":
            return "!";
        case "-.--.-":
            fp = !fp;
            return (fp) ? ")" : "(";
        case ".-...":
            return "&";
        default:
            return "*";
  }
}
