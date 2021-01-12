Brick[][] bricks = new Brick[8][10];
Ball ball = new Ball();
Paddle paddle = new Paddle();
Points point = new Points();
int count = 0;
int pauseCount = 0;
int lossCount = 0;
int unactiveBricks = 0;
int brickCount;
boolean lose = false;

void setup() {
  size(1000, 700);
  frameRate(60);
  //initializes bricks
  point.buildBricks(bricks);
  //brick count
  for (int row=0; row<8; row++) { //8 rows
    for (int col=0; col<10; col++) { //10 columns
      brickCount++;
    }
  }
}
void draw() {
  background(255);
  //draw bricks
  for (Brick[] b : bricks) {
    for (Brick a : b) {
      a.display();
    }
  }
  //draw ball
  ball.display();
  //move ball
  if (point.active) {
    ball.move();
  } else {
    ball.ballOnPaddle();
    if (lossCount==0 && point.level==1) {
      fill(50);
      textSize(12);
      text("By Golden Wo", width-83, height-4);
      textSize(40);
      text("Click to Start", width/2-width/8, (height/2)+25);
      textSize(18);
      text("Press 'P ' to Pause", width/2-73, (height/2)+55);
    }
    if (point.level > 1 && lose == false) {
      fill(50);
      textSize(40);
      text("Level " + point.level + " - Click to Begin", width/2-width/4+18, height/2+25);
    }
  }
  //ball bounce paddle
  if (ball.hitPaddle(paddle)) {
    ball.bouncePaddle(paddle);
  }
  //draw paddle
  paddle.display();
  //display pause
  if (pauseCount%2!=0 && point.active) {
    fill(50);
    textSize(40);
    text("Paused", width/2-width/8+45, height/2+40);
  }
  //display gameover
  if (ball.offScreen()) {
    lossCount++;
    point.active=false;
    lose=true;
  }
  if (lossCount > 0) {
    fill(50);
    textSize(40);
    text("GAME OVER", width/2-width/8, (height/2));
    textSize(18);
    text("Click To Restart", width/2-80, (height/2)+55);
  }
  //display Points class
  point.displayNumbers();
  //determine brick collision
  for (int row=0; row<8; row++) { //8 rows
    for (int col=0; col<10; col++) { //10 columns
      if (bricks[row][col].impact(ball)) {
        if (bricks[row][col].active) {
          bricks[row][col].deactivate();
          if (!ball.isSuper) {
            ball.bounceBrick(bricks[row][col]);
          }
          point.addPoints(10);
        }
      }
    }
  }
  //powerups
  for (int row=0; row<8; row++) { //8 rows
    for (int col=0; col<10; col++) { //10 columns
      bricks[row][col].powerDisplay();
      bricks[row][col].power(paddle, ball);
    }
  }
  if (point.points == point.level*brickCount*10) {
    point.incrementLevel();
    point.active=false;
    resetGamePower();
    lose=false;
  }
}
void mouseClicked() {
  if (ball.ballIsInStartPos()) {
    if (count>0) {
      point.buildBricks(bricks);
    }
    resetGamePower();
    if (lose){
    point.points=0;
    point.level=1;
    }
    ball.moveUp();
    point.active=true;
    count++;
    lossCount=0;
    pauseCount=0;
  }
}
void keyPressed() {
  if (keyCode == 'P') {
    ball.pause();
    for (int row=0; row<8; row++) { //8 rows
      for (int col=0; col<10; col++) { //10 columns
        bricks[row][col].powerPause();
      }
    }
    pauseCount++;
  }
  if (keyCode == 'A') {
    while (point.points < brickCount*10*point.level) {
      point.addPoints(10);
    }
  }
}
public void resetGamePower() {
  paddle.paddleWidth=paddle.oPW;
  if (ball.superFast) {
    ball.xspeed /= 2;
    ball.yspeed /= 2;
    ball.superFast = false;
  }
  ball.isSuper = false;
  ball.ballColor = ball.preBallColor;
  paddle.paddleColor = paddle.prePaddleColor;
}