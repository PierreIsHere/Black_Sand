class Tank {
  PVector loc;  
  float vel=0;
  int angle=91;
  int side;
  float max = 6; // absolute maximum velocity
  int arsenal = 150;
  int shotPower = 1;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  ArrayList<Bullet> shot = new ArrayList<Bullet>();
  int health = 100;
  PImage tank;
  float r;
  boolean iSelect = true;
  Tank(int x, int y, int side,String image) {
    loc = new PVector(x, y);
    this.side = side;
    for (int i=0; i<arsenal; i++) bullets.add(i, new Bullet(loc.x, loc.y, "bullet.png"));
    this.tank = loadImage(image);
    this.tank.resize(side, 0);
    r = sqrt(side*side+this.tank.getModifiedY2()*this.tank.getModifiedY2())*0.5-5;
  }
  void reset() {
    this.health = 100;
    bullets.clear();
    shot.clear();
    if (shotPower == 2)

      for (int i=0; i<arsenal/2; i++) bullets.add(i, new Bullet(loc.x, loc.y, "bullet2.png"));
    else
      for (int i=0; i<arsenal; i++) bullets.add(i, new Bullet(loc.x, loc.y, "bullet.png"));
  }

  void setImage(String tank) {
    if (tank.equals("tanks/bTank4.png")|| tank.equals("tanks/rTank4.png"))
      shotPower = 2;
    else 
    shotPower = 1;
    this.tank = loadImage(tank);
    this.tank.resize(side, 0);
  }

  void update(Tank t) {
    // updating the x and y location based on the angle
    loc.x += cos(radians(angle))*vel;  
    loc.y += sin(radians(angle))*vel;

    //reducing velocity to simulate deceleration
    vel *=0.9;

    // limiting the tank's location to the border of the screen
    loc.x = constrain(loc.x, r, width-r); 
    loc.y = constrain(loc.y, r, height-r);



    for (int i=0; i<bullets.size(); i++) {
      bullets.get(i).reset(loc.x, loc.y);


      //bullets.get(i).reset(loc.x-10, loc.y);
    }


    for (int i=shot.size()-1; i>0; i--) {
      shot.get(i).move();
      shot.get(i).show();
      if (shot.get(i).getLoc().x+shot.get(i).getRadius()>width|| 
        shot.get(i).getLoc().y+shot.get(i).getRadius()>height || 
        shot.get(i).getLoc().x<shot.get(i).getRadius()        || 
        shot.get(i).getLoc().y<shot.get(i).getRadius()        ||
        collide(shot.get(i).getCorners(), new float[] {t.loc.x, t.loc.y, t.r-1}) ||
        map.detectCollision(shot.get(i))) {

        if (collide(shot.get(i).getCorners(), new float[] {t.loc.x, t.loc.y, t.r-1})) {          
          t.health-=shotPower;
        }
        shot.remove(i);
      }
    }

    //print(bullets.size()+" ");
  }


  void show() {


    pushMatrix(); // adding the tank to a new display grid

    translate(loc.x, loc.y); // moving the tank from the original grid to 0,0 of the new grid

    rectMode(CORNER);

    strokeWeight(1);
    fill(lerpColor(#83FF00, #FF0000, 1-health/100.0));
    rect(-r, -r-30, health, 10, 2);
    noFill();
    stroke(#FFFFFF, 100);
    rect(-r, -r-30, 100, 10, 4);
    rotate(radians(angle)); // rotating the tank on the origin of the new grid

    // displaying the tank
    imageMode(CENTER);
    noStroke();
    image(tank, 0, 0);
    popMatrix(); // deleting the tank from the new display grid and adding back to the original with translated and rotated co-ordinates
  }

  PVector[] getCorners() {
    float off = this.tank.getModifiedY2()*0.5/r;//asin(side/r*0.5);
    PVector[] corners = new PVector[5];

    for (int i = 0; i<2; i++) {
      corners[i]=new PVector(this.loc.x+r*cos(radians(angle)+off+PI*i), this.loc.y+r*sin(radians(angle)+off+PI*i));
    }    
    for (int i = 0; i<2; i++) {
      corners[i+2] = new PVector(this.loc.x+r*cos(radians(angle)-off+PI*i), this.loc.y+r*sin(radians(angle)-off+PI*i), 5);
    }

    corners[4] = loc;
    // println(corners);
    return corners;
  }

  void limit(float x, float y, float r) {
    float dx = this.loc.x-x;
    float dy = this.loc.y-y;
    float rsum = this.r +r;
    float len = sqrt(dx*dx+dy*dy);
    this.loc.x = constrain(this.loc.x, 0, x + (rsum+1)*dx/len);
    this.loc.y = constrain(this.loc.y, 0, y + (rsum+1)*dy/len);
  }
  void keyPressed(int[] keyset) {  

    // updating velocity and angle based on key presses
    if (keyPressed) {
      if (key == CODED) {
        if      (keyCode == keyset[0])  vel--;
        else if (keyCode == keyset[1])  vel++;
        else if (keyCode == keyset[2])  angle -= 2;
        else if (keyCode == keyset[3])  angle += 2;
      } else if (key == keyset[4]) {
        int t2 = millis();
        if (t2-t1>50) {
          if (bullets.size()>0) {

            bullets.get(bullets.size()-1).setAngle(angle);
            shot.add( bullets.get(bullets.size()-1));
            bullets.remove(bullets.size()-1);
          }
        }
        t1 = t2;
      }
    }
    vel = constrain(vel, -max, max); // limiting velocity to max
  }

  void webKey(int k) {
    if      (k == 'w')  vel--;
    else if (k == 's')  vel++;
    else if (k == 'a')  angle -= 2;
    else if (k == 'd')  angle += 2;
    else if (k == 'x')  {
    int t2 = millis();
        if (t2-t3>50) {
          if (bullets.size()>0) {

            bullets.get(bullets.size()-1).setAngle(angle);
            shot.add( bullets.get(bullets.size()-1));
            bullets.remove(bullets.size()-1);
            //println(tank.toString());
          }
        }
        t3 = t2;
    }
    vel = constrain(vel, -max, max); // limiting velocity to max
  }
}
