@echo off
REM ====================================================================
REM  COMPILADOR AUTOMÁTICO - REVIT PLUGIN DETECÇÃO DE COLISÃO
REM  Este script compila automaticamente o projeto
REM  Não precisa abrir Visual Studio!
REM ====================================================================

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║         COMPILADOR AUTOMÁTICO - PLUGIN REVIT 2024             ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM Procura MSBuild
echo [INFO] Procurando MSBuild...

set "MSBUILD_PATH="

REM Tenta Visual Studio 2022
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" (
    set "MSBUILD_PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
    echo [OK] Encontrado: Visual Studio 2022 Community
    goto :MSBUILD_FOUND
)

REM Tenta Visual Studio 2022 Professional
if exist "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" (
    set "MSBUILD_PATH=C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe"
    echo [OK] Encontrado: Visual Studio 2022 Professional
    goto :MSBUILD_FOUND
)

REM Tenta Visual Studio 2019
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" (
    set "MSBUILD_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
    echo [OK] Encontrado: Visual Studio 2019 Community
    goto :MSBUILD_FOUND
)

echo.
echo [ERRO] MSBuild não encontrado!
echo.
echo Você precisa ter Visual Studio 2019+ instalado.
echo.
echo Download: https://visualstudio.microsoft.com/pt-br/downloads/
echo.
echo Após instalar, execute este script novamente.
echo.
pause
exit /b 1

:MSBUILD_FOUND

echo.
echo [INFO] Iniciando compilação...
echo.

REM Compila em Release
"%MSBUILD_PATH%" "RevitPluginColisao.csproj" /p:Configuration=Release /p:Platform=AnyCPU

if %errorLevel% neq 0 (
    echo.
    echo ╔════════════════════════════════════════════════════════════════╗
    echo ║                   ERRO NA COMPILAÇÃO                          ║
    echo ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo Possíveis causas:
    echo   1. Revit SDK 2024 não está instalado
    echo   2. Caminhos do .csproj precisam atualização
    echo   3. Falta alguma dependência
    echo.
    echo Solução:
    echo   1. Verifique o arquivo RevitPluginColisao.csproj
    echo   2. Confirme os caminhos do Revit SDK
    echo   3. Procure por erros vermelhos acima
    echo.
    pause
    exit /b 1
)

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║              COMPILAÇÃO CONCLUÍDA COM SUCESSO!               ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM Verifica se o DLL foi criado
if exist "bin\Release\RevitPluginColisao.dll" (
    echo [OK] Arquivo gerado: bin\Release\RevitPluginColisao.dll
    echo.
    echo Próximos passos:
    echo   1. Feche o Revit completamente
    echo   2. Execute: InstallPlugin.bat
    echo   3. Abra o Revit
    echo   4. Procure por "Detectar Colisões" em Add-Ins
    echo.
) else (
    echo [ERRO] DLL não foi criado. Verifique os erros acima.
    echo.
)

pause
