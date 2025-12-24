@echo off
setlocal enabledelayedexpansion

REM --- Fehlerbehandlung wie "set -euo pipefail" ---
REM Jeder Fehler soll das Script sofort abbrechen
echo Starte Conan-Konfiguration...

conan config install conan-config
if errorlevel 1 goto :error

echo Installed conan-config. Profile 'common' is now available in cache.

conan profile list
if errorlevel 1 goto :error

echo.
echo Conan-Konfiguration erfolgreich installiert.
goto :end

:error
echo.
echo FEHLER: Vorgang abgebrochen.
exit /b 1

:end
endlocal
exit /b 0