public class Points {
  int points;
  int level;
  boolean active;
  float row, col;

  public Points() {
    points =0;
    level = 1;
    active = false;
  }
  public void buildBricks(Brick[][] bricks) {
    int newX=50;
    int newY=100;
    for (int row=0; row<8; row++) { //8 rows
      for (int col=0; col<10; col++) { //10 columns
        bricks[row][col]=new Brick();
        bricks[row][col].setX(newX);
        bricks[row][col].setY(newY);
        newX+=width/10;
      }
      newX=50;
      newY+=20;
    }
  }
  public void addPoints(int pointsEarned) {
    points+=pointsEarned;
  }
  public void incrementLevel() {
    level++;
  }
  public void displayNumbers() {
    fill(0);
    textSize(20);
    text("Level: " + level, 15, height-38);
    text("Points: " + points, 15, height-18);
  }
  public boolean hadPower(Brick[][] b) {
    for (int row=0; row<8; row++) { //8 rows
      for (int col=0; col<10; col++) { //10 columns
        if (b[row][col].hadPower) {
          return true;
        }
      }
    }
    return false;
  }
}