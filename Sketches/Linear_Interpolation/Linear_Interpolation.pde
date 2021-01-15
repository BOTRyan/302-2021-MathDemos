// Linear Interpolation
// LERP
// Timeline between 2 values
// 0% ------------ 100%
// 50 ------------ 100
// Getting 50% between them should return 75
// lerp(minValue, maxValue, percentValue)
// percentValue normally between 0 to 1

float size = 50;

void setup() {
  size(500, 500);
}

void draw() {
  background(128);

  float p = mouseX / 500f;

  size = lerp(50, 300, p);

  fill(p * 255);

  ellipse(width/2, height/2, size, size);
}
