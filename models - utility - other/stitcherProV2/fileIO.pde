void directorySave(String folderpath,String subfolderpath,String filename){
    
    File folder = new File(dataPath(subfolderpath));
    boolean exists = folder.exists();
    if (!exists){
        new File(subfolderpath).mkdir();
    }
    File[] children = folder.listFiles();
    int c = (children==null) ? 0 : children.length;
    fSave(folderpath+subfolderpath+filename+c);
}
int randLoad(String subfolderpath, int x, int y, float scaleFactor){
    
    File folder = new File(dataPath(subfolderpath));
    File[] children = folder.listFiles();
    if (children==null) return 0;
    int totalNumChildren = children.length;
    File chosen = children[(int)(Math.random()*totalNumChildren)];
    return fLoad(chosen.getPath(),x,y, scaleFactor);
}



void fSave(String filepath){
    PrintWriter p = createWriter(filepath);
    for(int j = 0; j<lines.size(); j++){
        ArrayList arrl = lines.get(j);
        for(int i = 0; i<arrl.size(); i+=2){
            p.print(arrl.get(i)+":"+arrl.get(i+1)+";");
        }
        p.println();
    }

    p.flush();
    p.close();
}
int xTally = 0;
int fLoad(String filepath, int xOff, int yOff, float scaleFactor){
    int leftMost = 99999;
    int rightMost = 0;
    String[] loadedStrs = loadStrings(filepath);
    for (String loadedStr : loadedStrs){
        String[] tuples = loadedStr.split(";");
        ArrayList<Integer> loadedLine = new ArrayList();
        println(filepath);
        for (String tuple : tuples){
            int x = Integer.parseInt(tuple.split(":")[0]);
            leftMost = min(leftMost,x);rightMost = max(rightMost,x);
        }
        lines.add(loadedLine);
    }
    for (String loadedStr : loadStrings(filepath)){
        String[] tuples = loadedStr.split(";");
        ArrayList<Integer> loadedLine = new ArrayList();
        for (String tuple : tuples){
            String[] stuple = tuple.split(":");
            int x = (int)((Integer.parseInt(stuple[0])-leftMost)*scaleFactor+xOff);
            int y = (int)(Integer.parseInt(stuple[1])*scaleFactor+yOff);
            loadedLine.add(x);
            loadedLine.add(y);
        }
        lines.add(loadedLine);
    }
    return (int)((rightMost-leftMost));
}
