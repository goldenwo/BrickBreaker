public class Paddle {
  private float x, y;
  float paddleWidth, paddleHeight;
  boolean hasPowerup;
  color paddleColor;
  float xPrevious;
  float oPW;
  color prePaddleColor=50;
  
  public Paddle() {
    x=500;
    y=612;
    xPrevious=x;
    paddleWidth=80;
    paddleHeight=7;
    paddleColor=50;
    oPW = 80;
  }
  public void display() {
    x = constrain(mouseX, paddleWidth/2, width - paddleWidth/2);
    rectMode(CENTER);
    noStroke();
    fill(paddleColor);
    rect(x, y, paddleWidth, paddleHeight);
  }
  public float edge(String edge) {
    if (edge == "left") {
      return (x - (paddleWidth/2));
    } else if (edge == "right") {
      return (x + (paddleWidth/2));
    } else if (edge == "top") {
      return (y - paddleHeight/2);
    } else {
      return 0;
    }
  }
  public float getX(){
     return x; 
  }
  public float getY(){
     return y; 
  }
  public void setX(float newX){
     x=newX;
  }
  public void setY(float newY){
     y=newY; 
  }
}