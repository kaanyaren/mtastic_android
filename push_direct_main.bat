
@echo off
REM push_direct_main.bat - Safely create a temp branch, commit local changes, push and merge to main.
REM Usage: push_direct_main.bat "Commit message here"

nsetlocal enabledelayedexpansion

n:: Default commit message if not provided
nif "%~1"=="" (
  set "COMMIT_MSG=Apply local changes"
) else (
  set "COMMIT_MSG=%~1"
)

necho Repository root: %~dp0
cd /d "%~dp0"
necho Current branch:
git branch --show-current

necho.
echo Checking working tree status...
git status --porcelain
n
necho.
echo Creating temporary branch...
set "TIMESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%"
set "TEMP_BRANCH=push-temp-%TIMESTAMP%"
echo Creating and switching to %TEMP_BRANCH%...
ngit checkout -b %TEMP_BRANCH%
if errorlevel 1 (
  echo Failed to create branch %TEMP_BRANCH%. Aborting.
  pause
  exit /b 1
)

necho Adding changes...
ngit add -A

necho Committing with message: "%COMMIT_MSG%"
ngit commit -m "%COMMIT_MSG%"
if errorlevel 1 (
  echo Nothing to commit or commit failed. Showing git status and exiting.
  git status --porcelain
  pause
  exit /b 0
)

necho Pushing temporary branch to origin...
ngit push -u origin %TEMP_BRANCH%
if errorlevel 1 (
  echo Push failed. Check authentication or remote rights. Aborting.
  pause
  exit /b 1
)

necho Switching to main and pulling latest...
ngit checkout main
ngit pull origin main
if errorlevel 1 (
  echo Failed to pull origin/main. Resolve issues and try again.
  pause
  exit /b 1
)

necho Merging %TEMP_BRANCH% into main...
ngit merge --no-ff %TEMP_BRANCH% -m "Merge %TEMP_BRANCH% into main: %COMMIT_MSG%"
if errorlevel 1 (
  echo Merge failed (conflict?). Please resolve conflicts manually. Aborting.
  pause
  exit /b 1
)

necho Pushing main to origin...
ngit push origin main
if errorlevel 1 (
  echo Push to origin/main failed. Possibly branch protection or permission error. Aborting.
  pause
  exit /b 1
)

necho Deleting temporary branch locally and remotely...
ngit branch -d %TEMP_BRANCH%
ngit push origin --delete %TEMP_BRANCH%

necho Done. main has been updated and pushed to origin.
npause
endlocal

