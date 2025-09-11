int md = 32;
int ms = 30;
int xoff = 0;
int yoff = 0;
ArrayList<node>[] nlist = new ArrayList[md];
void add(node n, int d) {
  if (d<md) {
    ArrayList layer = nlist[d];
    layer.add(n);
  }
}

void setup() {
  for (int i = 0; i<md; i++) {
    nlist[i] = new ArrayList<node>();
  }
  fullScreen();

    background(0, 0, 100);
  add(new node(1, 50, height-50, 0), 0);
}

void correct() {
}

int cl = 0;
void draw() {
  
  glorp();  
}

 void glorp(){
  if (keyPressed) {

    if (key == '=') {
      ms++;
    }
    if (key == '-' && ms>1) {
      ms--;
    }
    if (key == 'a') {
      xoff+=5;
    }
    if (key == 'd') {
      xoff-=5;
    }if (key == 'w') {
      yoff+=5;
    }
    if (key == 's') {
      yoff-=5;
    }

    background(0, 0, 100);
    print(":");
    

    inc();
    
   skib();
    
    if (key==' ') {
      if (cl<md) {

        rend();
        cl++;
      }
    }
  }
}

void rend(){
  ArrayList<node> l = nlist[cl];
        int k = 0;
        while (k<l.size()) {
          node mcnode = l.get(k);
          if (cl<md-1) {
            mcnode.spawnoff();
          }
          k++;
          node rn = mcnode.rightchild;
          if (rn!=null) {
            l.remove(l.size()-1);
            l.add(k, rn);
            rn.spawnoff();
            k++;
          }
        }
}

void inc() {

  int i = cl;
  if (cl>=md) i = md-1;
  
    ArrayList<node> dl = nlist[i];
    for (int ks = 0; ks<dl.size(); ks++) {
      node mcnode = dl.get(ks);
    print("!");
      mcnode.xpos = 50+(ks)*(int)(ms*1.5);

      mcnode.ypos = 0;
    }
  
  
}

void skib(){
  
   for (int i = md-1; i>0; i--) {
    ArrayList<node> dl = nlist[i];
    for (int ks = dl.size()-1; ks>=0; ks--) {
      node mcnode = dl.get(ks);
      node u = mcnode.upchild;
      if (u!=null){
        mcnode.xpos = u.xpos;  
      }
      mcnode.ypos = (int)(height-mcnode.depth*ms*1.5);
      mcnode.render();
    }
  }
  
}
