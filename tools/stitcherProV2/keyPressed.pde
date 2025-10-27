int sizeX = 4000;
int sizeY = 400;
void keyPressed(){
    switch (keyCode){
        case DELETE:
            msg = "";
            break;
        case SHIFT:
            cls();
            break;
        case TAB:
            directorySave("data/",charNames.get(charToSave)+"/","char");
            cls();
            break;
        case ALT:
            cls();
            stitch();
            toImage(sizeX,sizeY,1.5,5);
            break;
        case BACKSPACE:
            msg = msg.substring(0,max(0,msg.length()-1));
            break;
        default:
            switch (key){
                case '^':
                    msg+="^{";
                    break;
                case '/':
                    msg+="/{";
                    break;
                default:
                    msg+=(char)key;
                    if (msg.length()>0) charToSave = ""+msg.charAt(0);
            }
    }  
}