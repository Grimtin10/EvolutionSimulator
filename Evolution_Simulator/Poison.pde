class Poison {
  float x, y;
  boolean eaten;
  
  public Poison(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public void render(){
    if(!eaten){
      stroke(0);
      fill(255, 0, 0);
      ellipse(x, y, 3.5, 3.5);
      currentPoison++;
    }else if(renderEaten){
      stroke(0);
      fill(255, 0, 0, 64);
      ellipse(x, y, 3.5, 3.5);
    }
  }
}
