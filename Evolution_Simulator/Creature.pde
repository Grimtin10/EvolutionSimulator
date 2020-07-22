class Creature {
  int generation;
  int kids;
  int carnivoreParts;
  int eggTime;
  int foodEaten, superfoodEaten, poisonEaten, smartfoodEaten, lightningfoodEaten, creaturesEaten; 
  int age = 0;
  float sfColor;
  float x, y, r, movementSpeed, currentSpeed, kidEnergy, energy;
  float creatureSize;
  String name;
  String parentName;
  
  boolean selected = false;
  
  ArrayList<Food> eatenFood = new ArrayList<Food>();
  ArrayList<Superfood> eatenSuperfood = new ArrayList<Superfood>();
  ArrayList<Poison> eatenPoison = new ArrayList<Poison>();
  ArrayList<Smartfood> eatenSmartfood = new ArrayList<Smartfood>();
  ArrayList<Lightningfood> eatenLightningfood = new ArrayList<Lightningfood>();

  
  public Creature(float movementSpeed, float kidEnergy, float energy, int eggTime, int carnivoreParts, int generation, float x,
  float y, float creatureSize, float sfColor, String name, String parentName){
    this.movementSpeed = movementSpeed;
    this.currentSpeed = movementSpeed;
    this.kidEnergy = kidEnergy;
    this.carnivoreParts = carnivoreParts;
    this.eggTime = eggTime;
    this.generation = generation;
    this.x = x;
    this.y = y;
    this.sfColor = sfColor;
    this.energy = energy;
    this.creatureSize = creatureSize;
    this.name = name;
    this.parentName = parentName;
    r = random(0, 360);
  }
  
  public void update(int id){
    
    x += cos(radians(r)) * currentSpeed;
    y += sin(radians(r)) * currentSpeed;
    x = (x < creatureSize/2) ? creatureSize/2 : (x > width - creatureSize + creatureSize/2) ? width - creatureSize + creatureSize/2 : x;
    y = (y < creatureSize/2) ? creatureSize/2 : (y > height - creatureSize + creatureSize/2) ? height - creatureSize + creatureSize/2 : y;
     
    if(frameCount % round(frameRate) == 0){
      age++;
    }
    
    if(currentSpeed > movementSpeed){
      currentSpeed -= 0.01;
    }
    if(currentSpeed < movementSpeed){
      currentSpeed = movementSpeed;
    }
    
    if(x == creatureSize/2) {r += random(140, 180);} if(y == creatureSize/2) {r += random(140, 180);} if(x == width - creatureSize + creatureSize/2) {r += random(140, 180);} if(y == height - creatureSize + creatureSize/2) {r += random(140, 180);}
    
    //TODO: This shit is inefficient! Add optimization.
    if(carnivoreParts < carnivorePartsNeeded){
    if(x == creatureSize/2) {r += random(140, 180);} if(y == creatureSize/2) {r += random(140, 180);} if(x == width - creatureSize + creatureSize/2) {r += random(140, 180);} if(y == height - creatureSize + creatureSize/2) {r += random(140, 180);}
      for(int i = 0; i < smartfood.size(); i++){
        float r = random(0,1);
        if(!smartfood.get(i).eaten && r > map(abs(sfColor-smartfood.get(i).sfColor), 0, 255, 0, 1) && dist(x, y, smartfood.get(i).x, smartfood.get(i).y) < creatureSize/2+7.5){
          smartfood.get(i).x = random(width);
          smartfood.get(i).y = random(height);
          smartfood.get(i).sfColor = smartfood.get(round(random(smartfood.size()-1))).sfColor+random(-20,20);
          energy += (foodEnergyAmt * 10)/(abs(sfColor - smartfood.get(i).sfColor));
          if(smartfood.get(i).sfColor < 0){
            smartfood.get(i).sfColor=0;
          } else if(smartfood.get(i).sfColor > 255){
            smartfood.get(i).sfColor=255;
          }
          smartfoodEaten++;
        } else if(!smartfood.get(i).eaten && dist(x, y, smartfood.get(i).x, smartfood.get(i).y) < creatureSize/2+7.5){
          r += random(-45, 45);
          x += cos(radians(r)) * movementSpeed*2;
          y += sin(radians(r)) * movementSpeed*2;
          x = (x < creatureSize + creatureSize/2) ? creatureSize + creatureSize/2 : (x > width - creatureSize + creatureSize/2) ? width - creatureSize + creatureSize/2 : x;
          y = (y < creatureSize + creatureSize/2) ? creatureSize + creatureSize/2 : (y > height - creatureSize + creatureSize/2) ? height - creatureSize + creatureSize/2 : y;
        }
      }
      for(int i = 0; i < food.size(); i++){
        if(!food.get(i).eaten && dist(x, y, food.get(i).x, food.get(i).y) < creatureSize/2+7.5){
          food.get(i).x = random(width);
          food.get(i).y = random(height);
          energy += foodEnergyAmt;
          r += random(-45, 45);
          food.get(i).eaten = true;
          eatenFood.add(food.get(i));
          foodEaten++;
        }
      }
      for(int i = 0; i < superfood.size(); i++){
        if(!superfood.get(i).eaten && dist(x, y, superfood.get(i).x, superfood.get(i).y) < creatureSize/2+5){
          superfood.get(i).x = random(width);
          superfood.get(i).y = random(height);
          energy += (foodEnergyAmt * 3);
          r += random(-45, 45);
          superfood.get(i).eaten = true;
          eatenSuperfood.add(superfood.get(i));
          superfoodEaten++;
        }
      }
      for(int i = 0; i < poison.size(); i++){
        if(!poison.get(i).eaten && dist(x, y, poison.get(i).x, poison.get(i).y) < creatureSize/2+3.5){
          poison.get(i).x = random(width);
          poison.get(i).y = random(height);
          energy -= (foodEnergyAmt * 5);
          r += random(-45, 45);
          poison.get(i).eaten = true;
          eatenPoison.add(poison.get(i));
          poisonEaten++;
        }
      }
    } else {
      for(int i = 0; i < creatures.size(); i++){
        if(dist(x, y, creatures.get(i).x, creatures.get(i).y) < creatureSize/2+creatures.get(i).creatureSize && (x != creatures.get(i).x && y != creatures.get(i).y)){
          if(creatures.get(i).carnivoreParts < carnivorePartsNeeded && random(0,1) > map(creatures.get(i).carnivoreParts, 0, carnivorePartsNeeded, 0, 1)){
            creatures.get(i).energy = 0;
            energy += foodEnergyAmt;
            r += random(-45, 45);
            creaturesEaten++;
          } 
        }
      }
    }
    for(int i = 0; i < lightningfood.size(); i++){
        if(!lightningfood.get(i).eaten && dist(x, y, lightningfood.get(i).x, lightningfood.get(i).y) < creatureSize/2+5){
          lightningfood.get(i).x = random(width);
          lightningfood.get(i).y = random(height);
          energy += lightningfoodEnergyAmt;
          currentSpeed += 2;
          r += random(-45, 45);
          lightningfood.get(i).eaten = true;
          eatenLightningfood.add(lightningfood.get(i));
          lightningfoodEaten++;
        }
      }
      
    //TODO: Add mutation rate settings instead of constants.
    if(energy >= kidEnergy + startEnergy) {
      int newCarnivoreP = carnivoreParts;
      float newkidEnergy = kidEnergy;
      String newName = new String(name);
      float newSfColor = sfColor;
      float newSpeed = movementSpeed;
      for(int i=0;i<newName.length();i++){
        if(random(0,1)<0.33333){
          if(i%2!=0){
            newName = replaceCharAt(name,i,vowels[round(random(vowels.length-1))]);
          } else {
            newName = replaceCharAt(name,i,consonants[round(random(consonants.length-1))]);
          }
        }
      }
      newkidEnergy += random(-1, 1);
      if(random(0, 100) <= carnivoreMutationRate){
        newCarnivoreP += round(random(-1, 1));
      }
      newSpeed += random(-mutationAmount, mutationAmount);
      newSpeed = (newSpeed < 1.5) ? 1.5 : newSpeed;
      newSfColor += random(-32, 32);
      newSfColor = (newSfColor < 0) ? 0 : (newSfColor > 255) ? 255 : newSfColor;
      eggs.add(new Egg(newSpeed, (newkidEnergy <= 5) ? 5 : newkidEnergy, kidEnergy, eggTime, eggTime + round(random(-mutationAmount, mutationAmount)), (newCarnivoreP <= 0) ? 0 : newCarnivoreP, generation + 1, x, y, creatureSize + random(-5, 5), newSfColor, newName, name));
      energy -= kidEnergy; 
      kids++;
    }
    energy -= energyLoss * creatureSize/15 + (abs(movementSpeed / 3)*energyLoss); 
      
    for(int i =0; i < eatenFood.size(); i++){
      eatenFood.get(i).x = x + random(-50, 50);
      eatenFood.get(i).y = y + random(-50, 50);
      eatenFood.get(i).x = (eatenFood.get(i).x < 0) ? 0 : (eatenFood.get(i).x > width) ? width: eatenFood.get(i).x;
      eatenFood.get(i).y = (eatenFood.get(i).y < 0) ? 0 : (eatenFood.get(i).y > height) ? height: eatenFood.get(i).y;
    }
    for(int i =0; i < eatenSuperfood.size(); i++){
      eatenSuperfood.get(i).x = x + random(-50, 50);
      eatenSuperfood.get(i).y = y + random(-50, 50);
      eatenSuperfood.get(i).x = (eatenSuperfood.get(i).x < 0) ? 0 : (eatenSuperfood.get(i).x > width) ? width: eatenSuperfood.get(i).x;
      eatenSuperfood.get(i).y = (eatenSuperfood.get(i).y < 0) ? 0 : (eatenSuperfood.get(i).y > height) ? height: eatenSuperfood.get(i).y;
    }
    for(int i =0; i < eatenPoison.size(); i++){
      eatenPoison.get(i).x = x + random(-50, 50);
      eatenPoison.get(i).y = y + random(-50, 50);
      eatenPoison.get(i).x = (eatenPoison.get(i).x < 0) ? 0 : (eatenPoison.get(i).x > width) ? width: eatenPoison.get(i).x;
      eatenPoison.get(i).y = (eatenPoison.get(i).y < 0) ? 0 : (eatenPoison.get(i).y > height) ? height: eatenPoison.get(i).y;
    }
    for(int i =0; i < eatenLightningfood.size(); i++){
      eatenLightningfood.get(i).x = x + random(-50, 50);
      eatenLightningfood.get(i).y = y + random(-50, 50);
      eatenLightningfood.get(i).x = (eatenLightningfood.get(i).x < 0) ? 0 : (eatenLightningfood.get(i).x > width) ? width: eatenLightningfood.get(i).x;
      eatenLightningfood.get(i).y = (eatenLightningfood.get(i).y < 0) ? 0 : (eatenLightningfood.get(i).y > height) ? height: eatenLightningfood.get(i).y;
    }
    if(energy <= 0){
      for(int i = 0; i < eatenFood.size(); i++){
        eatenFood.get(i).eaten = false;
      }
      for(int i = 0; i < eatenSuperfood.size(); i++){
        eatenSuperfood.get(i).eaten = false;
      }
      for(int i = 0; i < eatenPoison.size(); i++){
        eatenPoison.get(i).eaten = false;
      }     
      if(id<selectedCreature){
        selectedCreature--;
      }
    }
    if(creatureSize <= 9){
      creatureSize = 10;
    }
    if(creatureSize >= 26){
      creatureSize = 25;
    }
  }
  
  public void render(){
    if(carnivoreParts >= carnivorePartsNeeded){
      carnivorePopulation++;
    } else {
      herbivorePopulation++;
    }    
    if(selected){
      strokeWeight(5);
      stroke(0, 0, 255);
    } else {
      strokeWeight(2);
      stroke(sfColor, sfColor, 255);
    }
    fill(lerpColor(color(255), color(255, 0, 0), map(carnivoreParts, 0, carnivorePartsNeeded, 0 ,1)));
    ellipse(x, y, creatureSize, creatureSize);
  }
}
