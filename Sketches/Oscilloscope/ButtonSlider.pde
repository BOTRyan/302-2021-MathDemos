class ButtonSlider extends Button {
  float min = 0;
  float max = 1;
  boolean dragSlider = false;
  
  ButtonSlider(float x, float y, String caption, float min, float max) {
    super(x, y, caption);
    this.min = min;
    this.max = max;
  }
  @Override public void onClick(){
     dragSlider = true;
  }
  @Override public void onRelease(){
     dragSlider = false;
  }
  @Override public void update(){
     if(dragSlider){
        float valuePerPixel = (max - min)/size.x;
        float deltaMouseX = mouseX - pmouseX;
        float newValue = getVal() + deltaMouseX * valuePerPixel;
        newValue = constrain(newValue, min, max);
        setVal(newValue);        
     }
  }
  @Override public void draw(){
    drawBG(hover || dragSlider);
    drawSlide();
    drawText();
  }
  void drawSlide(){
    float p = (getVal() - min) / (max - min);
    p = constrain(p, 0, 1);
    stroke(0);
    fill(255, 128, 128);
    rect(position.x, position.y, size.x * p, size.y);    
  }
  float getVal(){ return 0; }
  void setVal(float v){ }
}
