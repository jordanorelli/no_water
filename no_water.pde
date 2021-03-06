import controlP5.*;

ControlP5 cp5;
PApplet app = this;
ParticleBox p;
MouseRepellant r;
boolean debug = false;
boolean showGuides = false;
boolean showRepellants = false;
boolean showForces = false;
boolean logPosition = false;
boolean wireframe = false;

int startRecordFrame = -1;
int period = 120;

void setup() {
  size(500, 500);
  smooth();
  p = new ParticleBox(this, 100, 100, 100, 100, 3);
  r = new MouseRepellant(this);
  p.registerRepellant(r);
  setupControls();
}

void setupControls() {
  cp5 = new ControlP5(this);  
  cp5.setColorCaptionLabel(0);
  cp5.setFont(createFont("Helvetica", 12, true));
  Toggle t = cp5.addToggle("showGuides");
  t.setPosition(10, 10);
  t.captionLabel().toUpperCase(false).setText("show guides");
  
  t = cp5.addToggle("showRepellants");
  t.setPosition(10, 80);
  t.captionLabel().toUpperCase(false).setText("show repellants");
  
  t = cp5.addToggle("showForces");
  t.setPosition(10, 150);
  t.captionLabel().toUpperCase(false).setText("show forces");
  
  t = cp5.addToggle("logPosition");
  t.setPosition(10, 210);
  t.captionLabel().toUpperCase(false).setText("log position");
  
  t = cp5.addToggle("wireframe");
  t.setPosition(10, 280);
  t.captionLabel().toUpperCase(false).setText("wireframes");
  
  Button b = cp5.addButton("recordFramesClick");
  b.setPosition(10, 350);
  b.captionLabel().toUpperCase(false).setText("record");
  
  cp5.loadProperties("config");
  cp5.hide();
}

void draw() {
  background(255);
  p.draw();
  guides();
  export();
}

void export() {
  if (startRecordFrame == -1) {
    return;
  }
  int frame = frameCount - startRecordFrame;
  if (frame >= period) {
    startRecordFrame = -1;
    return;
  }
  String fname = nf(frame, 3) + ".png";
  println(fname);
  save(fname);
}

void guides() {
  if (!showGuides) {
    return;
  }
  stroke(255, 0, 0);
  strokeWeight(1);
  line(width*0.5, 0, width*0.5, height);
  line(0, height*0.5, width, height*0.5);
}

void keyPressed(KeyEvent e) {
  switch (e.getKey()) {
  case '`':
    debug = !debug;
    if (debug) {
      cp5.show();
    } else {
      cp5.hide();
    }
    break;
  case 's':
    cp5.saveProperties("config");
    break;
  case ' ':
    println("oh it's a space.");
    break;
  case BACKSPACE:
    break;
  default:
    println(e.getKey());
    break;
  }
}

void mouseWheel(MouseEvent e) {
  r.incMag(e.getAmount());
}

void recordFramesClick() {
  cp5.hide();
  startRecordFrame = frameCount;
}
