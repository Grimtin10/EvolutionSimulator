class Food{
  float x, y;
  boolean eaten;
  
  public Food(float x, float y){
    this.x = x;
    this.y = y;
  }
  public void render(){
    if(!eaten){
      stroke(0);
      fill(0, 255, 0);
      ellipse(x, y, 7.5, 7.5);
      currentFood++;
    }else if(renderEaten){
      stroke(0);
      fill(0, 255, 0, 64);
      ellipse(x, y, 7.5, 7.5);
    }
  }
}
