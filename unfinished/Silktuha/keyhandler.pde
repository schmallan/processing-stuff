import java.util.Map;

Map<Character, Boolean> keys = new HashMap<>();

boolean key(char c){
  if (!keys.containsKey(c)){
    return false;
  } else {
    return keys.get(c);  
  }
}

void keyPressed(){
  
    keys.put(key,true);
    
}

void keyReleased(){
 
    keys.put(key,false); 
  
}
