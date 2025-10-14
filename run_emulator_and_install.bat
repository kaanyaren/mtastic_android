@echo off
rem run_emulator_and_install.bat - starts emulator (creates if needed) and installs the app (Fdroid debug).
rem Edit SDK_DIR or JAVA_HOME at top if different on your machine.

setlocal

n
rem --- Configuration: adjust these if needed ---
set "SDK_DIR=D:\Android_SDK"
set "JAVA_HOME=C:\Program Files\Java\jdk-25"
set "AVD_NAME=meshtastic_avd"
set "SYS_IMG=system-images;android-33;google_apis;x86_64"

necho Using SDK_DIR=%SDK_DIR%
echo Using JAVA_HOME=%JAVA_HOME%

nrem Add JDK and SDK tools to PATH for this session
set "PATH=%JAVA_HOME%\bin;%SDK_DIR%\platform-tools;%SDK_DIR%\emulator;%PATH%"

necho Java version:
java -version 2>&1

necho.

necho Checking for sdkmanager...
if exist "%SDK_DIR%\cmdline-tools\latest\bin\sdkmanager.bat" (
  set "SDKMAN=%SDK_DIR%\cmdline-tools\latest\bin\sdkmanager.bat"
) else if exist "%SDK_DIR%\tools\bin\sdkmanager.bat" (
  set "SDKMAN=%SDK_DIR%\tools\bin\sdkmanager.bat"
) else (
  echo ERROR: sdkmanager not found under %SDK_DIR%. Ensure Android SDK command-line tools are installed.
  pause
  exit /b 1
)

necho Using sdkmanager: %SDKMAN%

necho Installing platform-tools, emulator, platform (android-33) and system image (this may prompt for license acceptance)...
"%SDKMAN%" "platform-tools" "emulator" "platforms;android-33" "%SYS_IMG%"

necho.

necho Checking for avd existence...
emulator -list-avds 2>nul | findstr /i "%AVD_NAME%" >nul
if errorlevel 1 (
  echo AVD %AVD_NAME% not found. Attempting to create...
  if exist "%SDK_DIR%\tools\bin\avdmanager.bat" (
    "%SDK_DIR%\tools\bin\avdmanager.bat" create avd -n %AVD_NAME% -k "%SYS_IMG%" -d "pixel" --force
  ) else if exist "%SDK_DIR%\cmdline-tools\latest\bin\avdmanager.bat" (
    "%SDK_DIR%\cmdline-tools\latest\bin\avdmanager.bat" create avd -n %AVD_NAME% -k "%SYS_IMG%" -d "pixel" --force
  ) else (
    echo WARNING: avdmanager not found; please create an AVD using Android Studio's AVD Manager and name it %AVD_NAME%.
  )
) else (
  echo AVD %AVD_NAME% exists.
)

necho Starting emulator %AVD_NAME%...
start "Emulator" "%SDK_DIR%\emulator\emulator.exe" -avd %AVD_NAME% -no-snapshot -no-boot-anim -gpu host

necho Waiting for emulator to become ready (this can take 20-60s)...
%SDK_DIR%\platform-tools\adb.exe wait-for-device

nset BOOT_COMPLETED=
:wait_loop
nfor /f "delims=" %%i in ('%SDK_DIR%\platform-tools\adb.exe shell getprop sys.boot_completed 2^>nul') do set BOOT_COMPLETED=%%i
if "%BOOT_COMPLETED%"=="1" goto booted
echo Booting... sleeping 5s
ping -n 6 127.0.0.1 >nul
goto wait_loop
:booted
echo Emulator booted.

necho Building and installing app (Fdroid debug)...
cd /d "%~dp0"
.\gradlew clean installFdroidDebug --no-daemon
if %ERRORLEVEL% neq 0 (
  echo Gradle install failed with error %ERRORLEVEL%.
  echo Try running: .\gradlew assembleFdroidDebug --stacktrace --info
  pause
  exit /b %ERRORLEVEL%
)

necho Launching app (package: com.geeksville.mesh)...
%SDK_DIR%\platform-tools\adb.exe shell monkey -p com.geeksville.mesh -c android.intent.category.LAUNCHER 1

necho Done.
pause
endlocal

