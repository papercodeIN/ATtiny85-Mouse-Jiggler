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

## 📑 Table of Contents

- [Key Features](#-key-features)
- [Repository Structure](#-repository-structure)
- [Hardware Requirements](#-hardware-requirements)
- [Arduino Setup](#-arduino-setup)
- [User Settings](#-user-settings)
- [How It Works](#-how-it-works)
- [Flash Tool](#-flash-tool)
- [Applications](#-applications)
- [Troubleshooting](#-troubleshooting)
- [Buy Ready-Made](#-buy-ready-made)

---

## ⚙️ Key Features

- ✅ No extra hardware required — runs entirely on ATTiny85
- ✅ USB HID mouse emulation via DigiMouse
- ✅ Smooth cursor movement (20 micro-steps per direction)
- ✅ Configurable interval, distance, speed, and step count
- ✅ Prevents sleep, lock, or screensaver activation
- ✅ Plug-and-play — just connect to any USB port
- ✅ Compatible with **Windows**, **macOS**, and **Linux**

---

## 📁 Repository Structure

```
ATtiny85-Mouse-Jiggler/
├── Project/
│   ├── ATTIny85-Mouse/
│   │   └── ATTIny85-Mouse.ino        # Main firmware sketch
│   └── Reference Projects/
│       └── Digispark_MouseJiggler/
│           └── Digispark_MouseJiggler.ino  # Reference sketch by James Franklin
├── Flash-Tool/
│   ├── flash.bat                      # One-click flash tool for Windows
│   ├── Firmware/                      # Place compiled .hex file here
│   ├── Tools/                         # Optional: place micronucleus.exe here
│   └── README.md
├── Driver/
│   └── Digistump.Drivers.zip         # USB drivers for Windows
├── Images/
│   └── Additional Board.png          # Arduino IDE board manager screenshot
└── README.md
```

---

## 🛒 Hardware Requirements

| Component | Details |
|-----------|---------|
| **Digispark ATTiny85** | Any clone or original board with USB-A connector |
| **USB Port** | Any available USB-A port on the target computer |
| **USB Drivers** | Required on Windows only (included in `Driver/` folder) |

No additional wiring, sensors, or components needed.

---

## 🔧 Arduino Setup

### 1. Install USB Drivers (Windows Only)

Extract and install drivers from `Driver/Digistump.Drivers.zip`. On Windows 10/11, you may need to use the [Zadig driver installer](https://zadig.akeo.ie/) to install the **libusb-win32** driver for the Digispark device.

### 2. Add Digistump Board to Arduino IDE

Go to **File > Preferences** and add this URL to **Additional Board Manager URLs**:

```
https://raw.githubusercontent.com/digistump/arduino-boards-index/master/package_digistump_index.json
```

![Additional Board](https://github.com/papercodeIN/ATtiny85-Mouse-Jiggler/blob/main/Images/Additional%20Board.png)

### 3. Install the Board Package

Go to **Tools > Board > Board Manager**, search for **Digistump AVR Boards**, and install it.

### 4. Select the Board

Go to **Tools > Board** and select **Digispark (Default - 16.5 MHz)**.

### 5. Upload the Sketch

1. Open `Project/ATTIny85-Mouse/ATTIny85-Mouse.ino`
2. Click **Upload**
3. When the IDE says _"Plug in device now..."_, connect the Digispark to USB
4. Wait for upload to complete

> **Note:** The Digispark bootloader runs for ~5 seconds after plug-in. Always start the upload **before** plugging in the board.

---

## 🎛️ User Settings

All configurable parameters are at the top of `ATTIny85-Mouse.ino`:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `moveInterval` | `uint16_t` | `2000` | Delay between movement cycles (ms) |
| `moveDistance` | `int8_t` | `60` | Cursor distance per direction (pixels, max 127) |
| `smoothDelay` | `uint16_t` | `10` | Delay between micro-steps (ms) |
| `steps` | `int` | `20` | Number of micro-steps per direction |

### Tuning Tips

- **Increase `moveInterval`** to make movements less frequent (e.g., `5000` = every 5 seconds)
- **Decrease `moveDistance`** to make cursor movements smaller and less noticeable
- **Increase `steps`** for smoother movement (at the cost of longer movement duration)
- Keep `moveDistance` divisible by `steps` for the smoothest motion (e.g., 60 / 20 = 3 pixels per step)

---

## 🧠 How It Works

The device emulates a USB HID mouse using the **DigiMouse** library. On each cycle it moves the cursor in a square pattern — **right → down → left → up** — then waits before repeating. Each direction is broken into smooth micro-steps to avoid jarring cursor jumps.

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

### How `moveSmooth()` Works

1. Divides the total distance into equal micro-steps (`xDist / steps`)
2. Calculates any remainder from integer division
3. Adds the remainder to the **final step** so the cursor always returns to its exact starting position
4. Calls `DigiMouse.update()` after each direction to keep the USB connection alive

---

## 🔥 Flash Tool

A Windows batch script is included for quick firmware flashing without the Arduino IDE.

### Setup

1. Compile the sketch in Arduino IDE: **Sketch > Export Compiled Binary**
2. Copy the `.hex` file to `Flash-Tool/Firmware/ATTIny85-Mouse.hex`
3. The script auto-detects `micronucleus.exe` from your Arduino IDE installation. If not found, download it from the [Micronucleus releases](https://github.com/micronucleus/micronucleus/releases) and place it in `Flash-Tool/Tools/`

### Usage

1. Double-click `Flash-Tool/flash.bat`
2. Choose an option:
   - **[1] Erase + Flash** — recommended for clean install
   - **[2] Erase only** — wipe the device
   - **[3] Flash only** — upload without erasing first
3. Plug in the ATtiny85 **when prompted** (not before)
4. Wait for completion

> See [`Flash-Tool/README.md`](Flash-Tool/README.md) for more details.

---

## 💡 Applications

| Use Case | Description |
|----------|-------------|
| 🖥️ **Prevent Screen Lock** | Keeps your system awake during downloads or updates |
| 🎤 **Presentations** | Ensures your screen stays active while presenting |
| 🧪 **Testing & Automation** | Maintains activity during unattended operations |
| 🛡️ **Monitoring Systems** | Prevents sleep on machines requiring constant uptime |
| 🏢 **Remote Work** | Keeps status indicators active on communication tools |

---

## 🔍 Troubleshooting

| Problem | Solution |
|---------|----------|
| Device not recognized on Windows | Install drivers from `Driver/Digistump.Drivers.zip` or use [Zadig](https://zadig.akeo.ie/) |
| Upload fails / times out | Start upload **before** plugging in the board. The bootloader only listens for ~5 seconds |
| Cursor doesn't move after upload | Wait 500 ms after plug-in (startup delay). Try a different USB port |
| Cursor drifts over time | Ensure `moveDistance` is within `int8_t` range (-128 to 127) |
| Can't reprogram the board | The 500 ms startup delay in `setup()` gives a window — plug in and upload quickly |
| Arduino IDE can't find the board | Make sure **Digispark (Default - 16.5 MHz)** is selected under **Tools > Board** |

---

## 🛒 Buy Ready-Made

Don't want to build one yourself? Get a pre-built, plug-and-play ATtiny85 Mouse Jiggler:

- [Fusion Automate Store](https://shop.fusionautomate.in/)
- [Tindie Store](https://www.tindie.com/products/42020/)

---

**Fusion Automate — Industrial IoT Solutions**
