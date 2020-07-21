class Superfood {
  float x, y;
  boolean eaten;
  
  public Superfood(float x, float y){
    this.x = x;
    this.y = y;
  }
  public void render(){
    if(!eaten){
      stroke(0);
      fill(0, 255, 255);
      ellipse(x, y, 5, 5);
      currentSuperfood++;
    }else if(renderEaten){
      stroke(0);
      fill(0, 255, 255, 64);
      ellipse(x, y, 5, 5);
    }
  }
}
