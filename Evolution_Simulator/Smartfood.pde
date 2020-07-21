class Smartfood {
  float x, y;
  boolean eaten;
  boolean selected;
  float sfColor = 128;
  
  public Smartfood(float x, float y, float sfColor) {
    this.y = y;
    this.x = x;
    this.sfColor = sfColor;
  }
  public void render(){
    if(selected){
      strokeWeight(2);
      stroke(255,0,0);
      fill(sfColor, sfColor, 255);
      ellipse(x, y, 7.5, 7.5);
    } else {
      stroke(0);
      strokeWeight(0.5);
    }
    
    if(!eaten){
      fill(sfColor, sfColor, 255);
      ellipse(x, y, 7.5, 7.5);
      currentSmartfood++;
    }else if(renderEaten){
      fill(sfColor, sfColor, 255, 64);
      ellipse(x, y, 7.5, 7.5);
    }
    
  }
}
