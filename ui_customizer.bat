@echo off
:: Windows 11 UI Customization Tool
:: Run with Administrator privileges for full functionality

:: Check if script is run as administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires Administrator privileges.
    pause
    exit
)

:menu
cls
echo ===================================
echo        Windows 11 UI Customizer
echo ===================================
echo.
echo Select an option:
echo 1. Enable Dark Mode
echo 2. Enable Transparency Effects
echo 3. Set Custom Accent Color
echo 4. Set Taskbar Transparency
echo 5. Change Taskbar Position
echo 6. Change Taskbar Alignment
echo 7. Reset to Default Settings
echo 8. Exit
echo.
set /p choice="Enter your choice (1-8): "

if "%choice%"=="1" goto dark_mode
if "%choice%"=="2" goto transparency
if "%choice%"=="3" goto accent_color
if "%choice%"=="4" goto taskbar_transparency
if "%choice%"=="5" goto taskbar_position
if "%choice%"=="6" goto taskbar_alignment
if "%choice%"=="7" goto reset_settings
if "%choice%"=="8" exit
goto menu

:dark_mode
echo Enabling Dark Mode...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul
echo Dark Mode enabled.
pause
goto menu

:transparency
echo Enabling Transparency Effects...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul
echo Transparency effects enabled.
pause
goto menu

:accent_color
cls
echo ===================================
echo         Set Custom Accent Color
echo ===================================
echo Enter a HEX color in the format RRGGBB, where:
echo - RR is the red component (00 to FF)
echo - GG is the green component (00 to FF)
echo - BB is the blue component (00 to FF)
echo.
echo Examples:
echo - Black:   000000
echo - White:   FFFFFF
echo - Red:     FF0000
echo - Green:   00FF00
echo - Blue:    0000FF
echo.
set /p accentColor="Enter accent color (RRGGBB format): "
echo Setting Accent Color to #%accentColor%...

:: Set the accent color to apply on taskbar and title bars
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v ColorPrevalence /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" /v AccentColor /t REG_DWORD /d 0x%accentColor% /f >nul
echo Accent color set to #%accentColor%.
pause
goto menu

:taskbar_transparency
echo Enabling Taskbar Transparency...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseOLEDTaskbarTransparency /t REG_DWORD /d 1 /f >nul
echo Taskbar transparency enabled.
pause
goto menu

:taskbar_position
echo.
echo Taskbar Position Options:
echo - 01 = Bottom
echo - 00 = Top
echo - 02 = Right
echo - 03 = Left
echo.
set /p taskbarPosition="Enter Taskbar Position (01, 00, 02, or 03): "
echo Setting Taskbar Position...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v Settings /t REG_BINARY /d 28000000%taskbarPosition%00000000000000000200000030000000 /f >nul
echo Taskbar position set.
taskkill /f /im explorer.exe >nul
start explorer.exe
pause
goto menu

:taskbar_alignment
echo.
echo Taskbar Alignment Options:
echo - 0 = Left
echo - 1 = Center
echo.
set /p taskbarAlign="Enter Taskbar Alignment (0 for Left, 1 for Center): "
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d %taskbarAlign% /f >nul
echo Taskbar alignment set.
taskkill /f /im explorer.exe >nul
start explorer.exe
pause
goto menu

:reset_settings
echo Resetting to default settings...
:: Reset Dark Mode
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f >nul

:: Reset Transparency
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul

:: Reset Taskbar Position to Bottom
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v Settings /t REG_BINARY /d 280000000100000000000000000000000200000030000000 /f >nul

:: Reset Taskbar Alignment to Center
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 1 /f >nul

:: Restart Explorer
taskkill /f /im explorer.exe >nul
start explorer.exe
echo Settings reset to default.
pause
goto menu
