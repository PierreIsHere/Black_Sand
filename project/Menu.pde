class Menu{
  int sizeX;
  int sizeY;
  boolean layout;
  ArrayList<Button> btns = new ArrayList<Button>();
  Menu(int sizeX,int sizeY,boolean layout,String[] names){
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.layout = layout;
    for(int i = 0; i<names.length; i++){
      this.btns.add(new Button(sizeX,sizeY,names[i]=="EXIT"?-1:i+1,40,names[i]));
    }
  }
  
  int getMenuType(){
    for(int i = 0; i<btns.size(); i++)
      if(this.btns.get(i).mouseReleased()) return this.btns.get(i).getMenuType();
    
    return 0;
  }
  
  void update(){
    for(int i = 0; i<btns.size(); i++)
      //sets the button's position spreading out from the center of the screen with some spacing inbetween them
      this.btns.get(i).setPos(width/2,height/2+(sizeY*1.25)*(i+1-(btns.size()+1)/2.0));
  }
  
  void show(){
    for(int i = 0; i<btns.size(); i++){
      this.btns.get(i).show();
    }    
  }
  
  
}
