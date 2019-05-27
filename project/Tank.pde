class Tank {
  PVector loc;  
  float vel=0;
  int angle=90;
  int side;
  float max = 7.5; // absolute maximum velocity
  int arsenal = 30;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  ArrayList<Bullet> shot = new ArrayList<Bullet>();
  boolean shoot = false;
  
  Tank(int x, int y, int side) {
    loc = new PVector(x, y);
    this.side = side;
    for (int i=0; i<arsenal; i++) bullets.add(i, new Bullet(loc.x, loc.y));
  }

  void shoot() {
  }

  void update() {
    // updating the x and y location based on the angle
    loc.x += cos(radians(angle))*vel;  
    loc.y += sin(radians(angle))*vel;

    //reducing velocity to simulate deceleration
    vel *=0.9;

    // limiting the tank's location to the border of the screen
    loc.x = constrain(loc.x, 0, width); 
    loc.y = constrain(loc.y, 0, height);

    for (int i=0; i<bullets.size(); i++) {
      bullets.get(i).reset(loc.x, loc.y);
    }

    if (shoot) {
      if (bullets.size()>0) {
        bullets.get(bullets.size()-1).setAngle(angle);
        shot.add( bullets.get(bullets.size()-1));
        bullets.remove(bullets.size()-1);
      }
      shoot = false;
    }

    for (int i=shot.size()-1; i>0; i--) {
      shot.get(i).move();
      shot.get(i).show();
      if (shot.get(i).loc.x+shot.get(i).r>width || shot.get(i).loc.y+shot.get(i).r>height || shot.get(i).loc.x<shot.get(i).r || shot.get(i).loc.y<shot.get(i).r) shot.remove(i);
    }

    //print(bullets.size()+" ");
  }

  void show() {

    pushMatrix(); // adding the tank to a new display grid

    translate(loc.x, loc.y); // moving the tank from the original grid to 0,0 of the new grid

    rotate(radians(angle)); // rotating the tank on the origin of the new grid

    // displaying the tank
    rectMode(CENTER);
    noStroke();
    fill(255);    
    rect(0, 0, side*1.5, side, 3);

    rotate(PI/2.0);// rotating the turret to face the same direction as the tank

    //displaying the turret
    strokeWeight(3);
    stroke(0);
    line(0, side, 0, 10);
    noStroke();

    popMatrix(); // deleting the tank from the new display grid and adding back to the original with translated and rotated co-ordinates
  }

  void keyPressed(int[] keyset) {  

    // updating velocity and angle based on key presses
    if (keyPressed) {
      if      (keyCode == keyset[0])  vel--;
      else if (keyCode == keyset[1])  vel++;
      else if (keyCode == keyset[2])  angle -= 3.5;
      else if (keyCode == keyset[3])  angle += 3.5;
      else if     (key == keyset[4]) {
        int t2 = millis();
        if(t2-t1>100)  shoot = true;
        t1 = t2;
      }
    }
    vel = constrain(vel, -max, max); // limiting velocity to max
  }

}
