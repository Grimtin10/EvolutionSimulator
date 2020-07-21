class Egg {
  int carnivoreParts;
  int generation;
  int eggTime;
  int frames;
  float sfColor;
  float mSpeed, kidEn, energy, time, x, y;
  float cSize;
  String name;
  String parentName;
  
  boolean hatched = false;
  boolean selected = false;
  

  public Egg(float mSpeed, float kidEn, float energy, float time, int eggTime, int carnivoreParts, int generation, float x, float y, float cSize, float sfColor, String name, String parentName){
    this.mSpeed = mSpeed;
    this.kidEn = kidEn;
    this.energy = energy;
    this.carnivoreParts = carnivoreParts;
    this.generation = generation;
    this.eggTime = eggTime;
    this.x = x;
    this.y = y;
    this.cSize = cSize;
    this.time = (time * frameRate) + frameCount;
    this.sfColor = sfColor;
    this.name = name;
    this.parentName = parentName;
    hatched = false;
  }

  void update(int id){
    if(!pause){
      frames++;
    }
    if(frames >= time){
      hatched = true;
      creatures.add(new Creature(mSpeed + random(-mutationAmount, mutationAmount), kidEn, energy, eggTime, carnivoreParts, generation + 1, x, y, cSize + random(-5, 5), sfColor, name, parentName));    
      if(id<selectedEgg){
        selectedEgg--;
      }
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
