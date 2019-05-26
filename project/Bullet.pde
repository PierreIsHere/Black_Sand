class Bullet {
  PVector loc;
  float angle;
  float v = 20;
  int r = 5;
  final float STRENGTH = 10;
  Bullet(float x, float y) {
    loc = new PVector(x, y);
  }

  void move(float angle) {
    this.angle = angle;
    loc.x -= cos(radians(angle))*v;  
    loc.y -= sin(radians(angle))*v;
  }

  void reset(float x, float y) {
    loc.set(x, y);
  }

  void show() {
    pushMatrix();

    translate(loc.x, loc.y);
    rotate(-radians(angle));
    noStroke();
    fill(#EA2700);
    circle(0, 0, r);

    popMatrix();
  }
}