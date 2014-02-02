public class MouseRepellant implements Repellant {
  private PVector origin;
  private float magnitude;
  
  MouseRepellant(PApplet app) {
    this.origin = new PVector(mouseX, mouseY);
    this.magnitude = 10.0;
  }
  
  PVector getLocation() {
    this.origin.x = mouseX;
    this.origin.y = mouseY;
    return this.origin;
  }
  
  float mag() {
    return this.magnitude;
  }
  
  void incMag(float delta) {
    this.magnitude += delta;
  }
}
