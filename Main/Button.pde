class Button {
  float x;
  float y;
  int sizeX;
  int sizeY;
  color clr;
  int menuType;
  String name;
  int fontSize;
  PImage overlay;
  float zoom=1;
  Button(int sizeX, int sizeY, int menuType, int fontSize, String name, String overlay) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.menuType = menuType;
    this.fontSize = fontSize;
    this.name = name;
    if (!overlay.equals(""))
      this.overlay = loadImage(overlay);
  }

  boolean mouseReleased() {

    if (mouseX>=x-sizeX/2.0 && mouseX<=x+sizeX/2.0 && mouseY>=y-sizeY/2.0 && mouseY<=y+sizeY/2.0) {       
      this.clr = color(hue(#818181), saturation(#818181)-10, brightness(#818181)+10);      
      this.zoom += 0.1;      
      if (mousePressed)       
        return true;
    }
    else{
      this.clr = #818181;
      this.zoom -= 0.1;
    }
    return false;
  }

  void setPos(float x, float y) {
    this.x = x;
    this.y = y;
  }

  int getMenuType() {
    return menuType;
  }

  void show() {
    fill(clr);
    noStroke();
    rectMode(CENTER);

    if (this.overlay==null)
      rect(x, y, sizeX, sizeY, sizeY/5, sizeY/10, sizeY/5, sizeY/10);
    else {
      pushMatrix();
      imageMode(CENTER);
      translate(x, y);
      zoom = constrain(zoom, 1.0, 2.0);
      scale(zoom);
      overlay.resize(sizeX, 0);
      image(overlay, 0, 0);
      popMatrix();
    }

    textAlign(CENTER, CENTER);
    fill(100, 0, 100);    
    textSize(fontSize);
    text(name, x, y);
  }
}
