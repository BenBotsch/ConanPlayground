@echo off
setlocal

REM ------------------------------------------------------------
REM Nexus Konfiguration
REM ------------------------------------------------------------
set REMOTE_NAME=nexus
set REMOTE_URL=http://localhost:8084/repository/conan-hosted
set NEXUS_USER=admin
set NEXUS_PASSWORD=a8a54255-d455-49b3-9bfd-6ca9dc49fc93

echo Using remote: %REMOTE_NAME%
echo Remote URL: %REMOTE_URL%

REM ------------------------------------------------------------
REM Remote entfernen (falls vorhanden)
REM ------------------------------------------------------------
conan remote remove %REMOTE_NAME% >nul 2>&1

REM ------------------------------------------------------------
REM Remote hinzufügen
REM ------------------------------------------------------------
conan remote add %REMOTE_NAME% %REMOTE_URL%
if errorlevel 1 (
    echo ERROR: Failed to add Nexus remote
    exit /b 1
)

REM ------------------------------------------------------------
REM Login (Conan 2 Syntax!)
REM ------------------------------------------------------------
conan remote login %REMOTE_NAME% %NEXUS_USER% -p %NEXUS_PASSWORD%
if errorlevel 1 (
    echo ERROR: Failed to login to Nexus
    exit /b 1
)

REM ------------------------------------------------------------
REM Remotes anzeigen
REM ------------------------------------------------------------
conan remote list

echo Nexus remote configured successfully.

endlocal
