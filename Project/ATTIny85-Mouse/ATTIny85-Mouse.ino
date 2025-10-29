#include <DigiMouse.h>

// ===== USER SETTINGS =====
const uint16_t moveInterval = 2000;  // time between movements (ms)
const uint8_t moveDistance = 60;     // movement distance in pixels
const uint16_t smoothDelay = 10;     // small delay between micro movements
// ==========================

void setup() {
  DigiMouse.begin();
  // Small startup delay gives time for reprogramming if needed
  for (int i = 0; i < 50; i++) {
    DigiMouse.update();
    delay(10);
  }
}

void loop() {
  // Move in a small square smoothly
  moveSmooth(moveDistance, 0);   // Right
  moveSmooth(0, moveDistance);   // Down
  moveSmooth(-moveDistance, 0);  // Left
  moveSmooth(0, -moveDistance);  // Up

  DigiMouse.delay(moveInterval); // Wait before next move
}

// Smooth mouse movement function
void moveSmooth(int8_t xDist, int8_t yDist) {
  int steps = 20; // number of small steps for smoothness
  int8_t stepX = xDist / steps;
  int8_t stepY = yDist / steps;

  for (int i = 0; i < steps; i++) {
    DigiMouse.move(stepX, stepY, 0);
    DigiMouse.delay(smoothDelay);
  }

  // Small update to keep connection alive
  DigiMouse.update();
}
