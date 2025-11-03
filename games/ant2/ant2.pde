import java.util.Collections;
camera cam = new camera();
chunk c = new chunk(0,0);
boolean add(chunk inp){
    HashMap<Integer,chunk> m = chunks.get(inp.posX);
    if (m==null){
        m = new HashMap<Integer,chunk>();
        chunks.put(inp.posX,m);
    }
    chunk e = m.get(inp.posY);
    if (e!=null) {
        println("duplicate chunk.");
        return false;
    }
    m.put(inp.posY,inp);
    return true;
}
HashMap<Integer,HashMap<Integer,chunk>> chunks = new HashMap();
void setup(){
    size(500,500);
    add(c);
    
    c.add(new edge(new point(-100,0),new point(100,0)));
    point n = new point(0,100);
    c.triangulate(n);
    n = new point(0,-100);
    c.triangulate(n);
    
}
chunk getChunk(int x, int y){
    HashMap<Integer,chunk> co = chunks.get(x);
    if (co==null) return null;
    chunk c = co.get(y);
    return c;
}

point chunkCenter(int x, int y){
    
    point chunkCenter = new point();
    chunkCenter.x = Math.floorDiv(x,chunk.sizeX);
    chunkCenter.y = Math.floorDiv(y,chunk.sizeY);
    return chunkCenter;
}

void drawChunks(){

    int cox = -(int)cam.camOffX;
    int coy = -(int)cam.camOffY;
    point chunkCenter = chunkCenter(cox,coy);
    
   
    //println(chunkCenter.x);
   // println(chunkCenter.y);
    
    final int loadrad = 1;
    for (int i = -loadrad; i<=loadrad; i++){
        for (int k = -loadrad; k<=loadrad; k++){
            chunk l = getChunk(chunkCenter.x+i,chunkCenter.y+k);
            if (l==null) continue;
            l.renderInfo();
            l.render();
        }
    }
    
}

void draw(){
    movement();
    background(255);

    drawChunks();
    fill(0);
    point wo = cam.toScreen(new point(0,0));
    ellipse(width/2,height/2,10,10);
    fill(#FF0000);
    ellipse(wo.x,wo.y,10,10);
    
}

triangle s;
void mousePressed(){
    point n = cam.toWorld(new point(mouseX,mouseY));
    point cs = chunkCenter(n.x,n.y);
    c = getChunk(cs.x,cs.y);
    if (c==null){
        c = new chunk(cs.x,cs.y);
        add(c);
    }
    c.points.add(n);
    c.triangulate(n);
}

HashMap<Character,Boolean> keys = new HashMap();
float speed = 2;
float zoomspeed = 1.05;
void movement(){
    if (key('w')) cam.camOffY+=speed/cam.scale;
    if (key('s')) cam.camOffY-=speed/cam.scale;
    if (key('a')) cam.camOffX+=speed/cam.scale;
    if (key('d')) cam.camOffX-=speed/cam.scale;
    if (key('i')) cam.scale=min(100,cam.scale*zoomspeed);
    if (key('o')) cam.scale=max(0.1,cam.scale/zoomspeed);
    
}
void keyPressed(){
    keys.put(key,true);
}
boolean key(char in){
    Boolean k = keys.get(in);
    if (k==null){
        keys.put(in,false);
        k=false;
    }
    return k;
}
void keyReleased(){
    keys.put(key,false);
}

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
    
    void triangulate(point p){
        ArrayList<edge> edgesInRange = new ArrayList();
        ArrayList<edge> edgesInOuterRange = new ArrayList();
      //  ArrayList<triangle> trianglesInRange = new ArrayList();
        ArrayList<triangle> trianglesInOuterRange = new ArrayList();
        
        for (int i = -1; i<=1; i++){
            for (int k = -1; k<=1; k++){
                chunk iChunk = getChunk(i+posX,k+posY);
                if (iChunk==null) continue;
                for (edge cEdge : iChunk.edges){
                    cEdge.col = #44000000;
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
                    if (isInside(nt, testp, false)) continue ol;
                }
                
            }
            
            //create triangl
            triangles.add(nt);
            add(n1);
            add(n2);
            
            
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

    void render(){
        for (triangle t : triangles){
            noStroke();
            t.render();
        }
        for (edge e:edges){
            stroke(0);
            strokeWeight(3);
            e.render();
        }
        noStroke();
        fill(0);
        for (point p:points){
            p.render(1);
        }
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
    }
}

class camera{
    float camOffX = 0;
    float camOffY = 0;
    float scale = 10;
    camera(){}
    point toWorld(point inp){
       point ret = new point(
        (int)(  (inp.x-width/2)/scale -camOffX  ),
        (int)(  (inp.y-height/2)/scale -camOffY ));
       return ret;
    }
    point toScreen(point inp){
       point ret = new point(
        (int)(  (inp.x+camOffX)*scale +width/2  ),
        (int)(  (inp.y+camOffY)*scale +height/2 ));
       return ret;
    }
    
}