@echo off
cd /d %~dp0
echo Starting Lesson Editor...
echo.

REM Check if Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo Python is not installed or not in PATH!
    echo Please install Python from https://python.org
    pause
    exit /b 1
)

REM Check if required packages are available
echo Checking dependencies...
python -c "import PyQt6, yaml" >nul 2>&1
if errorlevel 1 (
    echo Installing required packages...
    pip install PyQt6 PyYAML
    if errorlevel 1 (
        echo Failed to install packages!
        echo Please run: pip install PyQt6 PyYAML
        pause
        exit /b 1
    )
)

REM Launch the lesson editor
echo Launching Lesson Editor...
python lesson_editor.py

REM Keep window open if there's an error
if errorlevel 1 (
    echo.
    echo An error occurred while running the lesson editor.
    pause
)