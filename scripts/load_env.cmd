@echo off
setlocal enabledelayedexpansion

if not exist ".env" (
    echo No .env file found.
    exit /b 0
)

echo Loading environment variables from .env ...

for /f "usebackq tokens=1,* delims==" %%A in (".env") do (
    if not "%%A"=="" (
        set %%A=%%B
    )
)

echo Environment variables loaded.
endlocal & (
    set ARTIFACTORY_URL=%ARTIFACTORY_URL%
    set ARTIFACTORY_REPO=%ARTIFACTORY_REPO%
    set ARTIFACTORY_USER=%ARTIFACTORY_USER%
    set ARTIFACTORY_TOKEN=%ARTIFACTORY_TOKEN%
    set ARTIFACTORY_REMOTE_NAME=%ARTIFACTORY_REMOTE_NAME%
)
