/*
Evolution simulator created by Grimtin10 and Supersizedman.
This program is designed to simulate evolution on a simple scale.
There are many features we have worked on implementing, and
more on the way. In this simulation you are equipped with 
many ways to edit the simulation, and some extra features 
to provide extra information, such as graphs with multiple 
data points or the ability to select creatures, eggs, and 
smartfood. 

Copyright 2020, Grimtin10 and Supersizedman
*/


//These are the simulation variables, split into settings and then generic variables.

//The starting population of the simulation.
int startingPopulation = 30;

//The population of the two species.
int herbivorePopulation;
int carnivorePopulation;

//The starting food of the simulation.
int startingFood = 2000;

//The current amounts of each food.
int currentFood; //Regular food, provides "foodEnergyAmount" amount of energy to the creatures that eat it.
int currentSuperfood; //Superfood gives 10x the regular food amount.
int currentPoison; //Poison technically isnt a food, but it is classified as such.
int currentSmartfood; //Smartfood is a food that can evolve, having a color that the creatures can have a preference towards.

//The selected objects.
int selectedCreature;
int selectedEgg;
int selectedSmartFood;

//The selected mode of editing.
int selectedMode = 0;

//The amount of selectedMode, goes up when everything goes extinct.
int simulations = 0;

//The time the simulation has been run.
int seconds = 0;
int minutes = 0;

//The mutation rate of a creatures carnivore parts.
float carnivoreMutationRate = 50;
float carnivorePartsNeeded = 4;

//The amount of energy creatures lose each frame.
float energyLoss = 0.01;

//The minumum starting energy for creatures.
float startEnergy = 5;

//The amount of energy food gives.
float foodEnergyAmt = 1;

//Mutation settings.
float mutationAmount = 1; //Default mutation amount.

//Are things selected?
boolean creatureSelected = false;
boolean eggSelected = false;
boolean sfSelected = false;

//Is the simulation paused?
boolean pause = false;

//Render eaten food?
boolean renderEaten = false;

//Are the graphs ready to render? (Created due to multi-threading.)
boolean ready = false;

//TODO: Delete this variable, we already have a mode selected variable.
String mode = "Food Edit";

//Simulation arraylists.
ArrayList<Creature> creatures = new ArrayList<Creature>(); //The alive creatures.
ArrayList<Egg> eggs = new ArrayList<Egg>(); //The creature's eggs.

//The different types of food that are in the simulation.
ArrayList<Food> food = new ArrayList<Food>();
ArrayList<Superfood> superfood = new ArrayList<Superfood>();
ArrayList<Poison> poison = new ArrayList<Poison>();
ArrayList<Smartfood> smartfood = new ArrayList<Smartfood>();

//Graph arraylists.

//The graphs that describe overall-population stats.
ArrayList<Float> populationGraph = new ArrayList<Float>();
ArrayList<Float> ageGraph = new ArrayList<Float>();
ArrayList<Float> herbGraph = new ArrayList<Float>();
ArrayList<Float> carnGraph = new ArrayList<Float>();
ArrayList<Float> smartfoodColorGraph = new ArrayList<Float>();
ArrayList<Float> sfColorGraph = new ArrayList<Float>();
ArrayList<Float> eggGraph = new ArrayList<Float>();

//The graphs that describe herbivore population stats.
ArrayList<Float> herbSpeedGraph = new ArrayList<Float>();
ArrayList<Float> herbKidsGraph = new ArrayList<Float>();
ArrayList<Float> herbPartsGraph = new ArrayList<Float>();
ArrayList<Float> herbEggTimeGraph = new ArrayList<Float>();
ArrayList<Float> herbKidEnergyGraph = new ArrayList<Float>();
ArrayList<Float> herbSizeGraph = new ArrayList<Float>();
ArrayList<Float> herbEnergyGraph = new ArrayList<Float>();

//The graphs that describe carnivore population stats.
ArrayList<Float> carnSpeedGraph = new ArrayList<Float>();
ArrayList<Float> carnKidsGraph = new ArrayList<Float>();
ArrayList<Float> carnEggTimeGraph = new ArrayList<Float>();
ArrayList<Float> carnKidEnergyGraph = new ArrayList<Float>();
ArrayList<Float> carnSizeGraph = new ArrayList<Float>();
ArrayList<Float> carnEnergyGraph = new ArrayList<Float>();

//Arrays for name generation.
char[] consonants = {'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z'};
char[] vowels = {'a', 'e', 'i','o', 'u'};

void settings() {
  size(1820, 980);
  
  String[] args1 = {"Graph"};
  PopulationGraph sa1 = new PopulationGraph();
  PApplet.runSketch(args1, sa1);
  String[] args2 = {"Graph"};
  HerbivoreGraph sa2 = new HerbivoreGraph();
  PApplet.runSketch(args2, sa2);
  String[] args3 = {"Graph"};
  CarnivoreGraph sa3 = new CarnivoreGraph();
  PApplet.runSketch(args3, sa3);
  
  for(int i = 0; i < startingPopulation; i++){
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
  for(int i = 0; i < startingFood; i++){
    food.add(new Food(random(width), random(height)));
  }
  for(int i = 0; i < startingFood/10; i++){
    superfood.add(new Superfood(random(width), random(height)));
  }
  for(int i = 0; i < startingFood/18; i++){
    poison.add(new Poison(random(width), random(height)));
  }
  for(int i = 0; i < startingFood/12; i++){
    smartfood.add(new Smartfood(random(width), random(height), 128));
  }
}

void draw() {
  background(0);
  
  currentFood = 0;
  currentSuperfood = 0;
  currentPoison = 0;
  currentSmartfood = 0;
  
  herbivorePopulation = 0;
  carnivorePopulation = 0;
  
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
  thread("updateEggs");
  for(int i = 0; i < eggs.size(); i++){
    eggs.get(i).render();
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
  
  if(selectedMode == 0){
    mode = "Food Edit";
  }
  if(selectedMode == 1){
    mode = "Food Energy Edit";
  }
  if(selectedMode == 2){
    mode = "Start Energy Edit";
  }
  if(selectedMode == 3){
    mode = "Carnivore Needed Edit";
  }
  if(selectedMode == 4){
    mode = "Energy Loss Edit";
  }
  
  if(creatures.size() > 0 && selectedCreature < creatures.size() && creatures.get(selectedCreature) != null && creatureSelected){
    creatures.get(selectedCreature).selected = true;
    fill(255,120, 25);
    text("Generation: " + creatures.get(selectedCreature).generation/2, 0, 256);
    text("Energy: " + creatures.get(selectedCreature).energy, 0, 288);
    text("Energy Loss: " + "-" + energyLoss, 0, 320);
    text("Speed(pixels per frame): " + creatures.get(selectedCreature).movementSpeed, 0, 352);
    text("Kid Energy: " + creatures.get(selectedCreature).kidEnergy + " + " + startEnergy, 0, 384);
    text("Egg Hatch Time: " + creatures.get(selectedCreature).eggTime, 0, 416);
    text("Kids Had: " + creatures.get(selectedCreature).kids, 0, 448);
    text("Carnivore Parts Need: " + carnivorePartsNeeded, 0, 480);
    text("Carnivore Parts: " + creatures.get(selectedCreature).carnivoreParts, 0, 512);
    text("Food Energy Amount: " + foodEnergyAmt, 0, 544);
    text("Creature Size: " + creatures.get(selectedCreature).creatureSize, 0, 576);
    text("Prefered Smartfood: " + creatures.get(selectedCreature).sfColor, 0, 608);
    text("Age (in seconds): " + creatures.get(selectedCreature).age, 0, 640);
    text("Name: " + creatures.get(selectedCreature).name, 0, 672);
    text("Parent Name: " + creatures.get(selectedCreature).parentName, 0, 704);
  }
  if(eggs.size() > 0 && selectedEgg < eggs.size() && eggs.get(selectedEgg) != null && eggSelected){
    eggs.get(selectedEgg).selected = true;
    fill(255,120, 25);
    text("Seconds until hatch: " + (eggs.get(selectedEgg).time-eggs.get(selectedEgg).age), 0, 256);
  }
  if(smartfood.size() > 0 && selectedSmartFood < smartfood.size() && smartfood.get(selectedSmartFood) != null && sfSelected){
    smartfood.get(selectedSmartFood).selected = true;
    fill(255, 120, 25);
    text("Smartfood Color: " + (smartfood.get(selectedSmartFood).sfColor), 0, 256);
  }
  fill(200, 200, 255);
  textSize(32);
  text("Population: " + creatures.size() + " (" + herbivorePopulation + "/" + carnivorePopulation + ")", 0, 32);
  text("Eggs: " + eggs.size(), 0, 64); 
  text("Food: " + (currentFood + currentSuperfood + currentPoison + currentSmartfood) + " (" + currentFood + "/" + currentSuperfood + "/" + currentPoison + "/" + currentSmartfood + ")" , 0, 96);
  text("FPS: " + frameRate, 0, 128);
  text("Mode: " + mode, 0, 160);
  text("Simulations: " + simulations, 0, 192);
  text("Simulation Time: " + "(" + minutes + ":" + ((seconds<10) ? "0" + seconds : seconds) + ")", 0, 224);

  if(!pause){
    if(frameCount % round(frameRate) == 0){
      seconds++;
    }  
    if(seconds == 60){
      minutes++;
      seconds = 0;
    }
  }
  if(!pause&&frameCount%(round(frameRate)/2)==0){
    populationGraph.add((float)herbivorePopulation+carnivorePopulation);
    if(populationGraph.size()>500){
      populationGraph.remove(0);
    }
    herbGraph.add((float)herbivorePopulation);
    eggGraph.add((float)eggs.size());
    if(eggGraph.size()>500){
      eggGraph.remove(0);
    }
    carnGraph.add((float)carnivorePopulation);
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
      if(creatures.get(i).carnivoreParts < carnivorePartsNeeded){
        avgHerbSpeed+=creatures.get(i).movementSpeed;
      } else {
        avgCarnSpeed+=creatures.get(i).movementSpeed;
      }
    }
    avgHerbSpeed/=herbivorePopulation;
    avgCarnSpeed/=carnivorePopulation;
    herbSpeedGraph.add(avgHerbSpeed);
    if(herbSpeedGraph.size()>500){
      herbSpeedGraph.remove(0);
    }
    if(carnivorePopulation>0){
      carnSpeedGraph.add(avgCarnSpeed);
      if(carnSpeedGraph.size()>500){
        carnSpeedGraph.remove(0);
      }
    }
    float avgHerbKids=0;
    float avgCarnKids=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivorePartsNeeded){
        avgHerbKids+=creatures.get(i).kids;
      } else {
        avgCarnKids+=creatures.get(i).kids;
      }
    }
    avgHerbKids/=herbivorePopulation;
    avgCarnKids/=carnivorePopulation;
    herbKidsGraph.add(avgHerbKids);
    if(herbKidsGraph.size()>500){
      herbKidsGraph.remove(0);
    }
    if(carnivorePopulation>0){
      carnKidsGraph.add(avgCarnKids);
      if(carnKidsGraph.size()>500){
        carnKidsGraph.remove(0);
      }
    }
    float avgHerbParts=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivorePartsNeeded){
        avgHerbSpeed+=creatures.get(i).carnivoreParts;
      }
    }
    avgHerbParts/=herbivorePopulation;
    herbPartsGraph.add(avgHerbParts);
    if(herbPartsGraph.size()>500){
      herbPartsGraph.remove(0);
    }
    float avgHerbEggTime=0;
    float avgCarnEggTime=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivorePartsNeeded){
        avgHerbEggTime+=creatures.get(i).eggTime;
      } else {
        avgCarnEggTime+=creatures.get(i).eggTime;
      }
    }
    avgHerbEggTime/=herbivorePopulation;
    avgCarnEggTime/=carnivorePopulation;
    herbEggTimeGraph.add(avgHerbEggTime);
    if(herbEggTimeGraph.size()>500){
      herbEggTimeGraph.remove(0);
    }
    if(carnivorePopulation>0){
      carnEggTimeGraph.add(avgCarnEggTime);
      if(carnEggTimeGraph.size()>500){
        carnEggTimeGraph.remove(0);
      }
    }
    float avgHerbKidEnergy=0;
    float avgCarnKidEnergy=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivorePartsNeeded){
        avgHerbKidEnergy+=creatures.get(i).kidEnergy;
      } else {
        avgCarnKidEnergy+=creatures.get(i).kidEnergy;
      }
    }
    avgHerbKidEnergy/=herbivorePopulation;
    avgCarnKidEnergy/=carnivorePopulation;
    herbKidEnergyGraph.add(avgHerbKidEnergy);
    if(herbKidEnergyGraph.size()>500){
      herbKidEnergyGraph.remove(0);
    }
    if(carnivorePopulation>0){
      carnKidEnergyGraph.add(avgCarnKidEnergy);
      if(carnKidEnergyGraph.size()>500){
        carnKidEnergyGraph.remove(0);
      }
    }
    float avgHerbSize=0;
    float avgCarnSize=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivorePartsNeeded){
        avgHerbSize+=creatures.get(i).creatureSize;
      } else {
        avgCarnSize+=creatures.get(i).creatureSize;
      }
    }
    avgHerbSize/=herbivorePopulation;
    avgCarnSize/=carnivorePopulation;
    herbSizeGraph.add(avgHerbSize);
    if(herbSizeGraph.size()>500){
      herbSizeGraph.remove(0);
    }
    if(carnivorePopulation>0){
      carnSizeGraph.add(avgCarnSize);
      if(carnSizeGraph.size()>500){
        carnSizeGraph.remove(0);
      }
    }
    float avgHerbEnergy=0;
    float avgCarnEnergy=0;
    for(int i=0;i<creatures.size();i++){
      if(creatures.get(i).carnivoreParts < carnivorePartsNeeded){
        avgHerbEnergy+=creatures.get(i).energy;
      } else {
        avgCarnEnergy+=creatures.get(i).energy;
      }
    }
    avgHerbEnergy/=herbivorePopulation;
    avgCarnEnergy/=carnivorePopulation;
    herbEnergyGraph.add(avgHerbEnergy);
    if(herbEnergyGraph.size()>500){
      herbEnergyGraph.remove(0);
    }
    if(carnivorePopulation>0){
      carnEnergyGraph.add(avgCarnEnergy);
      if(carnEnergyGraph.size()>500){
        carnEnergyGraph.remove(0);
      }
    }
  }
  ready = true;
}

void updateEggs(){
  for(int i = 0; i < eggs.size(); i++){
    if(!pause){
      eggs.get(i).update(i);
    }
    if(eggs.get(i).hatched){
      eggs.remove(i);
    }
  }
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
       selectedSmartFood = i;
       sfSelected = true;
       smartfood.get(selectedSmartFood).selected = true;
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
    for(int i = 0; i < startingPopulation; i++){
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
    for(int i = 0; i < startingFood; i++){
      food.add(new Food(random(width), random(height)));
    }
    for(int i = 0; i < startingFood/12; i++){
      superfood.add(new Superfood(random(width), random(height)));
    }
    for(int i = 0; i < startingFood/20; i++){
      poison.add(new Poison(random(width), random(height)));
    }
  for(int i = 0; i < startingFood/8; i++){
    smartfood.add(new Smartfood(random(width), random(height), 128));
    }
  }
  if(key == 'e' || key == 'E'){
    selectedMode++;
    if(selectedMode == 5){
      selectedMode = 0;    
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
      carnivorePartsNeeded++;
    }
    if((key == 's'|| key == 'S')&& carnivorePartsNeeded > 0) {
      carnivorePartsNeeded--;
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
