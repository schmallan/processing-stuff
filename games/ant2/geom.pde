
class point{
    public int x;
    public int y;
    int col = #000000;
    void render(float ps){
        fill(col);
        point adjP = cam.toScreen(this);
        float s = ps*cam.scale;
        ellipse(adjP.x,adjP.y,s,s);
    }

    boolean equals(point p){
        return x==p.x&&y==p.y;
    }

    point(){};
    point(int x, int y){
        this.x = x;
        this.y = y;
    }
}
class edge{
    int col = #9e8a78;
    public point p1;
    public point p2;
    edge(){};
    void align(){
        
        if (p1.x>p2.x){
            //do nothing
        } else if (p1.x<p2.x){
            swap();
        } else {
            if (p1.y>p2.y){
                //do nothing
            } else {
                swap();
            }
        }
    }

    void swap(){
        point temp = p1;
        p1 = p2;
        p2 = temp;
    }

    edge(point p1, point p2){
        this.p1 = p1;
        this.p2 = p2;
    }

    boolean equals(edge e){
        return(p1.equals(e.p1)&&p2.equals(e.p2));
    }
    void render(){
        stroke(col);
        point p1 = cam.toScreen(this.p1);
        point p2 = cam.toScreen(this.p2);
        line(p1.x,p1.y,p2.x,p2.y);
    }
}
class triangle{
    int col = #9e8a78;
    point c;
    point p1;
    point p2;
    point p3;
    edge e1;
    edge e2;
    edge e3;
    edge getE(int n){
        
        if (n==0) return e1;
        if (n==1) return e2;
        if (n==2) return e3;
        return null;
    }
    point getP(int n){
        if (n==0) return p1;
        if (n==1) return p2;
        if (n==2) return p3;
        return null;
    }
    

    boolean equals(triangle t){
        return p1.equals(t.p1)&&p2.equals(t.p2)&&p3.equals(t.p3);
    }

    void swap(){
        //swaps the orientation of triangle - preserves the first point
        point temp = p2;
        p2 = p3;
        p3 = temp;
    }

    triangle(){}
    triangle(point p1, point p2,point p3){
        this.p1 = p1;
        this.p2 = p2;
        this.p3 = p3;
        e1 = new edge(p2,p3);
        e2 = new edge(p1,p3);
        e3 = new edge(p3,p2);
        int cx = (p1.x+p2.x+p3.x)/3;
        int cy = (p1.y+p2.y+p3.y)/3;
        c = new point(cx,cy);
    }
    void render(){
        noStroke();
        fill(col);
        point p1 = cam.toScreen(this.p1);
        point p2 = cam.toScreen(this.p2);
        point p3 = cam.toScreen(this.p3);
        beginShape();
        vertex(p1.x,p1.y);
        vertex(p2.x,p2.y);
        vertex(p3.x,p3.y);
        endShape();
    }
}