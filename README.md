# 🖱️ ATtiny85 USB Mouse Jiggler

[![YouTube](https://img.shields.io/badge/YouTube-Fusion_Automate-red?logo=youtube)](https://www.youtube.com/@Fusion_Automate)
[![Instagram](https://img.shields.io/badge/Instagram-fusion__automate-E4405F?logo=instagram&logoColor=white)](https://www.instagram.com/fusion_automate)
[![X](https://img.shields.io/badge/X-fusion__automate-000?logo=x&logoColor=white)](https://x.com/fusion_automate)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Fusion_Automate-0077B5?logo=linkedin&logoColor=white)](https://in.linkedin.com/company/fusion-automate)
[![GitHub](https://img.shields.io/badge/GitHub-papercodeIN-181717?logo=github&logoColor=white)](https://github.com/papercodeIN)
[![WhatsApp](https://img.shields.io/badge/WhatsApp-Group-25D366?logo=whatsapp&logoColor=white)](https://chat.whatsapp.com/GgZVMsE9kzpAbX6Kz25kKy)
[![Store](https://img.shields.io/badge/Store-Fusion_Automate-blue?logo=shopify&logoColor=white)](https://shop.fusionautomate.in/)

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

With just a few lines of code and a Digispark ATTiny85, you can build a reliable USB Mouse Jiggler that keeps your system active — hands-free. It's compact, affordable, and incredibly useful for anyone needing uninterrupted uptime.
