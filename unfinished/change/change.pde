//Alan Li, Programming I
//generalised solution

//Inputs
float tender = 16.0;
float total = 2.39;

//get change in pennies and typecast
int change = (int)((tender-total)*100);

IntDict coins = new IntDict();
coins.set("Dollars",100);
coins.set("Quarters",25);
coins.set("Dimes",10);
coins.set("Nickels",5);
coins.set("Pennies",1);

print("Tender: "+tender+"\nTotal: "+total+"\nChange: "+change+"\n\n");

for (String k : coins.keys()) {
  int currentcoin = coins.get(k);
  int left =change%currentcoin;
  print(k+": "+((change-left)/currentcoin)+"\n");
  change = change%currentcoin;
}
