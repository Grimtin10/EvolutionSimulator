class Lightningfood{
  float x, y;
  boolean eaten;
  
  public Lightningfood(float x, float y){
    this.x = x;
    this.y = y;
  }
  public void render(){
    if(!eaten){
      stroke(0);
      fill(255, 255, 0);
      ellipse(x, y, 5, 5);
      currentLightningfood++;
    }else if(renderEaten){
      stroke(0);
      fill(0, 255, 0, 64);
      ellipse(x, y, 5, 5);
    }
  }
}
