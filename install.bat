@echo off
title Medical App - Full Auto Setup
color 0A

echo.
echo  ==========================================
echo   Medical Image Recognition App
echo   Full Auto Setup
echo  ==========================================
echo.

REM ---- Python check ----
python --version >nul 2>&1
if %errorlevel% == 0 (
    echo  [OK] Python pehle se installed hai!
    echo.
    goto INSTALL_PACKAGES
)

REM ---- Python nahi mila, download karenge ----
echo  [..] Python nahi mila...
echo  [..] Internet se download ho raha hai, ruko...
echo.

curl -o "%TEMP%\python_installer.exe" https://www.python.org/ftp/python/3.12.10/python-3.12.10-amd64.exe

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Download fail hua!
    echo  Internet connection check karo aur dobara chalao.
    echo.
    pause
    exit /b
)

echo  [OK] Download ho gaya!
echo  [..] Python install ho raha hai, ruko...
echo.

"%TEMP%\python_installer.exe" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Python install fail hua!
    echo  Manually install karo: https://www.python.org/downloads/
    echo  Install karte waqt "Add Python to PATH" ZAROOR tick karna!
    echo.
    pause
    exit /b
)

del "%TEMP%\python_installer.exe"
set "PATH=%PATH%;C:\Program Files\Python312;C:\Program Files\Python312\Scripts"

echo  [OK] Python install ho gaya!
echo.

REM ---- Packages install ----
:INSTALL_PACKAGES
echo  [..] Packages install ho rahe hain, ruko...
echo      (flask, google-genai, pillow etc.)
echo.

python -m pip install --upgrade pip --quiet --no-warn-script-location

python -m pip install flask python-dotenv Pillow google-genai --quiet --no-warn-script-location

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Packages install fail hua!
    echo  Internet check karo aur dobara chalao.
    echo.
    pause
    exit /b
)

echo  [OK] Sab packages install ho gaye!
echo.

REM ---- .env check ----
if not exist .env (
    echo  ==========================================
    echo   Gemini API Key chahiye!
    echo  ==========================================
    echo.
    echo  Yahan se FREE API key lo:
    echo  https://aistudio.google.com/apikey
    echo.
    echo  1. Link kholo
    echo  2. "Create API Key" click karo
    echo  3. Key copy karo
    echo  4. Neeche paste karo
    echo.
    set /p APIKEY="  API Key yahan paste karo: "
    echo GEMINI_API_KEY=%APIKEY%> .env
    echo.
    echo  [OK] .env file ban gayi!
    echo.
)

REM ---- App start ----
echo  ==========================================
echo   App start ho rahi hai...
echo  ==========================================
echo.
echo  Browser mein khulega: http://127.0.0.1:5000
echo  Band karna ho to:     CTRL+C dabaao
echo.
echo  ==========================================
echo.

timeout /t 3 >nul
start http://127.0.0.1:5000
python app.py

pause