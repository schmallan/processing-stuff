import java.util.Collections;
camera cam = new camera();
chunk c = new chunk(0,0);
void setup(){
    size(500,500);
    c.points.add(new point(10,10));
}
void draw(){
    movement();
    background(255);
    c.renderInfo();
    c.render();
}

void mousePressed(){
    c.add(cam.toWorld(new point(mouseX,mouseY)));
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

int snapRange = 15;
class chunk{
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

    //
    void triangulate(point p){
        ArrayList<point> pointsInRange = new ArrayList();
        for (point c : points){

        }
    }

    void render(){
        for (triangle t : triangles){
            t.render();
        }
        for (edge e:edges){
            e.render();
        }

        noStroke();
        fill(0);
        for (point p:points){
            p.render(1);
        }
    }

    boolean add(point p){
        for (point cont : points){
            if (p.x==cont.x && p.y==cont.y) return false;
        }
        points.add(p);
        return true;
    }
    boolean add(edge e){
        e.align();
        for (edge cont : edges){
            if (e.equals(cont)){
                println("alert: duplicate edge");
                return false;
            }
        }
        edges.add(e);
        return true;
    }
    boolean add(triangle t){
        t.align();
        for (triangle cont : triangles){
            if (t.equals(cont)){
                println("alert: duplicate triangle");
                return false;
            }
        }
        triangles.add(t);
        return true;
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