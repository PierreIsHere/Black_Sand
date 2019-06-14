
Tank t;
Menu mainMenu;
Menu characterMenu;
Button back; 
Map map;
void setup() {
  fullScreen();

  t = new Tank(width/2, height/2, 75);
  mainMenu = new Menu(300, 75, true, 0, new String[]{"PLAY", "CHARACTER", "OPTIONS", "EXIT"}, new String[] {"", "", "", ""});
  characterMenu = new Menu(110, 110, false, -1, new String[]{"", "", "", ""}, new String[] {"tanks/bTank1.png", "tanks/bTank2.png", "tanks/bTank3.png", "tanks/bTank4.png"});
  back = new Button(125, 40, 0, 20, "Main Menu", "");
  map = new Map(0.205);
  
  textFont(loadFont("MicrosoftYaHeiUI-48.vlw"));

  colorMode(HSB, 100, 100, 100);
  smooth(3);
  map.generate();
}

int t1 = 100;
int menuSelection = 0;
int character = 1;
void draw() {
  background(#3f3f3f);

  switch (menuSelection) {
  case -1:
    exit();
  case 0:      
    mainMenu.update();
    mainMenu.show();
    menuSelection = mainMenu.getMenuType();
    break;
  case 1: 
    
    t.setImage("tanks/bTank"+character+".png");
    game();
    break;
  case 2:
    characterMenu.update();
    characterMenu.show();
    
    character = characterMenu.getMenuType();
    menuSelection = characterMenu.getMenuType() != -1? 0: 2;
    println(character);
    break;
  case 3:
    map.show();
  }
  
  if (menuSelection!=0) {
    if (back.mouseReleased()) menuSelection = back.getMenuType();
    back.setPos(width-90, 50);
    back.show();
  }

}


void game() {
  
  t.keyPressed(new int[]{UP, DOWN, LEFT, RIGHT, 32});//32 is space
  t.update();
  t.show();
}
