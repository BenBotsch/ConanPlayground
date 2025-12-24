@echo off
setlocal

REM ------------------------------------------------------------
REM Default-Parameter: RemoteName
REM ------------------------------------------------------------
if "%1"=="" (
    set REMOTE_NAME=artifactory
) else (
    set REMOTE_NAME=%1
)

echo Using remote: %REMOTE_NAME%

REM ------------------------------------------------------------
REM Conan uploads
REM ------------------------------------------------------------
conan upload "hello/0.1.0:*" -r=%REMOTE_NAME% -c
if errorlevel 1 (
    echo ERROR: Failed to upload hello
    exit /b 1
)

conan upload "adder/0.1.0:*" -r=%REMOTE_NAME% -c
if errorlevel 1 (
    echo ERROR: Failed to upload adder
    exit /b 1
)

echo Uploads completed successfully.

endlocal