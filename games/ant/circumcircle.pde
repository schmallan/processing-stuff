boolean isInside(int[] p1, int[] p2, int[] p3, int[] check){
    return !ccw(p1,p2,check)&!ccw(p2,p3,check)&!ccw(p3,p1,check);
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
    if (ccw(p1,p2,p3)) return det>0;
    return det<0;
}

boolean ccw(int[] p1, int[] p2, int[] p3){
    int ax = p1[0];
    int ay = p1[1];
    int bx = p2[0];
    int by = p2[1];
    int cx = p3[0];
    int cy = p3[1];
    
    return (bx - ax)*(cy - ay)-(cx - ax)*(by - ay) > 0;
}