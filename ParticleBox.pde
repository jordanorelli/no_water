public class ParticleBox {
  private ArrayList<Particle> particles;
  private PVector origin;
  
  ParticleBox(PApplet app, float x, float y, int columns, int rows, float size) {
    this.particles = new ArrayList<Particle>();
    this.origin = new PVector(x, y);
    for (int xx = 0; xx < columns; xx++) {
      for (int yy = 0; yy < rows; yy++) {
        this.particles.add(new Particle(app, this.origin.x + xx * size, this.origin.y + yy * size, size));
      }
    }
  }
  
  public void registerRepellant(Repellant r) {
    for (Particle p : this.particles) {
      p.registerRepellant(r);
    }
  }
}
