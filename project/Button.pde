class Button{
  float x;
  float y;
  int sizeX;
  int sizeY;
  color clr;
  int menuType;
  String name;
  int fontSize;
  Button(int sizeX, int sizeY, int menuType, int fontSize, String name){
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.menuType = menuType;
    this.fontSize = fontSize;
    this.name = name;
  }
  
  boolean mouseReleased(){
    
    if(mouseX>=x-sizeX/2.0 && mouseX<=x+sizeX/2.0 && mouseY>=y-sizeY/2.0 && mouseY<=y+sizeY/2.0) {
      
      this.clr = color(hue(#818181),saturation(#818181)-10,brightness(#818181)+10);
      if(mousePressed){
        return true;
      }
    }
    else  this.clr = #818181;
    return false;
  }
  
  void setPos(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  int getMenuType(){
    return menuType;
  }
  void show(){
    fill(clr);
    noStroke();
    rectMode(CENTER);
    rect(x,y,sizeX,sizeY,sizeY/5,sizeY/10,sizeY/5,sizeY/10);
    textAlign(CENTER,CENTER);
    fill(100,0,100);
    
    textSize(fontSize);
    text(name,x,y);
    
  }
}
