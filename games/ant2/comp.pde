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
    if(orientation(a,b,check)==0) return true;
    if(orientation(c,b,check)==0) return true;
    if(orientation(a,c,check)==0) return true;
    return false;
}
boolean isEdge(triangle t, point p){
    return isEdge(t.p1,t.p2,t.p3,p);
}

boolean isInside(point a,point b, point c, point check, boolean includeEdge){
    if (!includeEdge&isEdge(a,b,c,check)) return false;

    //works regardless of orientation of triangle points!
    boolean co = orientation(a,b,check)<0;
    boolean ao = orientation(b,c,check)<0;
    boolean bo = orientation(c,a,check)<0;
    return co==ao&&co==bo;
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


boolean rayIntersect(point ax, point ay, point bx, point by, boolean countOverlap){
    if (!countOverlap){
    if (pointOnLine(ax,ay,bx)) return false;
    if (pointOnLine(ax,ay,by)) return false;
    if (pointOnLine(bx,by,ax)) return false;
    if (pointOnLine(bx,by,ay)) return false;
    }

    boolean one1 = orientation(ax,ay,bx)>0;
    boolean one2 = !(orientation(ax,ay,by)<0);
    boolean two1 = orientation(bx,by,ax)>0;
    boolean two2 = !(orientation(bx,by,ay)<0);
    return (one1!=one2)&&(two1!=two2);
}
boolean rayIntersect(edge a, edge b, boolean c){
    return rayIntersect(a.p1,a.p2,b.p1,b.p2,c);
}

boolean isOverlap(triangle t1, triangle t2){
    if (isInside(t1,t2.p1,false)) return true;
    if (isInside(t1,t2.p2,false)) return true;
    if (isInside(t1,t2.p2,false)) return true;
    
    if (isInside(t2,t1.p1,false)) return true;
    if (isInside(t2,t1.p2,false)) return true;
    if (isInside(t2,t1.p2,false)) return true;

    edge t1e1 = new edge(t1.p2,t1.p3);
    edge t1e2 = new edge(t1.p1,t1.p3);
    edge t1e3 = new edge(t1.p1,t1.p2);
    edge t2e1 = new edge(t2.p2,t2.p3);
    edge t2e2 = new edge(t2.p1,t2.p3);
    edge t2e3 = new edge(t2.p1,t2.p2);
    
    if (rayIntersect(t1e1,t2e1,false)) return true;
    if (rayIntersect(t1e1,t2e2,false)) return true;
    if (rayIntersect(t1e1,t2e3,false)) return true;
    if (rayIntersect(t1e2,t2e1,false)) return true;
    if (rayIntersect(t1e2,t2e2,false)) return true;
    if (rayIntersect(t1e2,t2e3,false)) return true;
    if (rayIntersect(t1e3,t2e1,false)) return true;
    if (rayIntersect(t1e3,t2e2,false)) return true;
    if (rayIntersect(t1e3,t2e3,false)) return true;
      
    return false;
}