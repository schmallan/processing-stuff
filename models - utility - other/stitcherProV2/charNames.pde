import java.util.Set;

HashMap<String,String> charNames = new HashMap();
void init(){
charNames.put("\\","backslash");
charNames.put("(","parenthesesleft");
charNames.put(")","parenthesesright");
charNames.put("`","half");
charNames.put("/","slash");
charNames.put("|","verticalbar");
charNames.put("<","leftarrow");
charNames.put(">","rightarrow");
charNames.put(":","colon");
charNames.put(";","semicolon");
charNames.put("?","questionmark");
charNames.put("*","asterisk");
charNames.put("+","plus");
charNames.put("=","equals");
charNames.put("-","minus");
charNames.put("~","tilde");
charNames.put(".","period");
charNames.put("'","apostrophe");
charNames.put("d/dx","deriv");
for (int i = 'a'; i<='z'; i++){
    char upper = (char)(i+('A'-'a'));
    charNames.put(""+(char)i,"lowercase"+upper);
    charNames.put(""+upper,"uppercase"+upper);
}
for (int i = 0; i<=9; i++){
    charNames.put(""+i,"number"+i);
}

}

ArrayList<String> toStringArray(String inp){
    ArrayList<String> res = new ArrayList();
    for (int i = 0; i<inp.length(); i++){
        res.add(charNames.get(""+inp.charAt(i)));
    }
    return res;
}