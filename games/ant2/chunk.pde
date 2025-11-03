
int snapRange = 150;
int abortRange = 20;
class chunk{

    void add(edge e){
        e.align();
        for (edge cont : edges){
            if (e.equals(cont)) return;
        }
        edges.add(e);
    }
    
    boolean checkIntersect(point p){
        
        for (int i = -1; i<=1; i++){
            for (int k = -1; k<=1; k++){
                chunk iChunk = getChunk(i+posX,k+posY);
                if (iChunk==null) continue;
                for (triangle cTriangle : iChunk.triangles){
                    int d1 = max(abs(cTriangle.p1.x-p.x),abs(cTriangle.p1.x-p.x));
                    int d2 = max(abs(cTriangle.p2.x-p.x),abs(cTriangle.p2.x-p.x));
                    int d3 = max(abs(cTriangle.p3.x-p.x),abs(cTriangle.p3.x-p.x));
                    
                    int td = max(d1,d2,d3);
                    if (td<snapRange){
                        if (isInside(cTriangle,p,true)) return true;
                    }
                }
            }
        }

        return false;
    }
    void triangulate(point p,ArrayList<triangle> dest){
        ArrayList<edge> edgesInRange = new ArrayList();
        ArrayList<edge> edgesInOuterRange = new ArrayList();
      //  ArrayList<triangle> trianglesInRange = new ArrayList();
        ArrayList<triangle> trianglesInOuterRange = new ArrayList();
        
        for (int i = -1; i<=1; i++){
            for (int k = -1; k<=1; k++){
                chunk iChunk = getChunk(i+posX,k+posY);
                if (iChunk==null) continue;
            for (triangle cTriangle : iChunk.triangles){
                int d1 = max(abs(cTriangle.p1.x-p.x),abs(cTriangle.p1.x-p.x));
                int d2 = max(abs(cTriangle.p2.x-p.x),abs(cTriangle.p2.x-p.x));
                int d3 = max(abs(cTriangle.p3.x-p.x),abs(cTriangle.p3.x-p.x));
                
                int td = max(d1,d2,d3);
                if (td<snapRange){
                // trianglesInRange.add(cTriangle);
                }if (td<snapRange*2){
                    trianglesInOuterRange.add(cTriangle);
                }
            }
                for (edge cEdge : iChunk.edges){
                    //cEdge.col = #44000000;
                int d1 = max(abs(cEdge.p1.x-p.x),abs(cEdge.p1.y-p.y));
                int d2 = max(abs(cEdge.p2.x-p.x),abs(cEdge.p2.y-p.y));
                int td = max(d1,d2);
                if (td<abortRange){
                    return;
                }
                if (td<snapRange*2){
                    edgesInOuterRange.add(cEdge);
                //  cEdge.col = #00FF00;
                }
                if (td<snapRange){
                    edgesInRange.add(cEdge);//cEdge.col = #0000FF;
                }
            }
            
        }}

        int inl = edgesInRange.size();
       // int tnl = trianglesInRange.size();


        ol:
        for (int i = 0; i<inl; i++){
            edge e = edgesInRange.get(i);
            triangle nt = new triangle(e.p1,e.p2,p);

            edge n1 = new edge(e.p1,p);
            edge n2 = new edge(e.p2,p);

            for (int j = 0; j<edgesInOuterRange.size(); j++){
                edge c = edgesInOuterRange.get(j);
                if (rayIntersect(n1,c)) continue ol;
                if (rayIntersect(n2,c)) continue ol;
                
            }
            for (int j = 0; j<trianglesInOuterRange.size(); j++){
                triangle t = trianglesInOuterRange.get(j);
                for (int k = 0; k<3; k++){
                    point testp = t.getP(k);
                    if (isInside(t,p,true)) return;
                    if (isInside(nt, testp, false)) continue ol;
                }
                
            }
            
            //create triangl
            dest.add(nt);
            trianglesInOuterRange.add(nt);
            if (dest==triangles){
            add(n1);
            add(n2);
            }
            
            
        }
    }

    void renderInfo(){
        stroke(0);
        fill(color(255,0,0,10));
        
        point adjP = cam.toScreen(new point(posX*sizeX,posY*sizeY));
        
        rect(adjP.x,adjP.y,sizeX*cam.scale,sizeY*cam.scale);
    }
    static final int sizeX = 500;
    static final int sizeY = 500;
    int posX;
    int posY;
    ArrayList<point> points;
    ArrayList<edge> edges;
    ArrayList<triangle> triangles;
    ArrayList<triangle> pending;

    void render(){
        for (triangle t : triangles){
            noStroke();
            t.render();
        }
        for (triangle t : pending){
            t.col = #88FFFFFF;
            noStroke();
            t.render();
        }
        
        for (edge e:edges){
            strokeWeight(1);
            e.render();
        }
        /*
        noStroke();
        fill(0);
        for (point p:points){
            p.render(1);
        }
            */
    }

    chunk(int pX,int pY){
        this();
        posX = pX;
        posY = pY;
    }
    chunk(){
        points = new ArrayList();
        edges = new ArrayList();
        triangles = new ArrayList();
        pending = new ArrayList();
    }
}
