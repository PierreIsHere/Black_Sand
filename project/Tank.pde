class Tank {
  PVector loc;  
  float vel=0;
  int angle=90;
  int side;
  float max = 7.5; // absolute maximum velocity
  int arsenal = 30;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  ArrayList<Bullet> shot = new ArrayList<Bullet>();
  int shots = 0;
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

    for (int i=0; i<bullets.size()-shots; i++) {
      bullets.get(i).reset(loc.x, loc.y);
    }

    for (int i=shot.size()-1; i>0; i--) {
      shot.get(i).move(angle);
      shot.get(i).show();
      //if (bullets.get(i).loc.x+bullets.get(i).r>width || bullets.get(i).loc.y+bullets.get(i).r>height || bullets.get(i).loc.x<bullets.get(i).r || bullets.get(i).loc.y<bullets.get(i).r) bullets.remove(i);
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
      if (keyCode == keyset[1])  vel++;
      if (keyCode == keyset[2])  angle -= 5;
      if (keyCode == keyset[3])  angle += 5;
      if (key == keyset[4]) {
        //print(shots+" ");
        if (bullets.size()>0) {
          shot.add(bullets.get(bullets.size()-1));
          bullets.remove(bullets.size()-1);
        }
      }
    }
    vel = constrain(vel, -max, max); // limiting velocity to max
  }
}
