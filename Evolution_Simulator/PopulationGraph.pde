import java.util.*;

public class PopulationGraph extends PApplet {
  public void settings() {
    size(500, 500);
  }
  public void draw() {
    if(ready){
      background(0);
      stroke(255);
      float maxPop=1;
      if(populationGraph.size()>0){
        //println(populationGraph);
        //println(Collections.max(populationGraph));
        maxPop=Collections.max(populationGraph);
        maxPop=(maxPop<125)?125:maxPop;
      }
      float maxAge=1;
      if(ageGraph.size()>0){
        maxAge=Collections.max(ageGraph);
        maxAge=(maxAge<125)?125:maxAge;
      }
      float maxHerb=1;
      if(herbGraph.size()>0){
        maxHerb=Collections.max(herbGraph);
        maxHerb=(maxHerb<125)?125:maxHerb;
      }
      float maxCarn=1;
      if(carnGraph.size()>0){
        maxCarn=Collections.max(carnGraph);
        maxCarn=(maxCarn<125)?125:maxCarn;
      }
      float maxSmartfoodcolor=1;
      if(smartfoodColorGraph.size()>0){
        maxSmartfoodcolor=Collections.max(smartfoodColorGraph);
        maxSmartfoodcolor=(maxSmartfoodcolor<125)?125:maxSmartfoodcolor;
      }
      float maxSfcolor=1;
      if(sfColorGraph.size()>0){
        maxSfcolor=Collections.max(sfColorGraph);
        maxSfcolor=(maxSfcolor<125)?125:maxSfcolor;
      }
      float maxVal=max(maxPop,maxAge,max(maxHerb,maxCarn,max(maxSmartfoodcolor, maxSfcolor)));
      for(int i=1;i<populationGraph.size();i++){
        line((i-1),height-((populationGraph.get(i-1))*(125/maxVal))*4,(i),height-((populationGraph.get(i))*(125/maxVal))*4);
      }
      stroke(128);
      for(int i=1;i<ageGraph.size();i++){
        line((i-1),height-((ageGraph.get(i-1))*(125/maxVal))*4,(i),height-((ageGraph.get(i))*(125/maxVal))*4);
      }
      stroke(0,255,0);
      for(int i=1;i<herbGraph.size();i++){
        line((i-1),height-((herbGraph.get(i-1))*(125/maxVal))*4,(i),height-((herbGraph.get(i))*(125/maxVal))*4);
      }
      stroke(255,0,0);
      for(int i=1;i<carnGraph.size();i++){
        line((i-1),height-((carnGraph.get(i-1))*(125/maxVal))*4,(i),height-((carnGraph.get(i))*(125/maxVal))*4);
      }
      stroke(128, 128, 255);
      for(int i=1;i<smartfoodColorGraph.size();i++){
        line((i-1),height-((smartfoodColorGraph.get(i-1))*(125/maxVal))*4,(i),height-((smartfoodColorGraph.get(i))*(125/maxVal))*4);
      }
      stroke(64, 64, 255);
      for(int i=1;i<sfColorGraph.size();i++){
        line((i-1),height-((sfColorGraph.get(i-1))*(125/maxVal))*4,(i),height-((sfColorGraph.get(i))*(125/maxVal))*4);
      }
      textSize(32);
      fill(255);
      text(0,0,height-32);
      text((int)maxVal,0,32);
      if(populationGraph.size()>0){
        String hover1="";
        String hover2="";
        if(abs(mouseY-(height-((populationGraph.get(populationGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + populationGraph.get(populationGraph.size()-1);
          hover2 = "Meaning: Population";
        }
        if(abs(mouseY-(height-((ageGraph.get(ageGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + ageGraph.get(ageGraph.size()-1);
          hover2 = "Meaning: Average Age";
        }
        if(abs(mouseY-(height-((herbGraph.get(herbGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + herbGraph.get(herbGraph.size()-1);
          hover2 = "Meaning: Herbivore Population";
        }
        if(abs(mouseY-(height-((carnGraph.get(carnGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(32);
          hover1 = "Value: " + carnGraph.get(carnGraph.size()-1);
          hover2 = "Meaning: Carnivore Population";
        }
        if(abs(mouseY-(height-((smartfoodColorGraph.get(smartfoodColorGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(29);
          hover1 = "Value: " + smartfoodColorGraph.get(smartfoodColorGraph.size()-1);
          hover2 = "Meaning: Average Smartfood Color";
        }
        if(abs(mouseY-(height-((sfColorGraph.get(sfColorGraph.size()-1))*(125/maxVal))*4))<25){
          textSize(27);
          hover1 = "Value: " + sfColorGraph.get(sfColorGraph.size()-1);
          hover2 = "Meaning: Average Prefered Smartfood";
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
