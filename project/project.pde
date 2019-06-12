
Tank t;
Menu mainMenu;
Menu characterMenu;
Button back; 
void setup() {
  size(1200, 1000);
  surface.setResizable(true);

  t = new Tank(width/2, height/2, 75,"tanks/rTank4.png");
  mainMenu = new Menu(300,75,true,new String[]{"PLAY","CHARACTER","OPTIONS","EXIT"});
  characterMenu = new Menu(100,100,false,new String[]{"","","",""});
  back = new Button(125, 40, 0, 20, "Main Menu");

  textFont(loadFont("SitkaSmall-48.vlw"));

  colorMode(HSB, 100, 100, 100);
  smooth(3);
}

int t1 = 100;
int menuSelection = 0;
void draw() {
  background(#3f3f3f);
  
  if (menuSelection!=0) {
    if (back.mouseReleased()) menuSelection = back.getMenuType();
    back.setPos(width-90, 50);
    back.show();
  }
  
  switch (menuSelection) {
    case -1:
      exit();
    case 0:
      
      mainMenu.update();
      mainMenu.show();
      menuSelection = mainMenu.getMenuType();
      break;
    case 1:    
      game();
      break;
    case 2:
      characterMenu.update();
      characterMenu.show();
      menuSelection = characterMenu.getMenuType();
    
  }
}


void game() {
  t.keyPressed(new int[]{UP, DOWN, LEFT, RIGHT, 32});//32 is space
  t.update();
  t.show();
}
