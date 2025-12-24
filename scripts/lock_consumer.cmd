@echo off
setlocal enabledelayedexpansion

REM Fehlerbehandlung: Skript bei Fehler abbrechen

REM Ordner "locks" erstellen, falls nicht vorhanden
if not exist locks (
    mkdir locks
    if errorlevel 1 (
        echo Fehler beim Erstellen des Ordners "locks"
        exit /b 1
    )
)

REM Release Lockfile
conan lock create apps/consumer ^
  -s:h build_type=Release ^
  -pr:h default ^
  -pr:b default -pr:b conan-config/profiles/common ^
  --lockfile-out locks/consumer_release.lock

if errorlevel 1 (
    echo Fehler beim Erstellen des Release-Lockfiles
    exit /b 1
)

REM Debug Lockfile
conan lock create apps/consumer ^
  -s:h build_type=Debug ^
  -pr:h default ^
  -pr:b default -pr:b conan-config/profiles/common ^
  --lockfile-out locks/consumer_debug.lock

if errorlevel 1 (
    echo Fehler beim Erstellen des Debug-Lockfiles
    exit /b 1
)

echo Created lockfiles in ./locks
endlocal