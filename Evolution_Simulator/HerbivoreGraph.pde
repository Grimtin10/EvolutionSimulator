import java.util.*;

public class HerbivoreGraph extends PApplet {
  String state = "pop";
  
  public void settings() {
    size(500, 500);
  }
  public void draw() {
    if(ready){
      background(0);
      float maxSpeed=1;
      if(herbSpeedGraph.size()>0){
        maxSpeed=Collections.max(herbSpeedGraph);
        maxSpeed=(maxSpeed<34)?34:maxSpeed;
      }
      float maxKids=1;
      if(herbSpeedGraph.size()>0){
        maxKids=Collections.max(herbKidsGraph);
        maxKids=(maxSpeed<34)?34:maxKids;
      }
      float maxParts=1;
      if(herbSpeedGraph.size()>0){
        maxParts=Collections.max(herbPartsGraph);
        maxParts=(maxSpeed<34)?34:maxParts;
      }
      float maxEggTime=1;
      if(herbSpeedGraph.size()>0){
        maxEggTime=Collections.max(herbEggTimeGraph);
        maxEggTime=(maxSpeed<34)?34:maxEggTime;
      }
      float maxkidEnergy=1;
      if(herbSpeedGraph.size()>0){
        maxkidEnergy=Collections.max(herbKidEnergyGraph);
        maxkidEnergy=(maxSpeed<34)?34:maxkidEnergy;
      }
      float maxSize=1;
      if(herbSpeedGraph.size()>0){
        maxSize=Collections.max(herbSizeGraph);
        maxSize=(maxSpeed<34)?34:maxSize;
      }
      float maxEnergy=1;
      if(herbSpeedGraph.size()>0){
        maxEnergy=Collections.max(herbEnergyGraph);
        maxEnergy=(maxSpeed<34)?34:maxEnergy;
      }
      //println(maxSpeed);
      float maxVal=max(maxSpeed, maxKids, max(maxParts, maxEggTime, max(maxkidEnergy, maxSize, maxEnergy)));
      stroke(255,0,0);
      for(int i=1;i<herbSpeedGraph.size();i++){
        line((i-1),height-((herbSpeedGraph.get(i-1))*(34/maxVal))*16,(i),height-((herbSpeedGraph.get(i))*(34/maxVal))*16);
      }
      stroke(0,255,0);
      for(int i=1;i<herbKidsGraph.size();i++){
        line((i-1),height-((herbKidsGraph.get(i-1))*(34/maxVal))*16,(i),height-((herbKidsGraph.get(i))*(34/maxVal))*16);
      }
      stroke(0,0,255);
      for(int i=1;i<herbPartsGraph.size();i++){
        line((i-1),height-((herbPartsGraph.get(i-1))*(34/maxVal))*16,(i),height-((herbPartsGraph.get(i))*(34/maxVal))*16);
      }
      stroke(255,255,0);
      for(int i=1;i<herbEggTimeGraph.size();i++){
        line((i-1),height-((herbEggTimeGraph.get(i-1))*(34/maxVal))*16,(i),height-((herbEggTimeGraph.get(i))*(34/maxVal))*16);
      }
      stroke(255,0,255);
      for(int i=1;i<herbKidEnergyGraph.size();i++){
        line((i-1),height-((herbKidEnergyGraph.get(i-1))*(34/maxVal))*16,(i),height-((herbKidEnergyGraph.get(i))*(34/maxVal))*16);
      }
      stroke(255,255,255);
      for(int i=1;i<herbSizeGraph.size();i++){
        line((i-1),height-((herbSizeGraph.get(i-1))*(34/maxVal))*16,(i),height-((herbSizeGraph.get(i))*(34/maxVal))*16);
      }
      stroke(128);
      for(int i=1;i<herbEnergyGraph.size();i++){
        line((i-1),height-((herbEnergyGraph.get(i-1))*(34/maxVal))*16,(i),height-((herbEnergyGraph.get(i))*(34/maxVal))*16);
      }
      textSize(32);
      fill(255);
      text(0,0,height-32);
      text((int)maxVal,0,32);
      if(populationGraph.size()>0){
        String hover1="";
        String hover2="";
        if(abs(mouseY-(height-((herbSpeedGraph.get(herbSpeedGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + herbSpeedGraph.get(herbSpeedGraph.size()-1);
          hover2 = "Meaning: Avg. Speed";
        }
        if(abs(mouseY-(height-((herbKidsGraph.get(herbKidsGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + herbKidsGraph.get(herbKidsGraph.size()-1);
          hover2 = "Meaning: Avg. Kids";
        }
        if(abs(mouseY-(height-((herbPartsGraph.get(herbPartsGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + herbPartsGraph.get(herbPartsGraph.size()-1);
          hover2 = "Meaning: Avg. Carnivore Parts";
        }
        if(abs(mouseY-(height-((herbEggTimeGraph.get(herbEggTimeGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + herbEggTimeGraph.get(herbEggTimeGraph.size()-1);
          hover2 = "Meaning: Avg. Egg Time";
        }
        if(abs(mouseY-(height-((herbKidEnergyGraph.get(herbKidEnergyGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + herbKidEnergyGraph.get(herbKidEnergyGraph.size()-1);
          hover2 = "Meaning: Avg. Kid Energy";
        }
        if(abs(mouseY-(height-((herbSizeGraph.get(herbSizeGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + herbSizeGraph.get(herbSizeGraph.size()-1);
          hover2 = "Meaning: Avg. Size";
        }
        if(abs(mouseY-(height-((herbEnergyGraph.get(herbEnergyGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + herbEnergyGraph.get(herbEnergyGraph.size()-1);
          hover2 = "Meaning: Avg. Energy";
        }
        if(hover1!=""){
          text(hover1, 0, height/2-16);
          text(hover2, 0, height/2+16);
        }
      }
      ready = false;
    }
  }
}
