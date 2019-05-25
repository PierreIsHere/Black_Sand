class Tank {
  PVector loc;
  float vel=0;
  int angle=-90;
  int side;
  Tank(int x, int y, int side) {
    loc = new PVector(x, y);
    this.side = side;
  }
 
  void update() {
    loc.x += cos(radians(angle))*vel;
    loc.y += sin(radians(angle))*vel;
    vel *=0.9;
  }

  void show() {
    pushMatrix();
    fill(255);
    noStroke();
    translate(loc.x, loc.y);
    rotate(radians(angle));
    rectMode(CENTER);
    rect(0, 0, side*1.5, side, 3);
    popMatrix();
  }

  void keyPressed() {  

    if (keyPressed) {
      if      (keyCode == UP || key == 'w')    vel++;
      else if (keyCode == DOWN || key == 's')  vel--;
      else if (keyCode == LEFT || key == 'a')  angle -= 1;
      else if (keyCode == RIGHT || key == 'd') angle += 1;
    }
    vel = constrain(vel,-7.5,7.5);
  }
}
