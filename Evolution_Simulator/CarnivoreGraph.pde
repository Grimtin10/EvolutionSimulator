import java.util.*;

public class CarnivoreGraph extends PApplet {
  String state = "pop";
  
  public void settings() {
    size(500, 500);
  }
  public void draw() {
    if(ready){
      background(0);
      float maxSpeed=1;
      if(carnSpeedGraph.size()>0){
        maxSpeed=Collections.max(carnSpeedGraph);
        maxSpeed=(maxSpeed<34)?34:maxSpeed;
      }
      float maxKids=1;
      if(carnSpeedGraph.size()>0){
        maxKids=Collections.max(carnKidsGraph);
        maxKids=(maxSpeed<34)?34:maxKids;
      }
      float maxEggTime=1;
      if(carnSpeedGraph.size()>0){
        maxEggTime=Collections.max(carnEggTimeGraph);
        maxEggTime=(maxSpeed<34)?34:maxEggTime;
      }
      float maxKidEn=1;
      if(carnSpeedGraph.size()>0){
        maxKidEn=Collections.max(carnKidEnGraph);
        maxKidEn=(maxSpeed<34)?34:maxKidEn;
      }
      float maxSize=1;
      if(carnSpeedGraph.size()>0){
        maxSize=Collections.max(carnSizeGraph);
        maxSize=(maxSpeed<34)?34:maxSize;
      }
      float maxEnergy=1;
      if(carnSpeedGraph.size()>0){
        maxEnergy=Collections.max(carnEnergyGraph);
        maxEnergy=(maxSpeed<34)?34:maxEnergy;
      }
      //println(maxSpeed);
      float maxVal=max(maxSpeed, maxKids, max(maxEggTime, max(maxKidEn, maxSize, maxEnergy)));
      stroke(255,0,0);
      for(int i=1;i<carnSpeedGraph.size();i++){
        line((i-1),height-((carnSpeedGraph.get(i-1))*(34/maxVal))*16,(i),height-((carnSpeedGraph.get(i))*(34/maxVal))*16);
      }
      stroke(0,255,0);
      for(int i=1;i<carnKidsGraph.size();i++){
        line((i-1),height-((carnKidsGraph.get(i-1))*(34/maxVal))*16,(i),height-((carnKidsGraph.get(i))*(34/maxVal))*16);
      }
      stroke(0,0,255);
      for(int i=1;i<carnEggTimeGraph.size();i++){
        line((i-1),height-((carnEggTimeGraph.get(i-1))*(34/maxVal))*16,(i),height-((carnEggTimeGraph.get(i))*(34/maxVal))*16);
      }
      stroke(255,255,0);
      for(int i=1;i<carnKidEnGraph.size();i++){
        line((i-1),height-((carnKidEnGraph.get(i-1))*(34/maxVal))*16,(i),height-((carnKidEnGraph.get(i))*(34/maxVal))*16);
      }
      stroke(255,0,255);
      for(int i=1;i<carnSizeGraph.size();i++){
        line((i-1),height-((carnSizeGraph.get(i-1))*(34/maxVal))*16,(i),height-((carnSizeGraph.get(i))*(34/maxVal))*16);
      }
      stroke(128);
      for(int i=1;i<carnEnergyGraph.size();i++){
        line((i-1),height-((carnEnergyGraph.get(i-1))*(34/maxVal))*16,(i),height-((carnEnergyGraph.get(i))*(34/maxVal))*16);
      }
      textSize(32);
      fill(255);
      text(0,0,height-32);
      text((int)maxVal,0,32);
      if(carnSpeedGraph.size()>0){
        String hover1="";
        String hover2="";
        if(abs(mouseY-(height-((carnSpeedGraph.get(carnSpeedGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + carnSpeedGraph.get(carnSpeedGraph.size()-1);
          hover2 = "Meaning: Avg. Speed";
        }
        if(abs(mouseY-(height-((carnKidsGraph.get(carnKidsGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + carnKidsGraph.get(carnKidsGraph.size()-1);
          hover2 = "Meaning: Avg. Kids";
        }
        if(abs(mouseY-(height-((carnEggTimeGraph.get(carnEggTimeGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + carnEggTimeGraph.get(carnEggTimeGraph.size()-1);
          hover2 = "Meaning: Avg. Egg Time";
        }
        if(abs(mouseY-(height-((carnKidEnGraph.get(carnKidEnGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + carnKidEnGraph.get(carnKidEnGraph.size()-1);
          hover2 = "Meaning: Avg. Kid Energy";
        }
        if(abs(mouseY-(height-((carnSizeGraph.get(carnSizeGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + carnSizeGraph.get(carnSizeGraph.size()-1);
          hover2 = "Meaning: Avg. Size";
        }
        if(abs(mouseY-(height-((carnEnergyGraph.get(carnEnergyGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + carnEnergyGraph.get(carnEnergyGraph.size()-1);
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
