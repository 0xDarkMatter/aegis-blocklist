@echo off
title Aegis NextDNS Importer
echo.
echo ========================================
echo   Aegis NextDNS Importer
echo ========================================
echo.
echo Downloading script...
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/tools/nextdns-import.ps1' -OutFile '%TEMP%\aegis-import.ps1'"
echo.
echo Starting import...
echo.
powershell -ExecutionPolicy Bypass -File "%TEMP%\aegis-import.ps1"
echo.
pause
