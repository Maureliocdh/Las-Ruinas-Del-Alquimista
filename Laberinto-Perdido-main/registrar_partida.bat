@echo off
REM Script para ejecutar registrar_partida.py desde Godot
REM Uso: registrar_partida.bat "ruta_al_json"

setlocal enabledelayedexpansion

REM Obtener la ruta actual del script
set SCRIPT_DIR=%~dp0
set SCRIPT_PATH=%SCRIPT_DIR%registrar_partida.py
set JSON_PATH=%SCRIPT_DIR%reporte_partida.json

REM Si se proporciona un argumento, usarlo como ruta del JSON
if not "%~1"=="" (
    set JSON_PATH=%~1
)

REM Ejecutar Python
python "%SCRIPT_PATH%" "%JSON_PATH%"

REM Capturar el código de salida
set EXIT_CODE=%ERRORLEVEL%

REM Retornar el código de salida
exit /b %EXIT_CODE%
