//penis

int minPop = 30;
int herbPop;
int carnPop;
int foodAmt = 2000;
int currentFood = 1000; 
int currentSuperfood = 84;
int currentPoison = 50;
int currentSmartfood = 500;
int selectedCreature;
int selectedEgg;
int selectedSf;
int modeNum = 0;
int sims = 0;
int secs = 0;
int mins = 0;
float carnivoreMutation = 50;
float carnivoreNeeded = 4;
float energyLoss = 0.01;
float startEnergy = 5;
float foodEnergyAmt = 1;
float mutationAmount = 1;
boolean creatureSelected = false;
boolean eggSelected = false;
boolean sfSelected = false;
boolean pause = false;
boolean renderEaten = false;
boolean ready = false;
String mode = "Food Edit";

//Simulation arraylists
ArrayList<Creature> creatures = new ArrayList<Creature>();
ArrayList<Food> food = new ArrayList<Food>();
ArrayList<Egg> eggs = new ArrayList<Egg>();
ArrayList<Superfood> superfood = new ArrayList<Superfood>();
ArrayList<Poison> poison = new ArrayList<Poison>();
ArrayList<Smartfood> smartfood = new ArrayList<Smartfood>();

//Overall graphs
ArrayList<Float> populationGraph = new ArrayList<Float>();
ArrayList<Float> ageGraph = new ArrayList<Float>();
ArrayList<Float> herbGraph = new ArrayList<Float>();
ArrayList<Float> carnGraph = new ArrayList<Float>();
ArrayList<Float> smartfoodColorGraph = new ArrayList<Float>();
ArrayList<Float> sfColorGraph = new ArrayList<Float>();

//Herbivore graphs
ArrayList<Float> herbSpeedGraph = new ArrayList<Float>();
ArrayList<Float> herbKidsGraph = new ArrayList<Float>();
ArrayList<Float> herbPartsGraph = new ArrayList<Float>();
ArrayList<Float> herbEggTimeGraph = new ArrayList<Float>();
ArrayList<Float> herbKidEnGraph = new ArrayList<Float>();
ArrayList<Float> herbSizeGraph = new ArrayList<Float>();
ArrayList<Float> herbEnergyGraph = new ArrayList<Float>();

//Carnivore graphs
ArrayList<Float> carnSpeedGraph = new ArrayList<Float>();
ArrayList<Float> carnKidsGraph = new ArrayList<Float>();
ArrayList<Float> carnEggTimeGraph = new ArrayList<Float>();
ArrayList<Float> carnKidEnGraph = new ArrayList<Float>();
ArrayList<Float> carnSizeGraph = new ArrayList<Float>();
ArrayList<Float> carnEnergyGraph = new ArrayList<Float>();

char[] consonants = {'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z'};
char[] vowels = {'a', 'e', 'i','o', 'u'};

void settings() {
  size(1920, 1015);
  
  String[] args1 = {"Graph"};
  PopulationGraph sa1 = new PopulationGraph();
  PApplet.runSketch(args1, sa1);
  String[] args2 = {"Graph"};
  HerbivoreGraph sa2 = new HerbivoreGraph();
  PApplet.runSketch(args2, sa2);
  String[] args3 = {"Graph"};
  CarnivoreGraph sa3 = new CarnivoreGraph();
  PApplet.runSketch(args3, sa3);
  
  for(int i = 0; i < minPop; i++){
    String name = "";
    for(int j = 0; j < round(random(2, 5)); j ++){
      int t = 0;
      name += consonants[round(random(0, 20))];
      name += vowels[round(random(0, 4))];
      if(random(0, 1) < 0.25 && t < 3){
        t++;
        name += vowels[round(random(0, 4))];
      }
    }
    creatures.add(new Creature(1.75, 10, startEnergy, 10, 0, 0, width/2, height/2, 15, 64, name, ""));
  }
  for(int i = 0; i < foodAmt; i++){
    food.add(new Food(random(width), random(height)));
  }
  for(int i = 0; i < foodAmt/10; i++){
    superfood.add(new Superfood(random(width), random(height)));
  }
  for(int i = 0; i < foodAmt/18; i++){
    poison.add(new Poison(random(width), random(height)));
  }
  for(int i = 0; i < foodAmt/12; i++){
    smartfood.add(new Smartfood(random(width), random(height), 128));
  }
}

void draw() {
  background(0);
  
  currentFood = 0;
  currentSuperfood = 0;
  currentPoison = 0;
  currentSmartfood = 0;
  
  herbPop = 0;
  carnPop = 0;
  
  for(int i = 0; i < food.size(); i++){
    food.get(i).render();
  }
  for(int i = 0; i < superfood.size(); i++){
    superfood.get(i).render();
  }
  for(int i = 0; i < poison.size(); i++){
    poison.get(i).render();
  }
  for(int i = 0; i < smartfood.size(); i++){
    smartfood.get(i).render();
  }
  for(int i = 0; i < eggs.size(); i++){
    if(!pause){
      eggs.get(i).update(i);
    } 
  eggs.get(i).render();
  if(eggs.get(i).hatched){
    eggs.remove(i);
    }
  }
  
  for(int i = 0; i < creatures.size(); i++){
    if(!pause){
      creatures.get(i).update(i);
    }
    creatures.get(i).render();
    creatures.get(i).selected = false;
    if(creatures.get(i).energy <= 0){
      creatures.remove(i);
    }
  }
  
  if(modeNum == 0){
    mode = "Food Edit";
  }
  if(modeNum == 1){
    mode = "Food Energy Edit";
  }
  if(modeNum == 2){
    mode = "Start Energy Edit";
  }
  if(modeNum == 3){
    mode = "Carnivore Needed Edit";
  }
  if(modeNum == 4){
    mode = "Energy Loss Edit";
  }
  
  if(creatures.size() > 0 && selectedCreature < creatures.size() && creatures.get(selectedCreature) != null && creatureSelected){
    creatures.get(selectedCreature).selected = true;
    fill(255,120, 25);
    text("Generation: " + creatures.get(selectedCreature).generation/2, 0, 256);
    text("Energy: " + creatures.get(selectedCreature).energy, 0, 288);
    text("Energy Loss: " + "-" + energyLoss, 0, 320);
    text("Speed(pixels per frame): " + creatures.get(selectedCreature).mSpeed, 0, 352);
    text("Kid Energy: " + creatures.get(selectedCreature).kidEn + " + " + startEnergy, 0, 384);
    text("Egg Hatch Time: " + creatures.get(selectedCreature).eggTime, 0, 416);
    text("Kids Had: " + creatures.get(selectedCreature).kids, 0, 448);
    text("Carnivore Parts Need: " + carnivoreNeeded, 0, 480);
    text("Carnivore Parts: " + creatures.get(selectedCreature).carnivoreParts, 0, 512);
    text("Food Energy Amount: " + foodEnergyAmt, 0, 544);
    text("Creature Size: " + creatures.get(selectedCreature).cSize, 0, 576);
    text("Prefered Smartfood: " + creatures.get(selectedCreature).sfColor, 0, 608);
    text("Age (in seconds): " + creatures.get(selectedCreature).age, 0, 640);
    text("Name: " + creatures.get(selectedCreature).name, 0, 672);
    text("Parent Name: " + creatures.get(selectedCreature).parentName, 0, 704);
  }
  if(eggs.size() > 0 && selectedEgg < eggs.size() && eggs.get(selectedEgg) != null && eggSelected){
    eggs.get(selectedEgg).selected = true;
    fill(255,120, 25);
    text("Frames until hatch: " + (eggs.get(selectedEgg).time- frameCount), 0, 256);
  }
  if(smartfood.size() > 0 && selectedSf < smartfood.size() && smartfood.get(selectedSf) != null && sfSelected){
    smartfood.get(selectedSf).selected = true;
    fill(255, 120, 25);
    text("Smartfood Color: " + (smartfood.get(selectedSf).sfColor), 0, 256);
  }
  fill(200, 200, 255);
  textSize(32);
  text("Population: " + creatures.size() + " (" + herbPop + "/" + carnPop + ")", 0, 32);
  text("Eggs: " + eggs.size(), 0, 64); 
  text("Food: " + (currentFood + currentSuperfood + currentPoison + currentSmartfood) + " (" + currentFood + "/" + currentSuperfood + "/" + currentPoison + "/" + currentSmartfood + ")" , 0, 96);
  text("FPS: " + frameRate, 0, 128);
  text("Mode: " + mode, 0, 160);
  text("Simulations: " + sims, 0, 192);
  text("Simulation Time: " + "(" + mins + ":" + ((secs<10) ? "0" + secs : secs) + ")", 0, 224);

  if(!pause){
    if(frameCount % round(frameRate) == 0){
      secs++;
    }  
    if(secs == 60){
      mins++;
      secs = 0;
    }
  }
  //println((round(frameRate)/8));
  if(!pause&&frameCount%(round(frameRate)/2)==0){
    populationGraph.add((float)herbPop+carnPop);
    if(populationGraph.size()>500){
      populationGraph.remove(0);
    }
    herbGraph.add((float)herbPop);
    if(herbGraph.size()>500){
      herbGraph.remove(0);
    }
    carnGraph.add((float)carnPop);
    if(carnGraph.size()>500){
      carnGraph.remove(0);
    }
    float avgAge=0;
    for(int i=0;i<creatures.size();i++){
      avgAge+=creatures.get(i).age;
    }
    avgAge/=creatures.size();
    ageGraph.add(avgAge);
    if(ageGraph.size()>500){
      ageGraph.remove(0);
    }
    float avgSmartfoodColor=0;
    for(int i=0;i<smartfood.size();i++){
      avgSmartfoodColor+=smartfood.get(i).sfColor;
    }
    avgSmartfoodColor/=smartfood.size();
    smartfoodColorGraph.add(avgSmartfoodColor);
    if(smartfoodColorGraph.size()>500){
      smartfoodColorGraph.remove(0);
    }
    float avgSfColor=0;
    for(int i=0;i<creatures.size();i++){
      avgSfColor+=creatures.get(i).sfColor;
    }
    avgSfColor/=creatures.size();
    sfColorGraph.add(avgSfColor);
    if(sfColorGraph.size()>500){
      sfColorGraph.remove(0);
    }
    //Herbivore/Carnivore graphs start here
    float avgHerbSpeed=0;
    float avgCarnSpeed=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivoreNeeded){
        avgHerbSpeed+=creatures.get(i).mSpeed;
      } else {
        avgCarnSpeed+=creatures.get(i).mSpeed;
      }
    }
    avgHerbSpeed/=herbPop;
    avgCarnSpeed/=carnPop;
    herbSpeedGraph.add(avgHerbSpeed);
    if(herbSpeedGraph.size()>500){
      herbSpeedGraph.remove(0);
    }
    if(carnPop>0){
      carnSpeedGraph.add(avgCarnSpeed);
      if(carnSpeedGraph.size()>500){
        carnSpeedGraph.remove(0);
      }
    }
    float avgHerbKids=0;
    float avgCarnKids=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivoreNeeded){
        avgHerbKids+=creatures.get(i).kids;
      } else {
        avgCarnKids+=creatures.get(i).kids;
      }
    }
    avgHerbKids/=herbPop;
    avgCarnKids/=carnPop;
    herbKidsGraph.add(avgHerbKids);
    if(herbKidsGraph.size()>500){
      herbKidsGraph.remove(0);
    }
    if(carnPop>0){
      carnKidsGraph.add(avgCarnKids);
      if(carnKidsGraph.size()>500){
        carnKidsGraph.remove(0);
      }
    }
    float avgHerbParts=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivoreNeeded){
        avgHerbSpeed+=creatures.get(i).carnivoreParts;
      }
    }
    avgHerbParts/=herbPop;
    herbPartsGraph.add(avgHerbParts);
    if(herbPartsGraph.size()>500){
      herbPartsGraph.remove(0);
    }
    float avgHerbEggTime=0;
    float avgCarnEggTime=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivoreNeeded){
        avgHerbEggTime+=creatures.get(i).eggTime;
      } else {
        avgCarnEggTime+=creatures.get(i).eggTime;
      }
    }
    avgHerbEggTime/=herbPop;
    avgCarnEggTime/=carnPop;
    herbEggTimeGraph.add(avgHerbEggTime);
    if(herbEggTimeGraph.size()>500){
      herbEggTimeGraph.remove(0);
    }
    if(carnPop>0){
      carnEggTimeGraph.add(avgCarnEggTime);
      if(carnEggTimeGraph.size()>500){
        carnEggTimeGraph.remove(0);
      }
    }
    float avgHerbKidEn=0;
    float avgCarnKidEn=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivoreNeeded){
        avgHerbKidEn+=creatures.get(i).kidEn;
      } else {
        avgCarnKidEn+=creatures.get(i).kidEn;
      }
    }
    avgHerbKidEn/=herbPop;
    avgCarnKidEn/=carnPop;
    herbKidEnGraph.add(avgHerbKidEn);
    if(herbKidEnGraph.size()>500){
      herbKidEnGraph.remove(0);
    }
    if(carnPop>0){
      carnKidEnGraph.add(avgCarnKidEn);
      if(carnKidEnGraph.size()>500){
        carnKidEnGraph.remove(0);
      }
    }
    float avgHerbSize=0;
    float avgCarnSize=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivoreNeeded){
        avgHerbSize+=creatures.get(i).cSize;
      } else {
        avgCarnSize+=creatures.get(i).cSize;
      }
    }
    avgHerbSize/=herbPop;
    avgCarnSize/=carnPop;
    herbSizeGraph.add(avgHerbSize);
    if(herbSizeGraph.size()>500){
      herbSizeGraph.remove(0);
    }
    if(carnPop>0){
      carnSizeGraph.add(avgCarnSize);
      if(carnSizeGraph.size()>500){
        carnSizeGraph.remove(0);
      }
    }
    float avgHerbEnergy=0;
    float avgCarnEnergy=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivoreNeeded){
        avgHerbEnergy+=creatures.get(i).energy;
      } else {
        avgCarnEnergy+=creatures.get(i).energy;
      }
    }
    avgHerbEnergy/=herbPop;
    avgCarnEnergy/=carnPop;
    herbEnergyGraph.add(avgHerbEnergy);
    if(herbEnergyGraph.size()>500){
      herbEnergyGraph.remove(0);
    }
    if(carnPop>0){
      carnEnergyGraph.add(avgCarnEnergy);
      if(carnEnergyGraph.size()>500){
        carnEnergyGraph.remove(0);
      }
    }
  }
  ready = true;
}

String replaceCharAt(String s, int pos, char c) {
  char[] ch = new char[s.length()];
  s.getChars(0, ch.length, ch, 0);
  ch[pos] = c;
  return new String(ch);
} 

void mouseClicked() {
  creatureSelected = false;
  eggSelected = false;
  sfSelected = false;
  
  for(int i = 0; i < eggs.size(); i++){
     if(dist(eggs.get(i).x, eggs.get(i).y, mouseX, mouseY)<5){
       selectedEgg = i;
       eggSelected = true;
       eggs.get(selectedEgg).selected = true;
    }
  }
   for(int i = 0; i < creatures.size(); i++){
     if(dist(creatures.get(i).x, creatures.get(i).y, mouseX, mouseY)<7.5){
       selectedCreature = i;
       creatureSelected = true;
       creatures.get(selectedCreature).selected = true;
    }
  } 
  for(int i = 0; i < smartfood.size(); i++){
     if(dist(smartfood.get(i).x, smartfood.get(i).y, mouseX, mouseY)<7.5){
       selectedSf = i;
       sfSelected = true;
       smartfood.get(selectedSf).selected = true;
    }
  }
}

void keyPressed() {
  if(key == 'f'|| key == 'F'){
    for(int i = 0; i < food.size(); i++){
      food.remove(i);
    }
    for(int i = 0; i < superfood.size(); i++){
      superfood.remove(i);
    }
    for(int i = 0; i < poison.size(); i++){
      poison.remove(i);
    }
    for(int i = 0; i < eggs.size(); i++){
      eggs.remove(i);
    }
    for(int i = 0; i < creatures.size(); i++){
      creatures.remove(i);
    }
    for(int i = 0; i < smartfood.size(); i++){
      smartfood.remove(i);
    }
    for(int i = 0; i < minPop; i++){
      String name = "";
      for(int j = 0; j < round(random(2, 5)); j ++){
        int t = 0;
        name += consonants[round(random(0, 20))];
        name += vowels[round(random(0, 4))];
        if(random(0, 1) < 0.25 && t < 3){
          t++;
          name += vowels[round(random(0, 4))];
        }
      }
      creatures.add(new Creature(1, 10, startEnergy, 10, 0, 0, width/2, height/2, 15, 64, name, ""));
    }
    for(int i = 0; i < foodAmt; i++){
      food.add(new Food(random(width), random(height)));
    }
    for(int i = 0; i < foodAmt/12; i++){
      superfood.add(new Superfood(random(width), random(height)));
    }
    for(int i = 0; i < foodAmt/20; i++){
      poison.add(new Poison(random(width), random(height)));
    }
  for(int i = 0; i < foodAmt/8; i++){
    smartfood.add(new Smartfood(random(width), random(height), 128));
    }
  }
  if(key == 'e' || key == 'E'){
    modeNum++;
    if(modeNum == 5){
      modeNum = 0;    
    }
  }
  if(key =='r' || key == 'R'){
    renderEaten = !renderEaten;
  }
  if(key == ' '){
    pause = !pause;
  }
  if(mode == "Food Edit"){
    if(key == 'w' || key == 'W'){
      for(int i = 0; i < 10; i++){
        food.add(new Food(random(width), random(height)));
      }
      for(int i =0; i < 2; i++){
        superfood.add(new Superfood(random(width),random(height)));
      }
      for(int i =0; i < 1; i++){
        poison.add(new Poison(random(width),random(height)));
      }
    }  
    if((key == 's' || key == 'S') && food.size() > 0){
      for(int i = 0; i < 10; i++){
        food.remove(0);  
      }
      for(int i = 0; i < 2; i++){
        superfood.remove(0);  
      }
      for(int i = 0; i < 1; i++){
        poison.remove(0);  
      }
    }
  }
  if(mode == "Food Energy Edit"){
    if(key == 'w'|| key == 'W'){
      foodEnergyAmt++;
    }
    if((key == 's'|| key == 'S')&& foodEnergyAmt > 0){
      foodEnergyAmt--;
    }
  }
  if(mode == "Start Energy Edit"){
    if(key == 'w'|| key == 'W'){
      startEnergy++;
    }
    if((key == 's'|| key == 'S')&& startEnergy > 1) {
      startEnergy--;
    }
  }
  if(mode == "Carnivore Needed Edit"){
    if(key == 'w'|| key == 'W'){
      carnivoreNeeded++;
    }
    if((key == 's'|| key == 'S')&& carnivoreNeeded > 0) {
      carnivoreNeeded--;
    }
  }
  if(mode == "Energy Loss Edit"){
    if(key == 'w' || key == 'W'){
      energyLoss += 0.01; 
    }
    if((key == 's' || key == 'S') && energyLoss > 0){
      energyLoss -= 0.01; 
    }
  }
}
