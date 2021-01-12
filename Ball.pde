public class Ball {
  private float ballX, ballY;
  float ballDiameter;
  float xspeed, yspeed;
  float preXSpeed, preYSpeed;
  final float MAXSPEED = 10;
  boolean isSuper=false;
  color ballColor;
  color preBallColor=100;
  boolean superFast=false;

  public Ball() {
    ballX=500;
    ballY=600;
    ballDiameter=15;
    xspeed = 0;
    yspeed = 0;
    ballColor = color(100);
  }
  public void display() {
    ellipseMode(CENTER);
    stroke(201, 201, 255);
    fill(ballColor);
    ellipse(ballX, ballY, ballDiameter, ballDiameter);
  }
  public void move() {
    if (edge("top")<=0) {
      yspeed *= -1;
    }
    if (edge("left") <= 0 || edge("right") >= width) {
      xspeed *= -1;
      if (edge("left")==0) {
        xspeed=1;
      }
    }
    ballX+=xspeed;
    ballY+=yspeed;
  }
  public float edge(String edge) {
    float ballEdge=0;
    if (edge == "top") {
      ballEdge = ballY - ballDiameter/2;
    } else if (edge == "bottom") {
      ballEdge = ballY + ballDiameter/2;
    } else if (edge == "left") {
      ballEdge = ballX - ballDiameter/2;
    } else if (edge == "right") {
      ballEdge = ballX + ballDiameter/2;
    }
    return ballEdge;
  }
  public void pause() {
    if (xspeed == 0 && yspeed == 0) { //unpause
      xspeed = preXSpeed;
      yspeed = preYSpeed;
    } else { //pause
      preXSpeed = xspeed;
      preYSpeed = yspeed;
      xspeed=0;
      yspeed=0;
    }
  }
  public boolean ballIsInStartPos() {
    if (ballY == 600 && xspeed == 0 && yspeed == 0) {
      return true;
    } else {
      return false;
    }
  }
  public boolean offScreen() {
    if (ballY > height) {
      return true;
    } else {
      return false;
    }
  }
  public void ballOnPaddle() {
    xspeed=0;
    yspeed=0;
    ballX = constrain(mouseX, paddle.paddleWidth/2, width - paddle.paddleWidth/2);
    ballY = 600;
  }
  public boolean hitPaddle(Paddle p) {
    if ((ballX+ballDiameter/2 > p.edge("left") && ballX-ballDiameter < p.edge("right"))) {
      if (superFast) {
        if ((edge("bottom") > p.edge("top")-10) && /* bottom */ (ballY+ballDiameter/2 < p.getY()+p.paddleHeight/2) && yspeed > 0) {
          return true;
        }
      } else if (edge("bottom") > p.edge("top") && /* bottom */ (ballY+ballDiameter/2 < p.getY()+p.paddleHeight/2) && yspeed > 0) {
        return true;
      }
    }
    return false;
  }
  public void moveUp() {
    xspeed=-1;
    yspeed=-5;
  }
  public void bouncePaddle(Paddle p) {
    float bouncePoint = dist(ballX, p.getY(), p.getX(), p.getY());
    if (ballX <p.getX()) {
      xspeed = (bouncePoint * 0.05)*-1;
    } else {
      xspeed = bouncePoint *0.05;
    }
    yspeed *= -1;
  }
  public void bounceBrick(Brick b) {
    float[] center = b.center();
    float bounceDistance = dist(center[0], center[1], ballX, ballY);
    if (bounceDistance >= b.wide/2 + ballDiameter/2) {
      xspeed *= -1;
    } else {
      yspeed *= -1;
    }
  }
  public float getX() {
    return ballX;
  }
  public float getY() {
    return ballY;
  }
  public void setX(float x) {
    ballX=x;
  }
  public void setY(float y) {
    ballY=y;
  }
}