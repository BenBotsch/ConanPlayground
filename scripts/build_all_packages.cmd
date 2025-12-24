@echo off
setlocal enabledelayedexpansion

REM --- Fehlerbehandlung wie "set -euo pipefail" in Bash ---
REM Wenn ein Befehl fehlschlägt, Script sofort beenden
cmd /c exit 1 >nul 2>&1
if %errorlevel% neq 0 (
    echo Fehler: CMD unterstuetzt kein echtes "set -e", aber wir brechen bei Fehlern ab.
)

REM --- Conan Build Type ---
set BUILD_TYPE=Release

echo Building package: hello
conan create packages/hello -s build_type=%BUILD_TYPE% -pr:b default -pr:b conan-config/profiles/common --build=missing
if errorlevel 1 goto :error

echo Building package: adder
conan create packages/adder -s build_type=%BUILD_TYPE% -pr:b default -pr:b conan-config/profiles/common --build=missing
if errorlevel 1 goto :error

echo.
echo Alle Pakete erfolgreich gebaut.
goto :end

:error
echo.
echo FEHLER: Der Build wurde abgebrochen.
exit /b 1

:end
endlocal
exit /b 0