@echo off
REM ====================================================================
REM  DESINSTALADOR - REVIT PLUGIN DE DETECÇÃO DE COLISÃO
REM  Revit 2024+
REM ====================================================================

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║   DESINSTALADOR - PLUGIN DETECÇÃO DE COLISÃO - REVIT 2024     ║
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

echo [INFO] Versão Revit:  %REVIT_VERSION%
echo [INFO] Caminho:       %ADDON_PATH%
echo.

REM Verifica se o plugin está instalado
if not exist "%ADDON_PATH%\%DLL_FILE%" (
    echo [AVISO] Plugin não encontrado em: %ADDON_PATH%
    echo Talvez já tenha sido desinstalado.
    echo.
    pause
    exit /b 0
)

REM Deleta arquivos
echo [INFO] Removendo arquivos...
del "%ADDON_PATH%\%DLL_FILE%" /F /Q 2>nul
if %errorLevel% neq 0 (
    echo [ERRO] Não foi possível deletar: %DLL_FILE%
    echo O arquivo pode estar em uso. Feche o Revit completamente e tente novamente.
    pause
    exit /b 1
)

del "%ADDON_PATH%\%ADDIN_FILE%" /F /Q 2>nul
if %errorLevel% neq 0 (
    echo [ERRO] Não foi possível deletar: %ADDIN_FILE%
    pause
    exit /b 1
)

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║             DESINSTALAÇÃO CONCLUÍDA COM SUCESSO!              ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo Arquivos removidos de:
echo   %ADDON_PATH%
echo.
echo Na próxima vez que iniciar o Revit, o plugin não estará disponível.
echo.
pause
