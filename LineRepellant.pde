public class LineRepellant implements Repellant {
  private PVector start;
  private PVector end;
  private int period;
  private float magnitude;
  
  LineRepellant(float x1, float y1, float x2, float y2, float mag) {
    this.start = new PVector(x1, y1);
    this.end = new PVector(x2, y2);
    this.period = 200;
    this.magnitude = mag;
  }

  PVector getLocation() {
    int cycleFrame = frameCount % period;
    float n = norm(cycleFrame, 0, period);
    n = n * n;
    float x = lerp(this.start.x, this.end.x, n);
    float y = lerp(this.start.y, this.end.y, n);
    return new PVector(x, y);
  }
  
  float mag() {
    return this.magnitude;
  }
}
