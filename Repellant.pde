public class Repellant {
  private PVector origin;

  Repellant(PApplet app) {
    this.origin = new PVector(-200, -299);
    app.registerDraw(this);
  }
  
  void draw() {
    if (!showRepellants) {
      return;
    }
    pushMatrix();
    translate(this.origin.x, this.origin.y);

    ellipseMode(CENTER);
    noStroke();
    fill(255, 0, 0);
    
    ellipse(0, 0, 20, 20);

    popMatrix();
  }
  
  void setLocation(float x, float y) {
    this.origin.x = x;
    this.origin.y = y;
  }
  
  PVector getLocation() {
    return this.origin;
  }
}
