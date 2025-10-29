# 🖱️ ATtiny85 USB Mouse Jiggler

Turn your **Digispark ATTiny85** into a compact, plug-and-play USB Mouse Jiggler using the **DigiMouse** library. This tiny tool keeps your computer awake by simulating subtle mouse movements — perfect for long downloads, presentations, or unattended tasks.

---

## 🔧 Arduino Setup

- **Additional Board URL**  
  Add this to your Arduino IDE:  
  `https://raw.githubusercontent.com/digistump/arduino-boards-index/master/package_digistump_index.json`

- **Board Reference Image**  
  ![Additional Board](https://github.com/papercodeIN/ATtiny85-Mouse-Jiggler/blob/main/Images/Additional%20Board.png)

---

## 📦 Project Overview

The **Digispark ATTiny85** is a low-cost microcontroller capable of emulating USB HID devices. In this project, it acts as a virtual mouse, gently moving the cursor in a square pattern — right, down, left, up — every few seconds.

These movements are:
- Minimal enough to avoid disrupting your workflow
- Effective enough to prevent screen lock or sleep mode

---

## ⚙️ Key Features

- ✅ No extra hardware required — runs entirely on ATTiny85  
- ✅ USB HID mouse emulation via DigiMouse  
- ✅ Configurable movement interval (default: every 2 seconds)  
- ✅ Prevents sleep, lock, or screensaver activation  
- ✅ Plug-and-play — just connect to any USB port  

---

## 🧠 How It Works

```cpp
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
```

- The **DigiMouse** library initializes a virtual USB mouse.
- The loop moves the cursor in a small square pattern.
- A delay ensures subtle, periodic movement to keep the system active.

---

## 📚 Required Library

```cpp
#include <DigiMouse.h>
```

The DigiMouse library allows the ATTiny85 to simulate mouse movements and clicks as a USB HID device.

---

## 💡 Applications

- 🖥️ **Prevent Screen Lock**: Keeps your system awake during downloads or updates  
- 🎤 **Presentations**: Ensures your screen stays active while presenting  
- 🧪 **Testing & Automation**: Maintains activity during unattended operations  
- 🛡️ **Monitoring Systems**: Prevents sleep on machines requiring constant uptime  

---

## 🧪 Example Use Case

Upload the sketch to your Digispark ATTiny85, plug it into your PC or laptop, and let it run. Your system will stay awake — no more manual mouse wiggles!

---

## ⚠️ Notes

- Compatible with **Windows**, **macOS**, and **Linux** systems that support USB HID devices  
- You can customize movement intervals and directions in the code to suit your needs  

---

## ✅ Conclusion

With just a few lines of code and a Digispark ATTiny85, you can build a reliable USB Mouse Jiggler that keeps your system active — hands-free. It’s compact, affordable, and incredibly useful for anyone needing uninterrupted uptime.
