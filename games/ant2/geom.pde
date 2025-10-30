
class point{
    public int x;
    public int y;
    void render(float ps){
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
        point p1 = cam.toScreen(this.p1);
        point p2 = cam.toScreen(this.p2);
        line(p1.x,p1.y,p2.x,p2.y);
    }
}
class triangle{
    point p1;
    point p2;
    point p3;
    edge e1;
    edge e2;
    edge e3;

    void align(){
        //aligns triangle using the edge's align function,
        //also align to POSITIVE orientation (ccw)
        edge temp1 = new edge(p1,p2);
        temp1.align();
        edge temp2 = new edge(temp1.p1,p3);
        temp2.align();
        point anchor = temp2.p1;
        p1 = anchor;
        p2 = temp2.p2;
        p3 = temp1.p2;

        int or = orientation(this);
        if (or<0) swap();
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
    }
    void render(){
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