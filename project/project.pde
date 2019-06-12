
Tank t;
Menu mainMenu;
Button back; 
void setup() {
  size(800, 600);
  surface.setResizable(true);
  
  t = new Tank(width/2, height/2, 20);
  mainMenu = new Menu(3);
  back = new Button(75,40,0,20,"Menu");
  
  textFont(loadFont("SitkaSmall-48.vlw"));
  
  colorMode(HSB,100,100,100);
  smooth(3);
}

int t1 = 100;
int menuSelection = 0;
void draw() {
  background(#3f3f3f);
  
  switch (menuSelection) {
  case 0:
    menuSelection = mainMenu.getMenuType();
    mainMenu.show();
    //stroke(#05FF03);
    //line(0, 0, width, height);
    //line(0, height, width, 0);
    //line(0, height/2, width, height/2);
    //line(width/2, 0, width/2, height);
    break;
  case 1:    
    game();
    break;
   case -1:
     exit();
  }
  
}


void game() {

  //fill(120);
  //square(width/2, height/2, 30);
  
  
  t.keyPressed(new int[]{UP, DOWN, LEFT, RIGHT, 32});//32 is space

  t.update();
  t.show();
  
  if(back.mouseReleased()) menuSelection = back.getMenuType();
  back.setPos(width-60,height-50);
  back.show();
}
