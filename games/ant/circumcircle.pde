boolean isInside(int[] p1, int[] p2, int[] p3, int[] check){
    
    return ccw(p1,p2,check)<0&ccw(p2,p3,check)<0&ccw(p3,p1,check)<0;
}

boolean isOverlap(int[] p1, int[] p2, int[] p3,int[] q1, int[] q2, int[] q3){
    int[][] tri1 = new int[][]{p1,p2,p3};
    int[][] tri2 = new int[][]{q1,q2,q3};
    for (int i = 0; i<3; i++){

        if (isInside(p1,p2,p3,tri2[i])) return true;
        if (isInside(q1,q2,q3,tri1[i])) return true;
        println("not inside");

        for (int j = 0; j<3; j++){
            int[][] edge1 = new int[][]{ tri1[i], tri1[(i+1)%3]};
            int[][] edge2 = new int[][]{ tri2[j], tri2[(j+1)%3]};
            if (rayIntersect(edge1[0],edge1[1],edge2[0],edge2[1])) return true;
        }
        println("not intersect");
        
    }

    return false;
}
boolean isEdge(int[] p1, int[] p2, int[] p3, int[] check){
    
    return ccw(p1,p2,check)==0||ccw(p2,p3,check)==0||ccw(p3,p1,check)==0;
}

boolean sidetest(int[] p1, int[] p2, int[] check){
    int[] linep = new int[]{p2[0]-p1[0],p2[1]-p1[1]};
    int[] pointp = new int[]{check[0]-p1[0],check[1]-p1[1]};
    int crossprod = linep[0]*pointp[1]-pointp[0]*linep[1];
    return crossprod>0;
}

boolean inCircumcircle(int[] p1, int[] p2, int[] p3, int[] check){
    int ax_ = p1[0]-check[0];
    int ay_ = p1[1]-check[1];
    int bx_ = p2[0]-check[0];
    int by_ = p2[1]-check[1];
    int cx_ = p3[0]-check[0];
    int cy_ = p3[1]-check[1];
    float det = (ax_*ax_ + ay_*ay_) * (bx_*cy_-cx_*by_) -
        (bx_*bx_ + by_*by_) * (ax_*cy_-cx_*ay_) +
        (cx_*cx_ + cy_*cy_) * (ax_*by_-bx_*ay_);
    if (ccw(p1,p2,p3)>0) return det>0;
    return det<0;
}

boolean pointOnLine(){
    return false;
}

boolean rayIntersect(int[] x1, int[] y1, int[] x2, int[] y2){

    boolean one1 = ccw(x1,y1,x2)>0;
    boolean one2 = !(ccw(x1,y1,y2)<0);
    boolean two1 = ccw(x2,y2,x1)>0;
    boolean two2 = !(ccw(x2,y2,y1)<0);
    edges = new ArrayList();
    boolean intersect = (one1!=one2)&&(two1!=two2);
    if (intersect){
        println("yo");
        edges.add(new int[][]{x2,y2, new int[]{#FF0000}});
        edges.add(new int[][]{x1,y1, new int[]{#00FF00}});
           
    }
    if (
        pointEquals(x1,x2)&&pointEquals(y1,y2) ||
         pointEquals(x1,y2)&&pointEquals(y1,x2)
    ) return false;
    return intersect;
}

boolean pointEquals(int[] p1, int[] p2){
    if (p1[0]==p2[0] && p1[1]==p2[1]) return true;
    if (p1[0]==p2[1] && p1[0]==p2[1]) return true;
    return false;
}
int ccw(int[] p1, int[] p2, int[] p3){
    int ax = p1[0];
    int ay = p1[1];
    int bx = p2[0];
    int by = p2[1];
    int cx = p3[0];
    int cy = p3[1];
    
    int ccw = (bx - ax)*(cy - ay)-(cx - ax)*(by - ay);
    //COLINEAR CASE...?
    return ccw;
}