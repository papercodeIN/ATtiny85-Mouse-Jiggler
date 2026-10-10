# ATtiny85 Mouse Jiggler - Flash Tool

A simple batch script to erase and flash firmware onto your Digispark ATtiny85.

## Folder Structure

```
Flash-Tool/
├── flash.bat          # Run this to flash your device
├── Firmware/
│   └── ATTIny85-Mouse.hex   # Place your compiled .hex file here
├── Tools/
│   └── micronucleus.exe      # (Optional) Place micronucleus here
└── README.md
```

## Setup

### 1. Get the firmware .hex file

Open the sketch in Arduino IDE, then:
- **Sketch > Export Compiled Binary**
- Copy the generated `.hex` file to the `Firmware/` folder
- Rename it to `ATTIny85-Mouse.hex`

### 2. micronucleus.exe

The script auto-detects `micronucleus.exe` from your Arduino IDE installation. If it can't find it, place it manually in the `Tools/` folder.

Download from: https://github.com/micronucleus/micronucleus/releases

### 3. USB Drivers

Windows requires Digistump/libusb drivers. Use the Zadig driver installer or install drivers from the `Driver/` folder in the root of this repo.

## Usage

1. Double-click `flash.bat`
2. Choose an option (Erase + Flash recommended)
3. **Plug in your ATtiny85 when prompted** (the bootloader only runs for ~5 seconds after plug-in)
4. Wait for completion

## Important

The Digispark bootloader runs for ~5 seconds after the device is plugged in. The script waits 60 seconds for you to plug in the board. Always plug in **after** the script says to.
