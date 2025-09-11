public void setup(){
  strokeWeight(2);
  frameRate(60);
  
  size(400,500);
  background(background);
  
  //initialise to -1
  for (int i = 0; i < maxobjects; i++) {
    for (int j = 0; j < 5; j++) {
        obj[i][j] = -1;
    }
  }
  
  //create objects
  
  obj[0] = new double[] {4,500,210,-10,0};
  obj[1] = new double[] {0,200,200,0,0};
  //obj[2] = new double[] {2,650,300,-10,0};
  //obj[3] = new double[] {3,550,210,0,0};
  //obj[4] = new double[] {4,800,300,-200,0};
  //obj[5] = new double[] {5,350,300,0,0};
  
  
}

int r = 0;
//create object at mousepress
void mousePressed(){
  
  int e = elist();
  if (e!=-1) obj[e] = new double[] {r,mouseX,100,0,0};
  
  r = new java.util.Random().nextInt(3);
  pobj = new double[] {r,mouseX,100,0,0};;
  //print(e+" ");
  
}

  //notes: sometimes when balls collide they come out swapped, in the wrong places for some reason?

  //bg size doesnt work?
  int background = 100;
  int[] ssize = {400,500};
  //physics variables
  double gravity = 0.3;
  double restitution = 0.3;
  double friction = 0.03;
  double slidingfriction = 5;
  
  //temp elasticity coefficient
  double tec =  0.09;
  
  //max amt of objects
  final int maxobjects = 500;

  //object array: piece index, { piece type, piece x, piece y, piece velo x, piece velo y }
  double obj[][] = new double [maxobjects][5];
  
  double pobj[] = new double[] {0,-1,-1,-1,-1};
  
//every frame, tick physics and render
void draw(){
  ptick();
  render();
  
  
  
  pobj = new double[] {pobj[0],mouseX,100,0,0};
  //obj[1] = new double[] {0,mouseX,mouseY,0,0};
  //obj[2] = new double[] {0,mouseX+45,mouseY-18,0,0};
  
  //obj[3] = new double[] {0,mouseX-80,mouseY-45,0,0};
  //obj[4] = new double[] {0,mouseX+80,mouseY-45,0,0};
}

void merge(int ci, int di){
  double[] c = obj[ci];
  double[] d = obj[di];
  
  int cpt = (int)c[0];
  int dpt = (int)d[0];
  
  
  //print(cpt);
  
  //print(dpt);
  
  //print("\n");
  
  if (cpt!=dpt) return;
  
  double nx = (c[1]+d[1])/2;
  double ny = (c[2]+d[2])/2;
  double nmx = (c[3]+d[3])/2;
  double nmy = (c[4]+d[4])/2;
  
  dlist(di);
  obj[ci] = new double[] {cpt+1,nx,ny,nmx,nmy};
  
}

//physics handler
void ptick(){
  
  //handles gravity, friction, velocity
  for (int i = 0;i<obj.length;i++) {
    double[] c = obj[i];
    if (c[0]!=-1){
      
      //acceleration from gravity
      c[4] += gravity;
      
      //move according to velocity
      c[1] += c[3];
      c[2] += c[4];
      
      //reduce x velocity for friction
      if (c[3]>0){
        c[3]-=friction;
      }else{
        c[3]+=friction;
      }
      
      if (Math.abs(c[3])<slidingfriction) c[3] = 0;
      
    };
  }
  
  
  //wall collision
  for (int i = 0;i<obj.length;i++) {
    double[] c = obj[i];
    int r = rradius((int)c[0]);
    if (c[0]!=-1){
      //if hitting boundary walls, flip velocity and * by rest.
      
      //floor
      if (c[2]+r>=ssize[1]){
        c[2] = ssize[1]-r;
        c[4] *= (-1*restitution);
      }
      //ceiling
      if (c[2]-r<=0){
        c[2] = 0+r;
        c[4] *= (-1*restitution);
      }
      //right wall
      if (c[1]+r>=ssize[0]){
        c[1] = ssize[0]-r;
        c[3] *= (-1*restitution);
      }
      //left wall
      if (c[1]-r<=0){
        c[1] = 0+r;
        c[3] *= (-1*restitution);
      }
    };
  }
  
  //two object collision
  for (int i = 0;i<obj.length;i++) {
    double[] c = obj[i];
    if (c[0]!=-1){
      for (int j = 0;j<obj.length;j++) {
        double[] d = obj[j];
        if (d[0]!=-1){
          if (i==j) break;
          
          //runs only once for every pair of existing objects (honestly no clue how i got this to work)
          
          //c and d are existing object arrays
          
          //check touching
          int cr = rradius((int)c[0]);
          int dr = rradius((int)d[0]);
          
          //if they are intersecting, call collision() on the two objects
          if (distance(i,j)<=cr+dr){
            collision(i,j);
            merge(i,j);
          }
          
        };
      }
    };
  }
}

//collision handler
void collision(int ci, int di){
  
  double m = 02;
  //handles collision between objects C and D
  
  double[] c = obj[ci];
  double cx = c[1];
  double cy = c[2];
  
  
  int cm = rradius((int)c[0]);
  //cm*=cm;
  
  double[] d = obj[di];
  double dx = d[1];
  double dy = d[2];
  
  
  int dm = rradius((int)d[0]);
  
  //dm*=dm;
  
  //the amount of intersect is the two radius minus the distance. divided by two so each object moves half intersection length
  double intersect = (rradius((int)c[0])+rradius((int)d[0])-distance(ci,di))/2;
  
  //ARCTAN SQUARED is needed to account for both signs
  //the angle, in radians, from c to d
  float cd = atan2((float)(cx-dx),(float)(cy-dy));
  //print(cx-dx +" "+(cy-dy) + " " + cd+" \n ");
  
  //the angle in radians from d to c (basically c>d rotated 180)
  float dc = cd+PI;

  //converts a vector of (Direction: DC) and (Magnitude: intersection) to its equivalent X and Y components
  double fdy = cos(dc)*intersect;
  double fdx = sin(dc)*intersect;
  
  //converts a vector of (Direction: CD) and (Magnitude: intersection) to its equivalent X and Y components
  double fcy = cos(cd)*intersect;
  double fcx = sin(cd)*intersect;
  
  //move the c object
  c[1] += fcx;
  c[2] += fcy;
  
  //move the d object
  d[1] += fdx;
  d[2] += fdy;
  
  //change the c object's acceleration to the same direction its moving
  c[3] += fcx/tec/cm;
  c[4] += fcy/tec/cm;
  
  //change the d object's acceleration to the same direction its moving
  d[3] += fdx/tec/dm;
  d[4] += fdy/tec/dm;
  
  //change the c object's acceleration to the same direction its moving
  //c[3] = fcx*tec/cm*m; //rradius((int)c[0])*m;
  //c[4] = fcy*tec/cm*m; ///rradius((int)c[0])*m;
  
  //change the d object's acceleration to the same direction its moving
  //d[3] = fdx*tec/dm*m;///rradius((int)d[0])*m;
  //d[4] = fdy*tec/dm*m;///rradius((int)d[0])*m;
  
  //print(cd+" "+dc+" / "+(float)fcx+" "+(float)fcy+"/"+(float)fdx+" "+(float)fdy+"\n");
  //c[3] = 0;
  //c[4] = 0;
  //d[3] = 0;
  //d[4] = 0;
  
  
  stroke(0);
  strokeWeight(2);
  
}

double distance(int ci, int di){
  double[] c = obj[ci];
  double[] d = obj[di];
 
  double deltax = Math.abs(c[1]-d[1]);
  double deltay = Math.abs(c[2]-d[2]);
  
  //this is just the pythagorean theorum
  double ret = Math.sqrt(deltax*deltax+deltay*deltay);
  return ret;
}

//render function
void render(){
  background(background);
  
  double[] p = pobj;
  
  fill(rcolor((int)p[0]));
  ellipse(Math.round(p[1]),Math.round(p[2]),rradius((int)p[0])*2,rradius((int)p[0])*2);
  print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");    
  print("obj[][] ---------------------------------------------------------\n\n");   
  
  for (int i = 0;i<obj.length;i++) {
    double[] c = obj[i];
    if (c[0]!=-1){
      
      print("[" + i + "] piecetype: "+(int)c[0]+", x: "+(int)c[1]+", y: "+(int)c[2]+", xv: "+(float)Math.round(c[3]*100)/100+", yv: "+(float)Math.round(c[4]*100)/100+"\n");
      
      fill(rcolor((int)c[0]));
      
      //for each existing object, draw an circle with the correct radius
      ellipse(Math.round(c[1]),Math.round(c[2]),rradius((int)c[0])*2,rradius((int)c[0])*2);
      
      stroke(180);
      fill(255);
      strokeWeight(5);
      line((float)c[1],(float)c[2],(float)(c[1]+c[3]*5),(float)c[2]);
      line((float)c[1],(float)c[2],(float)c[1],(float)(c[2]+c[4]*5));
      
      stroke(255);
      line((float)c[1],(float)c[2],(float)(c[1]+c[3]*5),(float)(c[2]+c[4]*5));
      
      stroke(0);
      strokeWeight(2);
    };
  }
}

//get the first empty index of list
int elist(){
  for (int i = 0; i < maxobjects; i++) {
    if (obj[i][0] == -1) return i;
  }
  return -1;
}

//reset index of list to -1
void dlist(int index){
  for (int j = 0; j < 5; j++) {
    obj[index][j] = -1;
  }
}

//returns the corresponding radius for piece type (just a wrapped switch case)
int rradius(int piecetype){
  switch (piecetype){
    case 0:
      return 10;
    case 1:
      return 20;
    case 2:
      return 30;
    case 3:
      return 40;
    case 4:
      return 50;
    case 5:
      return 60;
    case 6:
      return 70;
    case 7:
      return 80;
    case 8:
      return 90;
    case 9:
      return 100;
    case 10:
      return 110;
    case 11:
      return 120;
    default:
      return -1;
  }
}

//returns the corresponding color for piece type (also just a wrapped switch case)
int rcolor(int piecetype){
  switch (piecetype){
    case 0:
      return #CB4444;
    case 1:
      return #CB7644;
    case 2:
      return #CBC144;
    case 3:
      return #44CB4E;
    case 4:
      return #4480CB;
    case 5:
      return #B944CB;
    case 6:
      return 255;
    case 7:
      return 200;
    case 8:
      return 180;
    case 9:
      return 160;
    case 10:
      return 110;
    case 11:
      return 70;
    default:
      return -1;
  }
}
