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

void setup() {
  DigiMouse.begin();
}

void loop() {
  DigiMouse.moveX(1);  // Move right
  delay(100);
  DigiMouse.moveY(1);  // Move down
  delay(100);
  DigiMouse.moveX(-1); // Move left
  delay(100);
  DigiMouse.moveY(-1); // Move up
  delay(100);
  delay(2000);         // Wait before repeating
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

---

Let me know if you'd like a visual schematic, animated demo, or a printable quick-start guide for this project!
