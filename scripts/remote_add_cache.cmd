@echo off
set REMOTE_NAME=cache
set REMOTE_URL=http://localhost:8083

conan remote remove %REMOTE_NAME% >nul 2>&1
conan remote add %REMOTE_NAME% %REMOTE_URL%
conan remote list