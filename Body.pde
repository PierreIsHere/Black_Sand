class Body{
  float g;
  float vi;
  float vy;
  float vx;
  float f = 0.1-1;
  float y;
  float x;
  int diameter = 5;
  color c;
  Body(int x, int y, float g, float vi, float a,color c){
    this.x = x;
    this.y = y;
    this.g = g;
    this.vi = vi;
    vy = sin(radians(a))*vi;
    vx = cos(radians(a))*vi;
    this.c = c;
  }
  
  void update(){
    x += vx;
    vy += g; 
    y += vy;
    if (y + diameter/2 > height) {
        y = height - diameter/2;
        vy *= f; 
    }
    if (y - diameter/2 < 0) {
        y = diameter/2;
        vy *= f; 
    }
    if (x + diameter/2 > width) {
        x = width - diameter/2;
        vx *= -.8; 
    }  
    if (x - diameter/2 < 0) {
        x = diameter/2;
        vx *= -.8; 
    }
  }
  
  void show(){
    fill(c);
    noStroke();
    circle(x,y,diameter);
  }
}
