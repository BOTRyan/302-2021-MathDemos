void setup() {
  size(500, 500);
}

void draw() {
  background(128);

  float time = millis()/1000.0;
  
  float x = sin(time) * 200 + width/2;
  float y = cos(time) * 200 + height/2;

  fill(255);
  ellipse(width/2, height/2, 400, 400);
  fill(0, 255, 0);
  ellipse(x, height/2, 25, 25);
  fill(0, 0, 255);
  ellipse(width/2, y, 25, 25);
  fill(255, 0, 0);
  ellipse(x, y, 50, 50);
}
