import java.util.Collections;
camera cam = new camera();
chunk c = new chunk(0,0);
void setup(){
    size(500,500);
    c.edges.add(new edge(new point(0,0),new point(15,0)));
}
void draw(){
    movement();
    background(255);
    c.render();
}

triangle s;
void mousePressed(){
    point n = cam.toWorld(new point(mouseX,mouseY));
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
class chunk{
    
    void triangulate(point p){
        int inl = edges.size();
        int tnl = triangles.size();
        ol:
        for (int i = 0; i<inl; i++){
            edge e = edges.get(i);
            triangle nt = new triangle(e.p1,e.p2,p);

            edge n1 = new edge(e.p1,p);
            edge n2 = new edge(e.p2,p);

            for (int j = 0; j<inl; j++){
                edge c = edges.get(j);
                if (rayIntersect(n1,c)) continue ol;
                if (rayIntersect(n2,c)) continue ol;
                
            }
            for (int j = 0; j<tnl; j++){
                triangle t = triangles.get(j);
                for (int k = 0; k<3; k++){
                    point testp = t.getP(k);
                    if (isInside(nt, testp, false)) continue ol;
                }
                
            }
            
            //create triangl
            triangles.add(nt);
            edges.add(n1);
            edges.add(n2);
            
            
        }
    }

    void renderInfo(){
        stroke(0);
        fill(color(255,0,0,10));
        
        point adjP = cam.toScreen(new point(posX*sizeX,posY*sizeY));
        
        rect(adjP.x,adjP.y,sizeX*cam.scale,sizeY*cam.scale);
    }
    static final int sizeX = 50;
    static final int sizeY = 50;
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