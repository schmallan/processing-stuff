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
    add(new chunk(-1,0));
    add(new chunk(0,-1));
    add(new chunk(-1,-1));
    
    
    c.add(new edge(new point(-100,0),new point(100,0)));
    point n = new point(0,100);
    c.triangulate(n,c.triangles);
    //n = new point(0,-100);
    //c.triangulate(n,c.triangles);
    
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
    
    final int loadrad = max(1,(int)cam.scale);
    for (int i = -loadrad; i<=loadrad; i++){
        for (int k = -loadrad; k<=loadrad; k++){
            chunk l = getChunk(chunkCenter.x+i,chunkCenter.y+k);
            if (l==null) continue;
            //l.renderInfo();
            
            point mp = cam.toWorld(new point(mouseX,mouseY));
            if (l.pending.size()>0) l.pending = new ArrayList();
            if (i==0&k==0&mousePressed){
            l.pending = new ArrayList();
            mp.y = max(0,mp.y);
            l.triangulate(mp,l.pending);
            }
            l.render();
        }
    }
    
}

void draw(){
    pOffx = 0;
    pOffy = 0;
    movement();
    background(#a3cfe3);
    fill(#735943);
    int wy = cam.toScreen(new point(0,0)).y;
    noStroke();
    rect(0,wy,width,height-wy);

    drawChunks();
    fill(0);    noStroke();
    ellipse(width/2,height/2,10*cam.scale,10*cam.scale);
    
    point sro = cam.toWorld(new point(mouseX,mouseY));
    sro.x-=150;
    sro.y-=150;
    sro = cam.toScreen(sro);
    fill(color(255,0,0,0));
    strokeWeight(1);
    stroke(#88000000);
    if (mousePressed) rect(sro.x,sro.y,snapRange*2*cam.scale,snapRange*2*cam.scale);
    
    cam.camOffX +=pOffx;
    cam.camOffY+= pOffy;
    
}

triangle s;
void mouseReleased(){
    point n = cam.toWorld(new point(mouseX,mouseY));
    n.y = max(0,n.y);
    point cs = chunkCenter(n.x,n.y);
    c = getChunk(cs.x,cs.y);
    if (c==null){
        c = new chunk(cs.x,cs.y);
        add(c);
    }
    c.points.add(n);
    c.triangulate(n,c.triangles);
}

HashMap<Character,Boolean> keys = new HashMap();
float speed = 2;
float zoomspeed = 1.05;

float pOffx = 0;
float pOffy = 0;
void movement(){
    if (key('w')) pOffy+=speed;
    if (key('s')) pOffy-=speed;
    if (key('a')) pOffx+=speed;
    if (key('d')) pOffx-=speed;
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

class camera{
    float camOffX = 0;
    float camOffY = 0;
    float scale = 1;
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