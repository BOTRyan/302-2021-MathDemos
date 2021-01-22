class Button {
  
  PVector position = new PVector(0, 0);
  PVector size = new PVector(100, 35);
  boolean hover = false;
  String caption = "";
  
  Button(float x, float y, String caption){
    this.caption = caption;
    this.position = new PVector(x, y);
  }
  void draw(){
    drawBG(hover);
    drawText();
  }
  void drawBG(boolean hover){
    stroke(0);
    fill(hover ? 200 : 128);
    rect(position.x, position.y, size.x, size.y);    
  }
  void drawText(){
    fill(0);
    textSize(16);
    textAlign(CENTER, CENTER);
    text(caption, position.x + size.x/2, position.y + size.y/2 - 2);
  }
  boolean isMouseOver(){
    if(mouseX < position.x) return false;
    if(mouseY < position.y) return false;
    if(mouseX > position.x + size.x) return false;
    if(mouseY > position.y + size.y) return false;
    return true;
  }
  void update(){}
  void onClick(){}
  void onRelease(){}
}
