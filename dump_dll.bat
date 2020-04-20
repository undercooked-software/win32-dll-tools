@ECHO OFF
CALL env_init.bat

SETLOCAL
::
SET DLL_FILE=%~1

IF NOT ^
EXIST "%DLL_FILE%" %{%
        CALL :DLLNotFound
        GOTO :EOF
        REM }
%}%

FOR /F "tokens=1,2 delims=." %%a IN ("%DLL_FILE%")^
DO %{%
        SET FILENAME=%%a
        REM }
%}%

SET EXPORT_FILE="%FILENAME%.exp"

dumpbin /exports %DLL_FILE% > %EXPORT_FILE%

GOTO :EOF
::
ENDLOCAL

:DLLNotFound
debug_error.cmd %*
GOTO :EOF