@echo off
REM ====================================================================
REM  INSTALADOR - REVIT PLUGIN DE DETECÇÃO DE COLISÃO
REM  Revit 2024+
REM ====================================================================

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║    INSTALADOR - PLUGIN DETECÇÃO DE COLISÃO - REVIT 2024       ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM Verifica permissão de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo [ERRO] Este script precisa ser executado como Administrador!
    echo Clique com botão direito no arquivo .bat e selecione "Executar como administrador"
    echo.
    pause
    exit /b 1
)

REM Define variáveis
set "REVIT_VERSION=2024"
set "ADDON_PATH=%ProgramData%\Autodesk\Revit\Addins\%REVIT_VERSION%"
set "DLL_FILE=RevitPluginColisao.dll"
set "ADDIN_FILE=RevitPluginColisao.addin"
set "SOURCE_DIR=%~dp0"

echo [INFO] Versão Revit:  %REVIT_VERSION%
echo [INFO] Caminho Dest:  %ADDON_PATH%
echo [INFO] Fonte:         %SOURCE_DIR%
echo.

REM Verifica se o arquivo .dll existe
if not exist "%SOURCE_DIR%bin\Release\%DLL_FILE%" (
    echo [ERRO] Arquivo não encontrado: %SOURCE_DIR%bin\Release\%DLL_FILE%
    echo.
    echo Você precisa compilar o projeto no Visual Studio primeiro:
    echo 1. Abra o arquivo .sln no Visual Studio
    echo 2. Selecione "Release" na barra de ferramentas
    echo 3. Pressione F7 (Build Solution)
    echo 4. Execute este script novamente
    echo.
    pause
    exit /b 1
)

REM Cria diretório se não existir
if not exist "%ADDON_PATH%" (
    echo [INFO] Criando diretório: %ADDON_PATH%
    mkdir "%ADDON_PATH%"
    if %errorLevel% neq 0 (
        echo [ERRO] Não foi possível criar o diretório. Tente executar como Administrador.
        pause
        exit /b 1
    )
)

REM Copia arquivos
echo [INFO] Copiando arquivos...
copy "%SOURCE_DIR%bin\Release\%DLL_FILE%" "%ADDON_PATH%\%DLL_FILE%" /Y
if %errorLevel% neq 0 (
    echo [ERRO] Falha ao copiar DLL
    pause
    exit /b 1
)

copy "%SOURCE_DIR%%ADDIN_FILE%" "%ADDON_PATH%\%ADDIN_FILE%" /Y
if %errorLevel% neq 0 (
    echo [ERRO] Falha ao copiar arquivo .addin
    pause
    exit /b 1
)

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║              INSTALAÇÃO CONCLUÍDA COM SUCESSO!                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo Arquivos instalados em:
echo   %ADDON_PATH%
echo.
echo Próximos passos:
echo   1. Feche o Revit completamente (se estiver aberto)
echo   2. Abra o Revit novamente
echo   3. Procure pela guia "Add-Ins" e clique em "Detectar Colisões"
echo.
echo Para desinstalar, execute "UninstallPlugin.bat"
echo.
pause
