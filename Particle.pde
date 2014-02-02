public class Particle {
  private PVector anchor;
  private PVector origin;
  private PVector velocity;
  private float size;
  private ArrayList<Repellant> repellants;
  private float mass;

  Particle (PApplet app, float x, float y, float size) {
    this.anchor = new PVector(x, y);
    this.origin = new PVector(x, y);
    this.velocity = new PVector(0, 0);
    this.size = size;
    this.repellants = new ArrayList<Repellant>();
    this.mass = 10;
    app.registerDraw(this);
    app.registerPre(this);
  }
  
  PVector forces() {
    PVector rf = this.repellantForces();
    PVector af = this.anchorForce();
    return PVector.add(rf, af);
  }
  
  PVector repellantForces() {
    PVector f = new PVector(0, 0);
    for (Repellant r : this.repellants) {
      float dist = PVector.dist(this.origin, r.getLocation());
      if (dist > 100) {
        continue;
      }
      float n = norm(dist, 100, 0);
      PVector diff = PVector.sub(this.origin, r.getLocation());
      diff.normalize();
      diff.mult(n*n*10.0);
      f.add(diff);
    }
    return f;
  }
  
  PVector anchorForce() {
    float dist = PVector.dist(this.origin, this.anchor);
    float n = norm(dist, 0, 100);
    PVector diff = PVector.sub(this.origin, this.anchor);
    diff.normalize();
    diff.mult(-n*n*20.0);
    if (diff.mag() < 1.0) {
      diff.setMag(1.0);
    }
    return diff;
  }
  
  void drawForces() {
    if (!showForces) {
      return;
    }
    
    strokeWeight(1);
    stroke(255, 0, 0);

    PVector rf = this.repellantForces();
    line(0, 0, 50.0*rf.x, 50.0*rf.y);
    
    PVector af = this.anchorForce();
    stroke(0, 255, 0);
    line(0, 0, 50.0*af.x, 50.0*af.y);
  }
  
  void pre() {
    this.velocity.mult(0.9);
    PVector f = this.forces();
    f.div(this.mass);
    this.velocity.add(f);
    this.origin.add(this.velocity);
    if (PVector.dist(this.origin, this.anchor) < 1.0) {
      this.origin.x = this.anchor.x;
      this.origin.y = this.anchor.y;
    }
  }
  
  void draw() {
    if (logPosition) {
      println(this.origin);
    }
    pushMatrix();
    translate(this.origin.x, this.origin.y);
    
    if (wireframe) {
      stroke(0);
      strokeWeight(1);
      noFill();
    } else {
      noStroke();
      fill(0);
    }

    rectMode(RADIUS);
    rect(0, 0, this.size, this.size);

    this.drawForces();
    popMatrix();
  }
  
  void registerRepellant(Repellant r) {
    this.repellants.add(r);
  }
}

