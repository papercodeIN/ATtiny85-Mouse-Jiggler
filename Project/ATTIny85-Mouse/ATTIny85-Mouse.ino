#include <DigiMouse.h>

// ===== USER SETTINGS =====
const uint16_t moveInterval = 2000;
const int8_t moveDistance = 60;
const uint16_t smoothDelay = 10;
const int steps = 20;
// ==========================

void setup() {
  DigiMouse.begin();
  for (int i = 0; i < 50; i++) {
    DigiMouse.update();
    delay(10);
  }
}

void loop() {
  moveSmooth(moveDistance, 0);
  moveSmooth(0, moveDistance);
  moveSmooth(-moveDistance, 0);
  moveSmooth(0, -moveDistance);

  DigiMouse.delay(moveInterval);
}

void moveSmooth(int8_t xDist, int8_t yDist) {
  int8_t stepX = xDist / steps;
  int8_t stepY = yDist / steps;
  int8_t remainX = xDist - (stepX * steps);
  int8_t remainY = yDist - (stepY * steps);

  for (int i = 0; i < steps; i++) {
    int8_t dx = stepX + ((i == steps - 1) ? remainX : 0);
    int8_t dy = stepY + ((i == steps - 1) ? remainY : 0);
    DigiMouse.move(dx, dy, 0);
    DigiMouse.delay(smoothDelay);
  }

  DigiMouse.update();
}
