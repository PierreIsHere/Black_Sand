class Tank {
  PVector loc;
  PVector vel = new PVector(0,0);
  int angle=0;
  int side;
  Tank(int x, int y, int side) {
    loc = new PVector(x, y);
    this.side = side;
  }

  void move(int dX, int dY) {
    vel.add(dX/2.0, dY/2.0);
    vel.limit(7.5);
  }
  void rot(float a) {
    angle+=a;
    
    // print(angle+" ");
  }
  void resetVel() {
   vel.mult(0.89);
  }

  void update() {
    loc.add(vel);
    loc.x = constrain(loc.x, 0, width-side);
    loc.y = constrain(loc.y, 0, height-side*1.5);
  }

  void show() {
    pushMatrix();
    fill(255);
    noStroke();
    rect(loc.x,loc.y, side, side*1.5, 3);
    //beginShape(QUADS);
    //vertex(loc.x, loc.y);
    //vertex(loc.x, side*1.5+loc.y);
    //vertex(side+loc.x, loc.y+side*1.5);
    //vertex(side+loc.x, loc.y);

   
    popMatrix();
    
  }

  void keyPressed() {  
    if (keyPressed) {    
      if (keyCode == UP || key == 'w') this.move(0, -1);
      else if (keyCode == DOWN || key == 's') this.move(0, 1);
      else if (keyCode == RIGHT || key == 'd') this.move(1,0);
      else if (keyCode == LEFT || key == 'a') this.move(-1,0);
    } else this.resetVel();
  }
}
