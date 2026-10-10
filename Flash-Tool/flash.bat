@echo off
title ATtiny85 Mouse Jiggler - Flash Tool
color 0A

echo ============================================
echo   ATtiny85 Mouse Jiggler - Flash Tool
echo   Fusion Automate (shop.fusionautomate.in)
echo ============================================
echo.

set "MICRONUCLEUS="
set "HEX_FILE=%~dp0Firmware\ATTIny85-Mouse.hex"

for %%P in (
    "%LOCALAPPDATA%\Arduino15\packages\digistump\tools\micronucleus\2.0a4\micronucleus.exe"
    "%~dp0Tools\micronucleus.exe"
) do (
    if exist %%P (
        set "MICRONUCLEUS=%%~P"
        goto :found_tool
    )
)

echo [ERROR] micronucleus.exe not found.
echo.
echo Install it by one of the following methods:
echo   1. Install Digistump boards in Arduino IDE
echo   2. Place micronucleus.exe in the Tools\ folder next to this script
echo   3. Download from https://github.com/micronucleus/micronucleus/releases
echo.
goto :eof_pause

:found_tool
echo [OK] Found micronucleus: %MICRONUCLEUS%
echo.

if not exist "%HEX_FILE%" (
    echo [ERROR] Firmware file not found: %HEX_FILE%
    echo.
    echo Please compile the sketch in Arduino IDE first:
    echo   Sketch ^> Export Compiled Binary
    echo Then copy the .hex file to the Firmware\ folder.
    echo.
    goto :eof_pause
)

echo [OK] Firmware: %HEX_FILE%
echo.

echo ============================================
echo  Choose an option:
echo ============================================
echo   [1] Erase + Flash firmware (recommended)
echo   [2] Erase only
echo   [3] Flash firmware only
echo   [4] Exit
echo ============================================
echo.
set /p choice="Enter choice (1-4): "

if "%choice%"=="1" goto :erase_flash
if "%choice%"=="2" goto :erase_only
if "%choice%"=="3" goto :flash_only
if "%choice%"=="4" goto :eof
echo [ERROR] Invalid choice.
goto :eof_pause

:erase_flash
echo.
echo ============================================
echo  STEP 1: Erasing device...
echo ============================================
echo.
echo  >>> Plug in your ATtiny85 / Digispark NOW <<<
echo.
"%MICRONUCLEUS%" --erase-only --timeout 60
if errorlevel 1 (
    echo.
    echo [ERROR] Erase failed. Make sure drivers are installed and try again.
    goto :eof_pause
)
echo.
echo [OK] Erase complete.
echo.
echo ============================================
echo  STEP 2: Flashing firmware...
echo ============================================
echo.
echo  >>> Unplug and re-plug your ATtiny85 NOW <<<
echo.
"%MICRONUCLEUS%" --run --type intel-hex --timeout 60 "%HEX_FILE%"
if errorlevel 1 (
    echo.
    echo [ERROR] Flash failed.
    goto :eof_pause
)
echo.
echo [OK] Firmware flashed successfully!
echo     Your Mouse Jiggler is ready to use.
goto :eof_pause

:erase_only
echo.
echo ============================================
echo  Erasing device...
echo ============================================
echo.
echo  >>> Plug in your ATtiny85 / Digispark NOW <<<
echo.
"%MICRONUCLEUS%" --erase-only --timeout 60
if errorlevel 1 (
    echo.
    echo [ERROR] Erase failed.
    goto :eof_pause
)
echo.
echo [OK] Device erased successfully.
goto :eof_pause

:flash_only
echo.
echo ============================================
echo  Flashing firmware...
echo ============================================
echo.
echo  >>> Plug in your ATtiny85 / Digispark NOW <<<
echo.
"%MICRONUCLEUS%" --run --type intel-hex --timeout 60 "%HEX_FILE%"
if errorlevel 1 (
    echo.
    echo [ERROR] Flash failed.
    goto :eof_pause
)
echo.
echo [OK] Firmware flashed successfully!
echo     Your Mouse Jiggler is ready to use.
goto :eof_pause

:eof_pause
echo.
pause
:eof
