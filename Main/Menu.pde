

class Menu {
  int sizeX;
  int sizeY;
  boolean layout;
  ArrayList<Button> btns = new ArrayList<Button>();
  int defaultMenu;

  Menu(int sizeX, int sizeY, boolean layout, int def, String[] names, String[] overlay) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.layout = layout;
    this.defaultMenu = def;

    for (int i = 0; i<names.length; i++) {      
      this.btns.add(new Button(sizeX, sizeY, names[i].equals("EXIT")?-1:i+1, 40, names[i], overlay[i]));
    }
  }

  int getMenuType() {
    for (int i = 0; i<btns.size(); i++) {
        
      if (this.btns.get(i).mousePressed()) {
       
        return this.btns.get(i).getMenuType();
      }
    }
    return defaultMenu;
  }

  void update() {

    for (int i = 0; i<btns.size(); i++) {
      //sets the button's position spreading out from the center of the screen with some spacing inbetween them
      if (layout)
        this.btns.get(i).setPos(width/2, height/2+(sizeY*1.25)*(i+1-(btns.size()+1)/2.0));
      else
        this.btns.get(i).setPos(width/2+(sizeX*3)*(i+1-(btns.size()+1)/2.0), height/2);
    }
  }

  void show() {
    for (int i = 0; i<btns.size(); i++) {
      this.btns.get(i).show();
    }
  }
}
