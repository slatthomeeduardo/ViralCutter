@echo off
setlocal
cd /d "%~dp0"

echo ==========================================
echo Instalando uv (Gerenciador de pacotes rapido Python)...
echo ==========================================
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
set "PATH=%USERPROFILE%\.local\bin;%PATH%"

echo.
echo ==========================================
echo Criando ambiente virtual (.venv com Python 3.11)...
echo ==========================================
:: Tenta usar o uv do PATH. Deleta o ambiente antigo se existir para nao dar conflito.
if exist .venv (
    echo Removendo ambiente virtual antigo ...
    rmdir /s /q .venv
)
uv venv --python 3.11
echo.
echo ==========================================
echo CONFIGURACAO DE PLACA DE VIDEO
echo ==========================================
echo Qual e a sua Placa de Video?
echo [1] NVIDIA (Instala com aceleracao CUDA - Mais rapido)
echo [2] AMD / Intel / CPU (Instala versao otimizada para processador)
set /p gpu_choice="Escolha (1/2): "

if "%gpu_choice%"=="1" (
    echo.
    echo Instalando PyTorch e ONNX para NVIDIA CUDA...
    uv pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cu124
    uv pip install onnxruntime-gpu==1.20.1
    uv pip install -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu124
) else (
    echo.
    echo Instalando PyTorch e ONNX para CPU / Intel / AMD...
    uv pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cpu
    uv pip install onnxruntime==1.20.1
    uv pip install -r requirements.txt
)

echo.
echo ==========================================
echo Concluido com sucesso!
echo Para rodar a interface Web, execute: run_webui.bat
echo Para rodar via linha de comando, execute: run.bat
echo ==========================================
pause
