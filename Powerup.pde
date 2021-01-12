public interface Powerup{
  public abstract void powerDisplay();
  public abstract void power(Paddle p, Ball b);
  public abstract void resetPower(Paddle p, Ball b);
}