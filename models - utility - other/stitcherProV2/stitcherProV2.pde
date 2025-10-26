void setup(){
    init();
    size(600,300);
    for (String c : toStringArray(msg)){
        println(c);
    }
}
void cls(){
    lines = new ArrayList();
}
ArrayList<ArrayList<Integer>> lines = new ArrayList();
String charToSave = "A";
String msg = "";
boolean p = false;
    ArrayList<Integer> currentLine = null;
    boolean dot = false;
int ydOff = 50;
int bi = 0;
void draw(){
    bi = (bi+1)%50;
    String bar = (bi<25) ? "|" : "";
    background(255);
    if (mousePressed){
        if (p==false){
            dot = false;
            currentLine = new ArrayList<Integer>();
            lines.add(currentLine);
            currentLine.add(pmouseX);
            currentLine.add(pmouseY-ydOff);
        } else {
            int px = currentLine.get(currentLine.size()-2);
            int py = currentLine.get(currentLine.size()-1);
            int cx = mouseX;
            int cy = mouseY-ydOff;
            int pd = abs(px-cx)+abs(py-cy);
            if (pd>1 || !dot){
            currentLine.add(cx);
            currentLine.add(cy);
            dot = true;
            }
        }
    }

    for (ArrayList<Integer> x : lines){
        for (int i = 3; i<x.size(); i+=2){
            int px = x.get(i-3);
            int py = x.get(i-2)+ydOff;
            int cx = x.get(i-1);
            int cy = x.get(i)+ydOff;
            strokeWeight(3);
            line(px,py,cx,cy);
            //ellipse(px,py,5,5);
        }
    }
    textSize(20);
    fill(0);
    text(msg+bar,10,20);

    textSize(150);
    fill(0,0,0,50);
    text(charToSave,30,160+ydOff);

    p = (mousePressed);
}