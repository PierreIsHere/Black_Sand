
class Map {
  float occurence;
  static final int TILESIZE = 75;
  boolean[][] points = new boolean[width/TILESIZE+1][height/TILESIZE+1];
  PVector ground = new PVector(1,2);
  PVector wall = new PVector(5,4);
  PImage tile = loadImage("tiles.png");
  Map(float occurence) {
    this.occurence = occurence;
  }

  void generate() {
    for (int x=0; x<points.length; x++) {
      for (int y=0; y<points[0].length; y++) {
        points[x][y] = noise(x, y)<=occurence;
        // print(points[x][y]+",");
      }
      //println();
    }
  }
  void show() {
    imageMode(CORNER);


    for (int x=0; x<points.length; x++) {
      for (int y=0; y<points[0].length; y++) {
        pushMatrix();
        translate(x*TILESIZE, y*TILESIZE);
        if (!points[x][y])
          copy(tile, int(ground.x)*32, int(ground.y)*32, 32, 32, 0, 0,TILESIZE,TILESIZE);// int(TILESIZE*(1+width/float(TILESIZE))), int(TILESIZE*(1+height/float(TILESIZE))));
        else
          copy(tile, int(wall.x)*32, int(wall.y)*32, 32,32, 0, 0,TILESIZE,TILESIZE);//int(TILESIZE*(1+width/float(TILESIZE))), int(TILESIZE*(1+height/float(TILESIZE))));
        popMatrix();
        
      }
    }
  }
}
