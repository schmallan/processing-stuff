import java.awt.Color;
import java.util.Map;
String msg = "";

String charToTest = "A";

HashMap<Character,Boolean> keys = new HashMap<Character,Boolean>();
int THEimagebuffer[][];
int ccolor = #000000;
int rv = 0;
int gv = 0;
int bv = 0;
String rstr = "qwertyuio";
String gstr = "asdfghjkl";
String bstr = "zxcvbnm,.";
void setup(){
    
    windowResize(800,400);
    THEimagebuffer = new int[frameSizeX][frameSizeY];
    //load(filepath,0,0);
    //stitch();
}
int frameSizeX = 600;
int frameSizeY = 600;
int frameOffX = 0;
int frameOffY = 0;
boolean key(char c){
    Boolean b = keys.get(c);
    if (b==null){
        keys.put(c,false);
        return false;
    }
    
    return b;
}

void cls(){
    THEimagebuffer = new int[frameSizeX][frameSizeY];
}
void keyReleased(){
    keys.put(key,false);
}

int lastWidth = 0;
void loadRand(String s, int ox, int oy){
    int numf = Integer.parseInt(loadStrings("data/"+s+it)[0]);
    int rn = (int)(Math.random()*numf);
    load("data/"+s+"/"+rn,ox,oy);
}
final String it = "/info.txt";
String fp = "data/"+charToTest;

void saveChar(){
    boolean exists = new File(dataPath(charToTest)).exists();
        int numf = 0;
        if (!exists){
            new File(fp).mkdir();
            PrintWriter inf = createWriter(fp+it);
            inf.println(0);
            inf.flush();
            inf.close();
            println("s");
        } 

        numf = Integer.parseInt(loadStrings(fp+it)[0]);
        PrintWriter inf = createWriter(fp+it);
        inf.println(numf+1);
        inf.flush();
        inf.close();
        tsave(fp+"/"+numf,clip(THEimagebuffer));
        cls();
}

void drawline(int x1, int y1, int x2, int y2, int col, int r){
    float d = (int) sqrt(pow(x1-x2,2)+pow(y1-y2,2))/5+1;
    float sx = (x1-x2)/d;
    float sy = (y1-y2)/d;
    for (int i = 0; i<d; i++){
        colorpoint(x2+(int)(sx*i),y2+(int)(sy*i),r,col);
    }
}

void colorpoint(int x, int y, int r, int col){

    for (int i = -r; i<=r; i++){
            for (int j = -r; j<=r; j++){
            if (sqrt(i*i+j*j)>=r) continue;
            int mx = x+i;
            if (mx<0 || mx>= frameSizeX) continue;
            int my = y+j;
            if (my<0 || my>= frameSizeY) continue;
            
            THEimagebuffer[mx][my] = col;
            }
        }
}

void draw(){
    background(0);
    ccolor = color(rv*32-1,gv*32-1,bv*32-1);
    if (mousePressed){
        int mx = Math.min(frameSizeX,Math.max(0,mouseX*2-frameOffX));
        int my = Math.min(frameSizeY,Math.max(0,mouseY*2-frameOffY));
        int pmx = Math.min(frameSizeX,Math.max(0,pmouseX*2-frameOffX));
        int pmy = Math.min(frameSizeY,Math.max(0,pmouseY*2-frameOffY));
        if (mouseButton == LEFT){
        drawline(pmx,pmy,mx,my,ccolor,5);
        } else {

        drawline(pmx,pmy,mx,my,color(0,0,0,0),38);
        }
        
    }
    loadPixels();
    for (int i = 0; i<THEimagebuffer.length; i++){
        int[] row = THEimagebuffer[i];
        for (int j = 0; j<row.length; j++){
            int pixel = row[j];
            int c = #999999;
            if ((i/20+j/20)%2==0) c = #CCCCCC;
            if (alpha(pixel)>5) c = pixel;
            pixels[(j+frameOffY)*width*2+i+frameOffX] = c;
        }
    }
    updatePixels();
    fill(ccolor);
   // ellipse(50,50,50,50);
    fill(0,0,0,100);
    textSize(150);
    text(charToTest,135,220);
    fill(#FFFFFF);
    textSize(30);
    text(msg+"<",50,350);
}

int plx = 0;
int ply = 0;
int[][] clip(int[][] THEimagebuffer){
    int hx = 0; int lx = 99999;
    int hy = 0; int ly = 99999;
    for (int i = 0; i<THEimagebuffer.length; i++){
        int[] row = THEimagebuffer[i];
        for (int j = 0; j<row.length; j++){
            int pixel = row[j];
            if (pixel!=color(0,0,0,0)){
                hx = max(i,hx);
                lx = min(i,lx);
                plx = lx;
                hy = max(j,hy);
                ly = min(j,ly);
                ply = ly;
            }
        }
    }
    if (hx<lx){ hx = 1; lx = 0;}
    if (hy<ly){ hy = 1; ly = 0;}
    int[][] ret = new int[hx-lx][hy-ly];
    for (int i = lx; i<(hx); i++){
        int[] row = THEimagebuffer[i];
        for (int j = ly; j<(hy); j++){
            int pixel = row[j];
           // if (pixel==null) pixel = color(0,0,0,0);
            ret[i-lx][j-ly] = pixel;
        }
    }
    
    
    return ret;
}

BufferedImage myimage;
void cImage(float scaleFactor){
    int[][] clipped = THEimagebuffer;
    myimage = new BufferedImage(/*(int)(clipped.length/scaleFactor+1)*/4000,600/*(int)(clipped[0].length/scaleFactor+1)*/,BufferedImage.TYPE_INT_ARGB);
  //  Graphics g = myimage.getGraphics();
    //g.setColor(new Color(255,200,30,0));
    //g.fillRect(0,0,50,50);
  //  g.setColor(new Color(255,0,0,255));
    //g.drawString("errm what the sigma", 20,20);

    for (int i = 0; i<clipped.length; i++){
        int[] row = clipped[i];
        for (int j = 0; j<row.length; j++){
            int pixel = row[j];
            myimage.setRGB((int)(i/scaleFactor),(int)(j/scaleFactor),pixel);

        }
    }

}
