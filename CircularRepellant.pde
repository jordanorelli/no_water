public class CircularRepellant implements Repellant {
  private PVector origin;
  private float size;
  private int period;
  
  CircularRepellant(float x, float y, float size, int period) {
    this.origin = new PVector(x, y);
    this.size = size;
    this.period = period;
  }
  
  PVector getLocation() {
    int sequenceFrame = frameCount % this.period;
    float n = norm(sequenceFrame, 0, this.period);
    float x = this.origin.x + this.size * sin(TWO_PI * n);
    float y = this.origin.y + this.size * cos(TWO_PI * n);
    return new PVector(x, y);
  }
  
  float mag() {
    return 7.0;
  }
}
