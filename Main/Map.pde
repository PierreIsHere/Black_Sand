
class Map {
  float occurence;

  final int TILESIZE;
  boolean[][] grid;
  PImage tile; 

  Map() {
    TILESIZE = gcd(width, height);
    grid = new boolean[width/TILESIZE][height/TILESIZE];
    tile = loadImage("wall.png");
    tile.resize(TILESIZE, 0);
  }

  int gcd(int a, int b) { 
    if (b == 0) 
      return a; 
    return gcd(b, a % b);
  } 

  void show() {

    imageMode(CENTER);
    for (float x = 0; x<grid.length; x++) {
      for (float y = 0; y<grid[0].length; y++) {
        if (grid[int(x)][int(y)]) {
          pushMatrix();
          image(tile, (x+0.5)*TILESIZE, (y+0.5)*TILESIZE);
          popMatrix();
        }
      }
    }
  }
  void detectCollision(Tank t) {

    for (float x = 0; x<grid.length; x++) {
      for (float y = 0; y<grid[0].length; y++) {
        if (grid[int(x)][int(y)]) {
          // if(SAT(t.getCorners(),new PVector[]{new PVector((x+1)*TILESIZE-2,(y+1)*TILESIZE+2),new PVector(x*TILESIZE+2,y*TILESIZE-2),new PVector(x*TILESIZE+2,(y+1)*TILESIZE+2),new PVector((x+1)*TILESIZE+2,y*TILESIZE-2)}))
          if (collide(new float[]{t.loc.x, t.loc.y, t.r/1.5}, new float[]{(x+0.5)*TILESIZE, (y+0.5)*TILESIZE, 1.2*TILESIZE*0.5 }))
            //t.limit((x+0.5)*TILESIZE,(y+0.5)*TILESIZE,sqrt(2)*TILESIZE*0.5);
            t.vel *=-1.25;
        }
      }
    }
  }
  boolean detectCollision(Bullet b) {

    for (float x = 0; x<grid.length; x++) {
      for (float y = 0; y<grid[0].length; y++) {
        if (grid[int(x)][int(y)]) {

          if (collide(b.getCorners(), new float[]{(x+0.5)*TILESIZE, (y+0.5)*TILESIZE, 1.2*TILESIZE*0.5 }))
            return true;
        }
      }
    }
    return false;
  }

  void update() {
    pushMatrix();
    stroke(#ffffff, 255);
    strokeWeight(2);
    for (int x = grid.length/2; x<grid.length-1; x++) {
      for (int y = 0; y<grid[0].length-1; y++) {
        if (grid[0].length-y>3 || grid.length-x>3) {
          noFill();
          rectMode(CORNER);
          square(x*TILESIZE,y*TILESIZE,TILESIZE);
          if (mouseX>x*TILESIZE && mouseX<(x+1)*TILESIZE && mouseY>y*TILESIZE && mouseY<(y+1)*TILESIZE) {
            if (mouseButton==RIGHT)
              grid[x][y] = false;
            else if (mouseButton==LEFT)
              grid[x][y] = true;
          }
        }
      }
    }
    popMatrix();
  }

  void reset() {
    grid = new boolean[width/TILESIZE][height/TILESIZE];
  }
}
