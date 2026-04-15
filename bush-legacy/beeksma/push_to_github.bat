@echo off
REM ============================================================
REM  Beeksma Project — Push to GitHub
REM  Repo: github.com/jbickish7464/cowork-projects
REM  Path: bush-legacy/beeksma/
REM  Run this from Windows Terminal or Command Prompt
REM ============================================================

SET GH_TOKEN=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
SET GH_USER=jbickish7464
SET REPO=cowork-projects
SET BRANCH=main
SET SOURCE_DIR=%~dp0
SET WORK_DIR=%TEMP%\beeksma-github-push

echo.
echo === Beeksma GitHub Push ===
echo Source: %SOURCE_DIR%
echo Target: github.com/%GH_USER%/%REPO%/bush-legacy/beeksma/
echo.

REM Clean up any previous temp work
if exist "%WORK_DIR%" rmdir /s /q "%WORK_DIR%"
mkdir "%WORK_DIR%"
cd /d "%WORK_DIR%"

REM Try to clone existing repo first
echo Checking if repo exists...
git clone https://%GH_TOKEN%@github.com/%GH_USER%/%REPO%.git . 2>nul
if %errorlevel% NEQ 0 (
    echo Repo not found or empty — initializing new repo...
    git init
    git remote add origin https://%GH_TOKEN%@github.com/%GH_USER%/%REPO%.git
    git checkout -b %BRANCH%
)

REM Create target folder path
if not exist "bush-legacy\beeksma" mkdir "bush-legacy\beeksma"

REM Copy session-created files
echo Copying project files...
copy "%SOURCE_DIR%README.md" "bush-legacy\beeksma\README.md" /y
copy "%SOURCE_DIR%Beeksma Procurement Selection Status 2026-04-06.xlsx" "bush-legacy\beeksma\Beeksma Procurement Selection Status 2026-04-06.xlsx" /y

REM Copy any other .xlsx, .docx, .pdf, .md files from source (not the big subfolder)
for %%f in ("%SOURCE_DIR%*.xlsx" "%SOURCE_DIR%*.docx" "%SOURCE_DIR%*.pdf" "%SOURCE_DIR%*.md" "%SOURCE_DIR%*.csv") do (
    if exist "%%f" (
        echo   Adding: %%~nxf
        copy "%%f" "bush-legacy\beeksma\%%~nxf" /y
    )
)

REM Git config
git config user.email "jeffrey@bushlegacybuilders.com"
git config user.name "Jeffrey Bickish"

REM Add and commit
git add bush-legacy/beeksma/
git status
git commit -m "Update Beeksma project docs - %date% %time%"

REM Push
echo.
echo Pushing to GitHub...
git push https://%GH_TOKEN%@github.com/%GH_USER%/%REPO%.git %BRANCH% --set-upstream

echo.
if %errorlevel% EQU 0 (
    echo SUCCESS! Files pushed to github.com/%GH_USER%/%REPO%/tree/%BRANCH%/bush-legacy/beeksma
) else (
    echo ERROR: Push failed. Check that the repo exists at github.com/%GH_USER%/%REPO%
    echo You may need to create it first at https://github.com/new
    echo Repo name: %REPO%   Visibility: Private recommended
)

REM Cleanup
cd /d "%SOURCE_DIR%"
rmdir /s /q "%WORK_DIR%"

pause
