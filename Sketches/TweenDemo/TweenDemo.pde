float valStart = 0;
float valEnd = 500;
float animLength = 1;
float animPlayHeadTime = 0;
boolean isTweenPlaying = false;
float dt;
float currTime;
float prevTime = 0;

void setup() {
  size(500, 500);
}

void draw() {
  background(128); //fills screen with 50% grey

  currTime = millis()/1000.0;
  dt = currTime - prevTime;
  prevTime = currTime;

  // move playhead forward in time:
  if (isTweenPlaying) {
    animPlayHeadTime += dt;
  }

  // percent:
  float p = animPlayHeadTime / animLength;

  // manipluate 'p'
  // p = p * p; // "bends" curve down - easing in
  // p = 1 - (1 - p) * (1 - p); // "bends" curve 
  p = p * p * (3 - 2 * p); // smooth step
  
  float x = lerp(valStart, valEnd, p);

  // don't allow extrapolation:
  if (x >= 510) animPlayHeadTime = 0;

  // draw ellipse at x position:
  ellipse(x, height/2, 20, 20);
}

void mousePressed() {
  //animPlayHeadTime = 0; //Restarts Animation
  if (isTweenPlaying) {
    isTweenPlaying = false;
  } else {
    isTweenPlaying = true;
  }
}
