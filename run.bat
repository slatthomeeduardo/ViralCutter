@echo off
setlocal
title ViralCutter - CLI
cd /d "%~dp0"

if not exist ".venv\Scripts\activate.bat" (
    echo [ERRO] Ambiente virtual .venv nao encontrado!
    echo Execute primeiro o instalador: install_dependencies.bat
    pause
    exit /b 1
)

call .venv\Scripts\activate.bat
python main_improved.py
echo.
pause