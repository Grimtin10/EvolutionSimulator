class Egg {
  int carnivoreParts;
  int generation;
  int eggTime;
  int age;
  int frames;
  float sfColor;
  float movementSpeed, kidEnergyergy, energy, time, x, y;
  float creatureSize;
  String name;
  String parentName;
  
  boolean hatched = false;
  boolean selected = false;
  

  public Egg(float movementSpeed, float kidEnergyergy, float energy, float time, int eggTime, int carnivoreParts,
  int generation, float x, float y, float creatureSize, float sfColor, String name, String parentName){
    this.movementSpeed = movementSpeed;
    this.kidEnergyergy = kidEnergyergy;
    this.energy = energy;
    this.carnivoreParts = carnivoreParts;
    this.generation = generation;
    this.eggTime = eggTime;
    this.x = x;
    this.y = y;
    this.creatureSize = creatureSize;
    this.time = time;
    this.sfColor = sfColor;
    this.name = name;
    this.parentName = parentName;
    frames = 0;
    hatched = false;
  }

  void update(int id){
    frames++;
    if(frames % round(frameRate) == 0){
      age++;
    }
    if(age >= time){
      if(id<selectedEgg){
        selectedEgg--;
      } else if(id==0){
        eggSelected = false;
      }
      hatched = true;
      creatures.add(new Creature(movementSpeed + random(-mutationAmount, mutationAmount), kidEnergyergy, energy, eggTime, carnivoreParts, generation + 1, x, y, creatureSize + random(-5, 5), sfColor, name, parentName));    
    }
  }
 
  void render(){    
    fill(255, 0, 255);
    if(selected){
      strokeWeight(2);
      stroke(0, 0, 255);
    }else {
      strokeWeight(1);
      stroke(0);
    }
    ellipse(x, y, 10, 10);
  }
}
