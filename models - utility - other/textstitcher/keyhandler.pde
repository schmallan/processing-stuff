
void keyPressed(){
    switch(keyCode){
        case BACKSPACE:

            if (keyCode == BACKSPACE) msg = msg.substring(0,Math.max(0,msg.length()-1));
            break;
        case SHIFT:
        cls();          
        break;
        case ENTER:
            int cn = charToTest.charAt(0)+1;
            charToTest = ""+(char)(cn);
            break;
        case ALT:
        cls();
            cImage(1);
            
            stitch();
            copyImageToClip(myimage);
            break;
        case TAB:
            saveChar();
            break;
        default:
                    
            msg+=key;
    }
    keys.put(key,true);


}