
float func(float x) { 
  return sin(x) * sin(time());
}
float time() {
  return millis()/1000.0;
}


PVector[] values;
PVector zoom = new PVector(5, 5);
PVector offset = new PVector();
boolean isDragging = false;

ArrayList<Button> buttons = new ArrayList<Button>();

void setup() {
  size(800, 500);
  offset.x = width/2;
  offset.y = height/2;
  values = new PVector[width];
  setupButtons();
}
void setupButtons() {
  float x = width - 120;
  buttons.add(
    new Button(x, 20, "Zoom In") {
    @Override public void onClick() {
      offset.x = 0;
      offset.y = height;
      zoom.x = zoom.y = 1;
    }
  }
  );
  buttons.add(
    new ButtonSlider(x, 65, "Scale X", 1, 10) {
    @Override public float getVal() { 
      return zoom.x;
    }
    @Override public void setVal(float v) { 
      zoom.x = v;
    }
  }
  );
  buttons.add(
    new ButtonSlider(x, 110, "Scale Y", 1, 10) {
    @Override public float getVal() { 
      return zoom.y;
    }
    @Override public void setVal(float v) { 
      zoom.y = v;
    }
  }
  );
}
void draw() {
  // update:
  dragGraph();
  updateButtons();
  calculateGraphValues();
  //smoothingFilter();

  /// draw:
  drawGraph();
  for (Button b : buttons) b.draw();
}
void dragGraph() {
  if (isDragging) {
    offset.x += mouseX - pmouseX;
    offset.y += mouseY - pmouseY;
  }
}
void updateButtons() {
  if (!isDragging) {
    // if NOT dragging, check if the mouse is hovering over any buttons:
    boolean isOverButton = false;
    for (int i = buttons.size() - 1; i >= 0; i--) {
      Button b = buttons.get(i);
      b.update();
      b.hover = false;
      if (!isOverButton && b.isMouseOver()) {
        isOverButton = true;
        b.hover = true;
      }
    }
  }
}
void calculateGraphValues() {
  PVector scale = getDrawScale();
  for (int i = 0; i < values.length; i++) {

    float x = (i - offset.x) / scale.x;
    float y = func(x);

    //if(i > 0) y = (y + values[i-1].y * 19)/20; // real-time smoothing filter

    values[i] = new PVector(x, y);
  }
}
void smoothingFilter() {

  int smoothAmount = 10;
  float[] smoothedValues = new float[values.length];
  for (int i = 0; i < values.length; i++) {

    float val = values[i].y * 10;
    for (int j = 1; j <= smoothAmount; j++) { 
      if (i - j >= 0) val += values[i - j].y;
      if (i + j < values.length) val += values[i + j].y;
    }
    smoothedValues[i] = val/(smoothAmount * 2 + 10);
  }

  for (int i = 0; i < values.length; i++) {
    values[i].y = smoothedValues[i];
  }
}
void drawGraph() {
  PVector scale = getDrawScale();

  pushMatrix();
  translate(offset.x, offset.y);
  scale(1, -1);
  background(255);

  // DRAW AXES:
  stroke(0);
  strokeWeight(2);
  line(-width, 0, width, 0);
  line(0, -height, 0, height);
  strokeWeight(1);

  // DRAW GRID:
  stroke(200);
  line(-width, 1 * scale.y, width, 1 * scale.y);
  line(-width, -1 * scale.y, width, -1 * scale.y);
  line(1 * scale.x, -height, 1 * scale.x, height);
  line(-1 * scale.x, -height, -1 * scale.x, height);

  // DRAW DATA:
  stroke(0);
  for (int i = 1; i < values.length; i++) {

    PVector a = values[i-1];
    PVector b = values[i];

    line(
      a.x * scale.x, 
      a.y * scale.y, 
      b.x * scale.x, 
      b.y * scale.y);
  }
  popMatrix();
}
PVector getDrawScale() {
  return new PVector(width/zoom.x, height/zoom.y);
}
void mousePressed() {
  isDragging = true;
  for (int i = buttons.size() - 1; i >= 0; i--) {
    Button b = buttons.get(i);
    if (b.isMouseOver()) {
      b.onClick();
      isDragging = false;
      break;
    }
  }
}
void mouseReleased() {
  isDragging = false;
  for (Button b : buttons) b.onRelease();
}
