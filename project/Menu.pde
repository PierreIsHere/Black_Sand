class Menu{
  final int SIZEY = 75;
  ArrayList<Button> btns = new ArrayList<Button>();
  String[] names = {"PLAY","CHARACTER","OPTIONS","EXIT"};
  Menu(int nums){
    for(int i = 0; i<nums; i++){
      this.btns.add(new Button(300,SIZEY,names[i]=="EXIT"?-1:i,40,names[i]));
    }
  }
  
  int getMenuType(){
    for(int i = 0; i<btns.size(); i++){
       this.btns.get(i).setPos(width/2,height/2+(SIZEY+20)*(i+1-(btns.size()+1)/2.0));
       if(this.btns.get(i).mouseReleased()) return this.btns.get(i).getMenuType();
    }
    return 0;
  }
  
  void show(){
    for(int i = 0; i<btns.size(); i++){
      this.btns.get(i).show();
    }    
  }
  
  
}
