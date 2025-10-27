import java.util.Comparator;
import java.util.Collections;
import java.util.Arrays;
import java.util.ArrayList;

ArrayList<int[][]> edges = new ArrayList();
ArrayList<int[]> points = new ArrayList();
ArrayList<int[][]> shapes = new ArrayList();


void setup(){
    size(500,500);
    int[] pa = new int[]{0,100};
    int[] pb = new int[]{100,50};
    int[] pc = new int[]{-100,90};
    points.add(pa); points.add(pb); points.add(pc);
    shapes.add(new int[][]{new int[]{#0000FF},pa,pb,pc});
    edges.add(new int[][]{pa,pb});
    edges.add(new int[][]{pb,pc});
    edges.add(new int[][]{pc,pa});
}
void draw(){
    if (key('w')) camOffY++;
    if (key('s')) camOffY--;
    if (key('d')) camOffX++;
    if (key('a')) camOffX--;
    
    background(#c2deff);
    fill(#735841);
    noStroke();
    int[] lm = worldToScreen(new int[]{0,0});
    rect(0,lm[1],width,height-lm[1]);
    for (int[] i : points){
        int[] iprime = worldToScreen(i);
        fill(255);
        ellipse(iprime[0],iprime[1],2,2);
    }
    for (int[][] i : shapes){
        //print("hi");
        int col = i[0][0];
        fill(col);
        //print(hex(col)+" ");
        shapeRender(i);
   //println();
    }
}
void mousePressed(){
    
    int[] s = screenToWorld(new int[]{mouseX,mouseY});
    if (s[1]<0) s[1]=0;
   // addPoint(s);
    points.add(s);
    println(isInside(points.get(0),points.get(1),points.get(2),s));
    
}
void addPoint(int[] s){
    
    ArrayList<int[]> pts = new ArrayList();
    points.add(s);
        for (int[] point : points){
            if (point == s){
                continue;
            }
            int cont = (int)(sqrt(pow(point[0]-s[0],2)+pow(point[1]-s[1],2)));
            if (cont<50) pts.add(point);
        }
        if (pts.size()>=2){
        int[][] toadd = new int[pts.size()+1][];
      //  toadd[0] = new int[]{#c2deff};
        for(int i = 0; i<pts.size(); i++){
            toadd[i+1] = pts.get(i);
        }
        //println("add");
        shapeSort(toadd);
        for (int i = 1; i<toadd.length; i++){
            int[][] toaddTRI = new int[4][];
            toaddTRI[0] = new int[]{ color( (int)(255*Math.random()),(int)(255*Math.random()),(int)(255*Math.random()))  };
            int[] p1 = toadd[i];
            int[] p2;
            if (i+1>=toadd.length){
                p2 = toadd[1];
            } else {
                p2 = toadd[i+1];
            }
            toaddTRI[1] = p1;
            toaddTRI[2] = p2;
            toaddTRI[3] = s;
            shapes.add(toaddTRI);
        }

       // shapes.add(toadd);
        }

}

class sortByDegree implements Comparator<int[]>{
    int compare(int[] a,int[] b){
        if (a[2]>b[2]) return 1;
        if (b[2]>a[2]) return -1;
        return 0;
    }
}

void shapeSort(int[][] inp){

  int centerX = 0;
  int centerY = 0;
  for (int i = 1; i<inp.length; i++){
    int[] point = inp[i];
    centerX+=point[0];
    centerY+=point[1];
  }
  centerX/=(inp.length-1);
  centerY/=(inp.length-1);

  for (int i = 1; i<inp.length; i++){
    int[] oldPoint = inp[i];
    int[] newPoint = new int[2+1];
    newPoint[0] = oldPoint[0];
    newPoint[1] = oldPoint[1];
    newPoint[2] = (int)(atan2(oldPoint[0]-centerX,oldPoint[1]-centerY)*10000);
    inp[i] = newPoint;
  }
  ArrayList<int[]> sorted = new ArrayList<int[]>(Arrays.asList(Arrays.copyOfRange(inp,1,inp.length)));
  Collections.sort(sorted,new sortByDegree());
  for (int i = 1; i<inp.length; i++){
    inp[i] = sorted.get(i-1);
  }

  fill(#FF0000);
  int[] wp = worldToScreen(new int[]{centerX,centerY});
  ellipse(wp[0],wp[1],5,5);
}

void shapeRender(int[][] inp){
  int[] info = inp[0];
  fill(info[0]);
  //stroke(info[0]);
  //strokeWeight(1);
  beginShape();
  for (int i = 1; i<inp.length; i++){
    int[] point = inp[i];
    int[] wp = worldToScreen(point);
    vertex(wp[0],wp[1]);

  }
  endShape();
  
}

int camOffX;
int camOffY;
int[] worldToScreen(int[] inp){
    int[] ret = new int[2];
    ret[1] = height/2+camOffY+inp[1];
    ret[0] = width/2-camOffX+inp[0];
    return ret;
}
int[] screenToWorld(int[] inp){
    int[] ret = new int[2];
    ret[1] = inp[1]-camOffY-height/2;
    ret[0] = inp[0]+camOffX-width/2;
    return ret;
}

HashMap<Character,Boolean> keys = new HashMap();
void keyPressed(){
    keys.put(key,true);
}
void keyReleased(){
    keys.put(key,false);
}
boolean key(char in){
    Boolean k = keys.get(in);
    if (k==null){
        keys.put(in,false);
        k=false;
    }
    return k;
}