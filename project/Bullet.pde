class Bullet {
  PVector loc;
  float angle;
  float v = 10;
  float r = 5;
  final float STRENGTH = 10;
  Bullet(float x, float y) {
    loc = new PVector(x, y);
  }

  void move() {
    
    loc.x -= cos(radians(angle))*v;  
    loc.y -= sin(radians(angle))*v;
    v*=0.999;
    
  }
  
  void setAngle(float angle){
    this.angle = angle;
  }
  void reset(float x, float y) {
    loc.set(x, y);
  }
  
  float getRadius(){
    return r;
  }
  
  PVector getLoc(){
    return loc;
  }

  void show() {
    pushMatrix();

    translate(loc.x, loc.y);
    rotate(-radians(angle));
    noStroke();
    fill(100);
    circle(0, 0, r);

    popMatrix();
  }
}
