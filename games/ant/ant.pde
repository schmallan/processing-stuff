import java.util.Comparator;
import java.util.Collections;
import java.util.Arrays;
import java.util.ArrayList;

ArrayList<int[][]> edges = new ArrayList();
ArrayList<int[]> points = new ArrayList();
ArrayList<int[][]> shapes = new ArrayList();

int range = 100;
void setup(){
    size(500,500);
   // println(rayIntersect(new int[]{0,0},new int[]{10,0},new int[]{5,0},new int[]{15,0}));
   // println(isInside(new int[]{-1,0},new int[]{1,0},new int[]{0,-10},new int[]{0,-1}));
}

int pCx = 0;
int pCy = 0;
void draw(){
    pCx= 0;
    pCy= 0;
    if (key('w')) pCy=5;
    if (key('s')) pCy=-5;
    if (key('d')) pCx=5;
    if (key('a')) pCx=-5;

    int ncX = camOffX+pCx;
    int ncY = camOffY+pCy;
    boolean v = false;
    for (int[][] shape : shapes){
        //println(ncX);
        if (isInside(shape[1],shape[2],shape[3],new int[]{camOffX,camOffY})){
            println("yay");
            v=true;
            break;
        }
    }
    if (camOffY+ncY>=-10) v = true;
    if (true){
        camOffX=ncX;
        camOffY=ncY;
    }
    
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
    
    for (int[][] i : edges){
        int[] p1 = worldToScreen(i[0]);
        int[] p2 = worldToScreen(i[1]);
        
        //stroke(i[2][0]);
        stroke(#FFFFFF);
        strokeWeight(1);
        line(p1[0],p1[1],p2[0],p2[1]);
    }


    fill(#000000);
    ellipse(width/2,height/2,12,12);
}

void test(int[] s){
    points.add(s);
    int ps= points.size();
    if (ps%3==0){
        shapes.add(new int[][]{new int[]{rcolor()},points.get(ps-3),points.get(ps-2),points.get(ps-1)});
        
    }
    if (ps==6){
        println(isOverlap(points.get(ps-6),points.get(ps-5),points.get(ps-4),points.get(ps-3),points.get(ps-2),points.get(ps-1)));
        
    }
    if (ps<7) return;
    shapes = new ArrayList();
    points = new ArrayList();
}
void mousePressed(){
    
    int[] s = screenToWorld(new int[]{mouseX,mouseY});
    if (s[1]<0) s[1]=0;
//    test(s);
addPoint(s);
}
void addPoint(int[] s){



    ArrayList<int[]> ptsInRange = new ArrayList();
    //points.add(s);
        for (int[] point : points){
            
            int cont = (int)(sqrt(pow(point[0]-s[0],2)+pow(point[1]-s[1],2)));
            if (cont<range) ptsInRange.add(point);
        }
    ArrayList<int[][]> edgesInRange = new ArrayList();
    ArrayList<int[][]> trianglesInRange = new ArrayList();
    for (int[][] edge : edges){
            edge[2][0] = #000000;
            int[] p1 = edge[0];
            int[] p2 = edge[1];
            
            if (ptsInRange.contains(p1)&&ptsInRange.contains(p2)){
                edgesInRange.add(edge);
            edge[2][0] = #FFFFFF;
                
            }
        }


    for (int i = 0; i<shapes.size();i++){
        int[][] shape = shapes.get(i);
           // shape[0][0] = #000000;
            int[] p1 = shape[1];
            int[] p2 = shape[2];
            int[] p3 = shape[3];
            if (isInside(shape[1],shape[2],shape[3],s)){
                shapes.remove(i);
                i--;
                continue;
            }
            if (ptsInRange.contains(p1)||ptsInRange.contains(p2)||ptsInRange.contains(p3)){
                trianglesInRange.add(shape);
           // shape[0][0] = #FFFFFF;
                
            }
        }
      //  println(edgesInRange.size());

    if (edgesInRange.size()==0 && ptsInRange.size()>=2){
        int[] p1 = ptsInRange.get(0);
        int[] p2 = ptsInRange.get(1);
        int[][] ne = (new int[][]{p1,p2,new int[]{#00FF00}});
        edges.add(ne);
       // println("newedge created");
        edgesInRange.add(ne);
    }
    int tc = 0;
    outerloop:
    for (int[][] edge : edgesInRange){
        edge[2][0]=#00FFFF;
        for (int[][] tri : trianglesInRange){
            if(isOverlap(s,edge[0],edge[1],tri[1],tri[2],tri[3])) {
               // addTriangle(#440000,s,edge[0],edge[1]);
               // tri[0][0] = #000000;
                continue outerloop;
            }
        }
        tc++;
        addTriangle(#c2deff,s,edge[0],edge[1]);
        //edges.remove(edge);
       edges.add(new int[][]{s,edge[0],new int[]{#FFFFFF}});
       edges.add(new int[][]{s,edge[1],new int[]{#FFFFFF}});
    }
    if (s[1]<50||tc>0){
    points.add(s);
    }
}

int rcolor(){
    return color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
}

int[][] addTriangle(int col, int[] pA, int[] pB, int[] pC){
    int[][] triangle = new int[][]{new int[]{col},pA,pB,pC};
    shapes.add(triangle);
    return triangle;
}

class sortByDegree implements Comparator<int[]>{
    int compare(int[] a,int[] b){
        if (a[2]>b[2]) return 1;
        if (b[2]>a[2]) return -1;
        return 0;
    }
}

void shapeSort(int[][] inp, int[] centroid){
    int centerX = centroid[0];
    int centerY = centroid[1];

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