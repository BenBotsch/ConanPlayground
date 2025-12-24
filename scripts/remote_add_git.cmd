@echo off
set REMOTE_NAME=git-recipes
set REMOTE_URL=https://github.com/<org>/git-conan-recipes.git

conan remote remove %REMOTE_NAME% >nul 2>&1
conan remote add %REMOTE_NAME% %REMOTE_URL% --type git
conan remote list