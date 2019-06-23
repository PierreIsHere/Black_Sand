class Bullet {
  PVector loc;
  float angle;
  float v = 10;
  float r;
  final float STRENGTH = 10;
  PImage b;

  Bullet(float x, float y, String bullet) {
    loc = new PVector(x, y);
    b = loadImage(bullet);
    if (bullet.equals("bullet2.png"))
      b.resize(58, 0);
    else
      b.resize(20, 0);
    r = sqrt(b.getModifiedX2()*b.getModifiedX2()+b.getModifiedY2()*b.getModifiedY2())*0.5;
  }

  void move() {    
    loc.x -= cos(radians(angle))*v;  
    loc.y -= sin(radians(angle))*v;
    v*=0.999;
  }

  void setAngle(float angle) {
    this.angle = angle;
  }

  void reset(float x, float y) {
    loc.set(x, y);
  }

  float getRadius() {
    return r;
  }

  PVector getLoc() {
    return loc;
  }
  float[] getCorners() {    
    return new float[] {loc.x, loc.y, r-1.5};//{(this.loc.y-tank.getModifiedY2()*0.5)*sin(radians(angle)),(this.loc.x-side*0.5)*cos(radians(angle)),(this.loc.y+tank.getModifiedY2()*0.5)*sin(radians(angle)),(this.loc.x+side*0.5)*cos(radians(angle))};
  }
  void show() {
    pushMatrix();

    translate(loc.x, loc.y);
    rotate(radians(angle));

    image(b, 0, 0);

    popMatrix();
  }
}
 
