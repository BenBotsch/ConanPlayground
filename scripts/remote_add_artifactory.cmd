@echo off
setlocal enabledelayedexpansion

REM ------------------------------------------------------------
REM .env laden
REM ------------------------------------------------------------
call "%~dp0load_env.cmd"

REM ------------------------------------------------------------
REM Default-Parameter: RemoteName
REM ------------------------------------------------------------
if not "%ARTIFACTORY_REMOTE_NAME%"=="" (
    set REMOTE_NAME=%ARTIFACTORY_REMOTE_NAME%
) else (
    set REMOTE_NAME=artifactory
)

echo Using remote name: %REMOTE_NAME%

REM ------------------------------------------------------------
REM Pflicht-Environment-Variablen prüfen
REM ------------------------------------------------------------
if "%ARTIFACTORY_URL%"=="" (
    echo ERROR: Set ARTIFACTORY_URL
    exit /b 1
)

if "%ARTIFACTORY_REPO%"=="" (
    echo ERROR: Set ARTIFACTORY_REPO
    exit /b 1
)

if "%ARTIFACTORY_USER%"=="" (
    echo ERROR: Set ARTIFACTORY_USER
    exit /b 1
)

if "%ARTIFACTORY_TOKEN%"=="" (
    echo ERROR: Set ARTIFACTORY_TOKEN
    exit /b 1
)

REM ------------------------------------------------------------
REM Artifactory Conan Remote URL (OHNE Auth!)
REM ------------------------------------------------------------
set REMOTE_URL=%ARTIFACTORY_URL%/api/conan/%ARTIFACTORY_REPO%
echo Remote URL: "%REMOTE_URL%"

REM ------------------------------------------------------------
REM Remote entfernen (falls vorhanden)
REM ------------------------------------------------------------
conan remote remove %REMOTE_NAME% >nul 2>&1

REM ------------------------------------------------------------
REM Remote hinzufügen
REM ------------------------------------------------------------
conan remote add %REMOTE_NAME% "%REMOTE_URL%"
if errorlevel 1 (
    echo ERROR: Failed to add remote
    exit /b 1
)

REM ------------------------------------------------------------
REM Login (Token / Passwort)
REM ------------------------------------------------------------
conan remote login %REMOTE_NAME% %ARTIFACTORY_USER% -p %ARTIFACTORY_TOKEN%
if errorlevel 1 (
    echo ERROR: Failed to login to remote
    exit /b 1
)

REM ------------------------------------------------------------
REM Liste anzeigen
REM ------------------------------------------------------------
conan remote list

echo Artifactory remote configured: %REMOTE_NAME% -^> "%REMOTE_URL%"

endlocal
