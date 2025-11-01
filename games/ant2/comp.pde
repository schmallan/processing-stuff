int orientation(point a, point b, point c){
    //calculate orientation using determinant.
    // 0 means points are colinear.
    int ret = (b.x - a.x)*(c.y - a.y)-(c.x - a.x)*(b.y - a.y);
    return ret;
}
int orientation(triangle t){
    return orientation(t.p1,t.p2,t.p3);
}

boolean isEdge(point a,point b, point c, point check){
    if(pointOnLine(a,b,check)) return true;
    if(pointOnLine(c,b,check)) return true;
    if(pointOnLine(a,c,check)) return true;
    return false;
}
boolean isEdge(triangle t, point p){
    return isEdge(t.p1,t.p2,t.p3,p);
}

boolean isInside(point a,point b, point c, point check, boolean includeEdge){
    if (!includeEdge&isEdge(a,b,c,check)) return false;
    if (orientation(a,b,c)>0){
        point temp = a;
        a = c;
        c = temp;
    }

    //works regardless of orientation of triangle points!
    boolean co = orientation(a,b,check)<0;
    boolean ao = orientation(b,c,check)<0;
    boolean bo = orientation(c,a,check)<0;
    return co&&ao&&bo;
}
boolean isInside(triangle t, point p, boolean b){
    return isInside(t.p1,t.p2,t.p3,p, b);
}

boolean pointOnLine(point a, point b, point check){
    //a spell of my own creation...
    boolean colinear = orientation(a,b,check)==0;
    if (!colinear) return false;
    int lowV;
    int highV;
    int checkV;
    if (a.x-b.x==0){
        lowV = min(a.y,b.y);
        highV = max(a.y,b.y);
        checkV = check.y;
        
    } else {
        
        lowV = min(a.x,b.x);
        highV = max(a.x,b.y);
        checkV = check.y;
        
    }
    return (lowV<=checkV&&checkV<=highV);
}
boolean pointOnLine(edge e, point p){
    return pointOnLine(e.p1,e.p2,p);
}


boolean rayIntersect(point ax, point ay, point bx, point by){
    //check if everything colin
    boolean allColin = orientation(ax,ay,bx)==0&orientation(ax,ay,by)==0;
    boolean ret = false;
    if (allColin) ret = true;
    if (pointOnLine(ax,ay,bx)) return ret;
    if (pointOnLine(ax,ay,by)) return ret;
    if (pointOnLine(bx,by,ax)) return ret;
    if (pointOnLine(bx,by,ay)) return ret;
    

    boolean one1 = orientation(ax,ay,bx)>0;
    boolean one2 = !(orientation(ax,ay,by)<0);
    boolean two1 = orientation(bx,by,ax)>0;
    boolean two2 = !(orientation(bx,by,ay)<0);
    boolean res = (one1!=one2)&&(two1!=two2);
/*
    if (res){
        edge a = new edge(ax,ay);
        edge b = new edge(bx,by);
        a.col = #FF0000;
        b.col = #0000FF;
        c.add(a);
        c.add(b);
    }*/

    return res;
}
boolean rayIntersect(edge a, edge b){
    return rayIntersect(a.p1,a.p2,b.p1,b.p2);
}

boolean isOverlap(triangle t1, triangle t2){
    int ec1 = 0;
    int ec2 = 0;

    for (int i = 0; i<3; i++){
        if (isInside(t1,t2.getP(i),false)){
            return true;
        }
        if (isInside(t2,t1.getP(i),false)){
            return true;
        }
        if (isEdge(t2,t1.getP(i))) ec1++;
        if (isEdge(t1,t2.getP(i))) ec2++;
        
        
        for (int j = 0; j<3; j++){
            boolean b = rayIntersect(t1.getE(i),t2.getE(j));
            if (b){
                return true;
            }
        }
            
    }

    return false;
}