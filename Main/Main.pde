import processing.net.*; 

Client c; 
char input;

Tank t;
Tank t2;
Menu mainMenu;
Menu characterMenu;
Button back; 
Map map;

PImage b;
void setup() {
  size(1600, 900, P2D);
  //fullScreen(P2D);
  c = new Client(this, "72.141.8.213", 1720); 
  t = new Tank(width+100, height-100, 75);
  t2 = new Tank(100, height-100, 75);
  mainMenu = new Menu(300, 75, true, 0, new String[]{"PLAY", "CHARACTER", "EXIT"}, new String[] {"", "", "", ""});
  characterMenu = new Menu(110, 110, false, -1, new String[]{"", "", "", ""}, new String[] {"tanks/bTank1.png", "tanks/bTank2.png", "tanks/bTank3.png", "tanks/bTank4.png"});
  back = new Button(125, 40, 0, 20, "Main Menu", "");
  map = new Map();

  textFont(loadFont("MicrosoftYaHeiUI-200.vlw"));

  colorMode(HSB, 100, 100, 100);
  smooth(0);

  b = loadImage("background.jpg");
  b.resize(width, height);
}

int t1 = 100;
int t3 = 100;
int time1 = millis();
boolean mapTimer = true;
int menuSelection = 0;
int character = 1;
boolean charSelect = false;
int tSize = 300;
void draw() {

  tint(#3A02F5);
  background(b);
  noTint();

  switch (menuSelection) {
  case -1:

    exit();
    //break();
  case 0:      
    mainMenu.update();
    mainMenu.show();

    //println( menuSelection);
    time1 = millis();
    map.reset();
    menuSelection = mainMenu.getMenuType();
    break;
  case 1: 
    if (charSelect) {
      t.setImage("tanks/bTank"+character+".png");
      t2.setImage("tanks/rTank"+character+".png");
      charSelect = false;
      t.reset();
      t2.reset();
    }
    //background(m);
    int time2 = millis();


    if (time2-time1<5500) {
      tSize -= 0.5;
      textSize(tSize);
      text(5-(time2-time1)/1000, width>>2, height>>1);
      map.show();
      map.update();
      if ((time2-time1)%1000 <100)
        tSize=300;
    } else { 


      game();
      map.show();
      map.detectCollision(t);
      map.detectCollision(t2);
      if (SAT(t.getCorners(), t2.getCorners()))
        t.limit(t2.loc.x, t2.loc.y, t2.r);
      //t2.limit(t);
    }
    if(t.health<0 || t2.health<0 )
      menuSelection = 3;
    break;
  case 2:
    characterMenu.update();
    characterMenu.show();
    character = 2;
    if (characterMenu.getMenuType()!=-1) {
      character = characterMenu.getMenuType();    
      menuSelection = 0;
      charSelect = true;
    }
    break;
  case 3:
    textMode(CENTER);
    textSize(200);
    text("GAME OVER",width>>1,(height>>1)-100);
    textSize(100);
    text((t.health>t2.health? "Player 1 Wins": t2.health==t.health? "Game Tied":"Player 2 Wins")  ,width>>1,(height>>1)+100);
  }

  if (menuSelection!=0) {
    if (back.mousePressed()){
      if(menuSelection==3){
      t.reset();
      t2.reset();
      }
      menuSelection = back.getMenuType();
      
    }
    back.setPos(width-90, 50);
    back.show();
    
  }
}


void game() {

  t.update(t2);
 

  t.keyPressed(new int[]{UP, DOWN, LEFT, RIGHT, ' '});

  t.show();
  
    if(c.available()>0){
    input = c.readChar();
     
    println(input);
    }
    t2.update(t);
    t2.webKey(input);
    t2.show();
  
}

boolean collide(float[] A, float[] B) {
  if (dist(A[0], A[1], B[0], B[1])<A[2]+B[2])
    return true;
  return false;
}


float slope(float x1, float y1, float x2, float y2) {
  return (y2-y1)/(x2-x1);
}

PVector POI(float m1, float b1, float m2, float b2) {
  return new PVector((b1-b2)/(-m2+m1), (b1-b2)/(m2-m1)*m1+b1);
}

// separated axis theorem implemenation to check for convex polygon collisions
boolean SAT(PVector[] A, PVector[] B) {
  strokeWeight(2.5);
  float m, b;
  float newM, b2;
  PVector n;
  PVector max;
  PVector min;

  PVector[][] axis = new PVector[4][6]; // projected points of obj B onto all axis of A
  PVector[][] axisSelf = new PVector[4][6]; // projected points of obj A onto all axis of A
  PVector[][] axisSelf2 = new PVector[4][6];// projected points of obj A onto all axis of B
  PVector[][] axis2 = new PVector[4][6];// projected points of obj B onto all axis of B

  // iterating through all points of objA and and calculating points of intersection with perpendicular to all axis of objB and all axis of objA
  for (int i=0; i<2; i++) {  
    //creating the i-th axis 
    m = -slope(A[i].x, A[i].y, A[i+2].x, A[i+2].y); //slope of 2 adjacent points of objA
    b = m*A[i].x+A[i].y; //y intercept of 2 adjacent points of objA

    // calculating POI between all points of objB projected onto current axis and 1st and 2nd points of objA projected onto the current axis
    for (int j=0; j<4; j++) {
      newM = -1/m;
      b2 = newM*B[j].x+B[j].y;
      n = POI(m, b, newM, b2);
      axis[i][j]= n;
      b2 =  newM*A[j].x+A[j].y;
      n = POI(m, b, newM, b2);
      axisSelf[i][j] = n;
    }

    m = -1/m; //rotating slope by 90 degs;
    b = (m*A[i+2].x+A[i+2].y); //new rotated y-intercept

    // calculating POI between all points of objB projected onto current axis and 3rd and 4th points of objA projected onto the current axis
    for (int j=0; j<4; j++) {
      newM = -1/m;
      b2 = newM*B[j].x+B[j].y;
      n = POI(m, b, newM, b2);
      axis[i+2][j]=n;
      b2 =  newM*A[j].x+A[j].y;
      n = POI(m, b, newM, b2);
      axisSelf[i+2][j] = n;
    }
  }

  stroke(#03FF15);  
  //calculating the farthest points of the projected points of objB on objA and drawing a line between them
  for (int j = 0; j<4; j++) {
    max = axis[j][0];
    min = axis[j][0];
    for (int k=1; k<4; k++) {
      if (max.x>axis[j][k].x)
        max = axis[j][k];
      if (min.x<axis[j][k].x)
        min = axis[j][k];
    }
    axis[j][4] = min;
    axis[j][5] = max;
  }


  //calculating the farthest points of the projected points of objA on objA and drawing a line between them
  for (int j = 0; j<4; j++) {
    max = axisSelf[j][0];
    min = axisSelf[j][0];
    for (int k=1; k<4; k++) {
      if (max.x>axisSelf[j][k].x)
        max = axisSelf[j][k];
      if (min.x<axisSelf[j][k].x)
        min = axisSelf[j][k];
    }
    axisSelf[j][4] = min;
    axisSelf[j][5] = max;
  }

  // repeating all of the above for shape 2
  for (int i=0; i<2; i++) {  

    m = -slope(B[i].x, B[i].y, B[i+2].x, B[i+2].y);
    b = m*B[i].x+B[i].y;

    for (int j=0; j<4; j++) {
      newM = -1/m;
      b2 = newM*A[j].x+A[j].y;
      n = POI(m, b, newM, b2);
      axis2[i][j]= n;
      b2 =  newM*B[j].x+B[j].y;
      n = POI(m, b, newM, b2);
      axisSelf2[i][j] = n;
    }

    m = -1/m;
    b = (m*B[i+2].x+B[i+2].y);

    for (int j=0; j<4; j++) {
      newM = -1/m;
      b2 = newM*A[j].x+A[j].y;
      n = POI(m, b, newM, b2);
      axis2[i+2][j]=n;
      b2 =  newM*B[j].x+B[j].y;
      n = POI(m, b, newM, b2);
      axisSelf2[i+2][j] = n;
    }
  }
  for (int j = 0; j<4; j++) {
    max = axis2[j][0];
    min = axis2[j][0];
    for (int k=1; k<4; k++) {
      if (max.x>axis2[j][k].x)
        max = axis2[j][k];
      if (min.x<axis2[j][k].x)
        min = axis2[j][k];
    }
    axis2[j][4] = min;
    axis2[j][5] = max;
  }

  for (int j = 0; j<4; j++) {
    max = axisSelf2[j][0];
    min = axisSelf2[j][0];
    for (int k=1; k<4; k++) {
      if (max.x>axisSelf2[j][k].x)
        max = axisSelf2[j][k];
      if (min.x<axisSelf2[j][k].x)
        min = axisSelf2[j][k];
    }
    axisSelf2[j][4] = min;
    axisSelf2[j][5] = max;
  }

  for (int j = 0; j<4; j++) {
    float r1x = (axis[j][4].x+axis[j][5].x)/2.0;
    float r1y = (axis[j][4].y+axis[j][5].y)/2.0;
    float r2x = (axisSelf[j][4].x+axisSelf[j][5].x)/2.0;
    float r2y = (axisSelf[j][4].y+axisSelf[j][5].y)/2.0;

    if (dist(axis[j][4].x, axis[j][4].y, axis[j][5].x, axis[j][5].y)/2.0+dist(axisSelf[j][4].x, axisSelf[j][4].y, axisSelf[j][5].x, axisSelf[j][5].y)/2.0<dist(r1x, r1y, r2x, r2y))      
      return false;

    r1x = (axis2[j][4].x+axis2[j][5].x)/2.0;
    r1y = (axis2[j][4].y+axis2[j][5].y)/2.0;
    r2x = (axisSelf2[j][4].x+axisSelf2[j][5].x)/2.0;
    r2y = (axisSelf2[j][4].y+axisSelf2[j][5].y)/2.0;
    if ((dist(axis2[j][4].x, axis2[j][4].y, axis2[j][5].x, axis2[j][5].y)+dist(axisSelf2[j][4].x, axisSelf2[j][4].y, axisSelf2[j][5].x, axisSelf2[j][5].y))/2.0<dist(r1x, r1y, r2x, r2y))      
      return false;
  }
  return true;
}
