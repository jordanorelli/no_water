import java.util.Iterator;

public class ParticleBox implements Iterable<Particle> {
  private ArrayList<Particle> particles;
  private ArrayList<Repellant> repellants;
  private PVector origin;
  
  ParticleBox(PApplet app, float x, float y, int columns, int rows, float size) {
    this.particles = new ArrayList<Particle>();
    this.repellants = new ArrayList<Repellant>();
    this.origin = new PVector(x, y);
    for (int xx = 0; xx < columns; xx++) {
      for (int yy = 0; yy < rows; yy++) {
        this.particles.add(new Particle(app, this.repellants, this.origin.x + xx * size, this.origin.y + yy * size, size));
      }
    }
  }
  
  void draw() {
    for (Particle p : this) {
      p.draw();
    }
    if (showRepellants) {
      this.drawRepellants(); 
    }
  }
  
  void drawRepellants() {
    for (Repellant r : this.repellants) {
      PVector l = r.getLocation();
      ellipseMode(CENTER);
      fill(255, 0, 0);
      noStroke();
      ellipse(l.x, l.y, min(r.mag(), 50.0), min(r.mag(), 50.0));
    }
  }
  
  public Iterator<Particle> iterator() {
    return this.particles.iterator();
  }
  
  public void registerRepellant(Repellant r) {
    this.repellants.add(r);
  }
}
