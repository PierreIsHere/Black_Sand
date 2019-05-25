class Tank {
  PVector loc;  
  float vel=0;
  int angle=90;
  int side;
  float max = 7.5; // absolute maximum velocity
  Tank(int x, int y, int side) {
    loc = new PVector(x, y);
    this.side = side;
  }
 
  void update() {
    // updating the x and y location based on the angle
    loc.x += cos(radians(angle))*vel;  
    loc.y += sin(radians(angle))*vel;
    
    //reducing velocity to simulate deceleration
    vel *=0.9;
    
    // limiting the tank's location to the border of the screen
    loc.x = constrain(loc.x,0,width); 
    loc.y = constrain(loc.y,0,height);
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
    line(0,side,0,10);
    noStroke();
    
    popMatrix(); // deleting the tank from the new display grid and adding back to the original with translated and rotated co-ordinates 
  }

  void keyPressed() {  
    // updating velocity and angle based on key presses
    if (keyPressed) {
      if      (keyCode == UP || key == 'w')    vel--;
      else if (keyCode == DOWN || key == 's')  vel++;
      else if (keyCode == LEFT || key == 'a')  angle -= 5;
      else if (keyCode == RIGHT || key == 'd') angle += 5;
    }
    vel = constrain(vel,-max,max); // limiting velocity to max
  }
}
