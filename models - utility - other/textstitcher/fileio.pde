import java.io.File;
//import java.io.IOException;
//import java.io.FileWriter;
void tsave(String filepath, int[][] toSave){
    PrintWriter p = createWriter(filepath);
    p.println(plx);
    p.println(ply);
    for (int i = 0; i<toSave.length; i++){
        int[] row = toSave[i];
        if (row.length==0) continue;
        int prev = row[0];
        int conseq = 1;
        for (int j = 1; j<row.length; j++){
            int pixel = row[j];
            if (prev==pixel){
              conseq++;
            } else {
              p.print(conseq+":");
        if (prev == color(0,0,0,0)){
          p.print("n ");
        } else if (prev == color(0,0,0)) {
          p.print("y ");
        } else{
        p.print(hex(prev)+" ");
        }
              prev=pixel;
              conseq = 1;
            }
        }
        p.print(conseq+":");
        if (prev == color(0,0,0,0)){
          p.print("n ");
        } else if (prev == color(0,0,0)) {
          p.print("y ");
        } else{
        p.print(hex(prev)+" ");
        }
        p.println();
      }

    p.flush();
    p.close();
}
String loaded[];
void load(String filepath, int locX, int locY){
    loaded = loadStrings(filepath);
    int OffX = locX;//Integer.parseInt(loaded[0]);
    int OffY = Integer.parseInt(loaded[1]);
    lastWidth = 0;
    for (int j = 2; j<loaded.length; j++){
      String s = loaded[j];
      String[] chords = s.split(" ");
      int rowc = 0;
      lastWidth++;
      for (String c : chords){
        int num = Integer.parseInt(c.split(":")[0]);
        String tc = c.split(":")[1];
        int col;
        if (tc.equals("n")) {col=color(0,0,0,0);}
        else if (tc.equals("y")) {col=color(0,0,0);}
        else {col = unhex(tc);}

        for (int i = rowc; i<rowc+num; i++){
          if (j+OffX<frameSizeX) THEimagebuffer[j+OffX][i+OffY] = col;
          if (i+OffY>=600) continue;
          myimage.setRGB(j+OffX,i+OffY,col);
       //   println(j+OffX);
        }
        rowc+=num;
      }
    }
    
}