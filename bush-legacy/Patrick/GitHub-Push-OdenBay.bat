@echo off
REM ============================================================
REM Bush Legacy Builders — GitHub Push
REM Project: Patrick Oden Bay
REM ============================================================

SET GH_TOKEN=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
SET GH_USER=Jbickish7464
SET REPO=Cowork-projects
SET BRANCH=main
SET PROJECT_PATH=bush-legacy\Patrick

SET SOURCE_DIR=%~dp0
SET WORK_DIR=%TEMP%\blb-github-push

echo.
echo === Bush Legacy Builders — GitHub Push ===
echo Project: %PROJECT_PATH%
echo Source: %SOURCE_DIR%
echo Target: github.com/%GH_USER%/%REPO%/%PROJECT_PATH%
echo.

REM Clean up previous temp work
if exist "%WORK_DIR%" rmdir /s /q "%WORK_DIR%"
mkdir "%WORK_DIR%"
cd /d "%WORK_DIR%"

REM Clone existing repo
echo Cloning repo...
git clone https://%GH_TOKEN%@github.com/%GH_USER%/%REPO%.git .
if %errorlevel% NEQ 0 (
    echo ERROR: Could not clone repo. Check token and repo name.
    pause
    exit /b 1
)

REM Create project folder if it doesn't exist
if not exist "%PROJECT_PATH%" mkdir "%PROJECT_PATH%"

REM Copy all relevant files from source folder
echo Copying project files...
for %%f in ("%SOURCE_DIR%*.xlsx" "%SOURCE_DIR%*.docx" "%SOURCE_DIR%*.pdf" "%SOURCE_DIR%*.md" "%SOURCE_DIR%*.csv" "%SOURCE_DIR%*.bat") do (
    if exist "%%f" (
        echo Adding: %%~nxf
        copy "%%f" "%PROJECT_PATH%\%%~nxf" /y
    )
)

REM Git config
git config user.email "jeffrey@bushlegacybuilders.com"
git config user.name "Jeffrey Bickish"

REM Commit and push
git add %PROJECT_PATH%\
git status
git commit -m "Update %PROJECT_PATH% docs - %date%"
git push https://%GH_TOKEN%@github.com/%GH_USER%/%REPO%.git %BRANCH%

echo.
if %errorlevel% EQU 0 (
    echo SUCCESS: Files pushed to github.com/%GH_USER%/%REPO%/tree/%BRANCH%/%PROJECT_PATH%
) else (
    echo ERROR: Push failed. See messages above.
)

REM Cleanup temp
cd /d "%SOURCE_DIR%"
rmdir /s /q "%WORK_DIR%"
pause
