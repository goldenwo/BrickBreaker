public class Brick implements Powerup {
  int r, g, b;
  private float x, y;
  int power;
  boolean powerup=false;
  float wide=width/10;
  float tall=20;
  color c;
  boolean active=false;
  float powerupYSpeed;
  float powerY;
  color powerColor;
  boolean hadPower;
  boolean hasReceived=false;

  public Brick() {
    r=int(random(30, 250));
    g=int(random(30, 240));
    b=int(random(30, 230));
    c=color(r, g, b);
    active=true;
    power = int(random(0, 3)); //powers from 0-2
    if ((int(random(0, 11))==0))
      powerup=true;
    powerupYSpeed = 5;
    if (power==0) {
      powerColor = color(255, 0, 0);
    }
    if (power==1) {
      powerColor = color(0, 255, 0);
    }
    if (power==2) {
      powerColor = color(0, 0, 255);
    }
    powerY=y;
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public void setX(float a) {
    x=a;
  }
  public void setY(float b) {
    y=b;
  }
  public void display() {
    rectMode(CENTER);
    fill(c);
    if (powerup) {
      // fill(255); //test powered bricks
      rect(x, y, wide, tall);
    } else {
      rect(x, y, wide, tall);
    }
  }
  public boolean impact(Ball b) {
    if (/* left side */(brickEdge("left") <= b.edge("right")) && /* right side */(b.edge("left") <= brickEdge("right"))) {
      if (/* top side */(brickEdge("top") <= b.edge("bottom")) && /* bottom side */ (b.edge("top") <= brickEdge("bottom"))) {
        return true;
      }
    }
    return false;
  }
  public void deactivate() {
    active=false;
    c=color(255);
  }
  public float[] center() {
    float[] center = {x, y};
    return center;
  }
  public float brickEdge(String edge) {
    float brickEdge=0;
    if (edge == "top") {
      brickEdge = y - tall/2;
    } else if (edge == "bottom") {
      brickEdge = y + tall/2;
    } else if (edge == "left") {
      brickEdge = x - wide/2;
    } else if (edge == "right") {
      brickEdge = x + wide/2;
    }
    return brickEdge;
  }
  public void powerDisplay() {
    if (active == false && powerup==true) {
      if (power==0) {
        fill(powerColor);
        powerY+=powerupYSpeed;
        ellipse(x, powerY, 15, 15);
      }
      if (power==1) {
        fill(powerColor);
        powerY+=powerupYSpeed;
        ellipse(x, powerY, 15, 15);
      }
      if (power==2) {
        fill(powerColor);
        powerY+=powerupYSpeed;
        ellipse(x, powerY, 15, 15);
      }
    }
  }
  public void power(Paddle p, Ball b) {
    if (active == false && powerup==true) {
      if (x <= p.edge("right") && x >= p.edge("left")) {
        if (powerY <= p.getY()+p.paddleHeight/2 && powerY >= p.edge("top")) {
          hasReceived=true;
          if (power==0) { //double ball speed
            resetPower(p, b);
            b.xspeed *= 2;
            b.yspeed *= 2;
            powerColor = color(255);
            b.ballColor = color(255, 0, 0);
            hadPower=true;
            b.superFast=true;
          }
          if (power==1) { //double paddle width
            resetPower(p, b);
            p.paddleWidth *= 2;
            powerColor = color(255);
            p.paddleColor = color(0, 255, 0);
            hadPower=true;
          }
          if (power==2) { //make ball shoot through brick
            resetPower(p, b);
            b.isSuper=true;
            powerColor = color(255);
            b.ballColor = color(0, 0, 255);
            hadPower=true;
          }
        }
      }
    }
  }
  public void resetPower(Paddle p, Ball b) {
    p.paddleWidth=p.oPW;
    if (ball.superFast) {
      ball.xspeed /= 2;
      ball.yspeed /= 2;
      ball.superFast = false;
    }
    ball.isSuper = false;
    b.ballColor = b.preBallColor;
    p.paddleColor = p.prePaddleColor;
    hadPower=false;
  }
  public void powerPause() {
    if (powerupYSpeed==0) {
      powerupYSpeed = 5;
    } else {
      powerupYSpeed = 0;
    }
  }
}