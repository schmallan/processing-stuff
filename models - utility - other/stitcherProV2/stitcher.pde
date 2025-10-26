void stitch(){
            int lastPwr = 0;
            int firstPwr = 0;
            int lastSub = 0;
            xTally=30;
            boolean pwr = false;
            boolean sub = false;
            char[] chArr = msg.toCharArray();
            for (int i = 0; i<chArr.length; i++){
                char c = chArr[i];
                if (c=='{'){
                    //i++;
                    pwr = true;
                    firstPwr = xTally;
                    continue;
                } else if (c=='}'){
                    pwr = false;
                    if (sub){
                        xTally = max(lastSub,lastPwr);
                        ArrayList divLine = new ArrayList();
                        divLine.add(firstPwr-10);
                        divLine.add(110);

                        divLine.add(xTally-10);
                        divLine.add(110);
                        
                        lines.add(divLine);
                    }
                    sub = false;
                    continue;
                }
                String cprime = charNames.get(""+c);
                if (c==' '){
                    xTally+=50;
                }
                if (c=='/'){
                    lastPwr = xTally;
                    lastSub = firstPwr;
                    pwr = false;
                    sub = true;
                    i++;
                    continue;
                }
                if (cprime!=null){
                    if (sub){
                        lastSub += randLoad(cprime,lastSub,100,0.5);
                        continue;
                    }
                    if (pwr) xTally+=randLoad(cprime,xTally,20,0.5);
                    if (!pwr) xTally+=randLoad(cprime,xTally,0,1);
                    
                }


                
                xTally+=10+(int)(Math.random()*5);
            }
}