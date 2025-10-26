void stitch(){
        int xv = 0;

        for (int i = 0; i<msg.length(); i++){
            char ct = msg.charAt(i);
            String c = ""+ct;
            switch (ct){
                case ' ':
                
                xv+=50;
                continue;
                case 'x':
                c="xm";
                break;
                case '*':
                c="+^";
                break;
                case 'f':
                c="fm";
                break;
                case 'd':
                c="dx";
                break;
                case '/':
                c="+d";
                break; case '|':
                c="l";
                break;
                case '<':
                c="vl";
                break;
                
                case '>':
                c="vr";
                break;
                case '^':
                c="x";
                i++;
                c+=msg.charAt(i);
                break;
                
            }
            loadRand(""+c,xv,0);
            //println(xv);
            xv+=(int)(Math.random()*15+15)+lastWidth;
            

        }
    }

