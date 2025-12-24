@echo off
setlocal enabledelayedexpansion

REM Stop on error
REM (cmd hat kein echtes "Stop", daher prüfen wir nach jedem Schritt)
echo Starting build...

REM Save current directory
set ORIGINAL_DIR=%CD%

REM Change directory
cd apps\consumer
if errorlevel 1 goto :error

REM Conan install
conan install . -of build --build=missing -s build_type=Release -pr:b default -pr:b ..\..\conan-config\profiles\common
if errorlevel 1 goto :error

REM CMake configure
cmake --preset conan-default
if errorlevel 1 goto :error

REM CMake build
cmake --build --preset conan-release
if errorlevel 1 goto :error

REM Run executable
build\Release\consumer_app.exe
if errorlevel 1 goto :error

REM Restore directory
cd "%ORIGINAL_DIR%"
echo Done.
exit /b 0

:error
echo.
echo ERROR: Build or execution failed.
cd "%ORIGINAL_DIR%"
exit /b 1
