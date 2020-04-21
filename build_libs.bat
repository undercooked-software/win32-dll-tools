@ECHO OFF
CALL env_init.bat

SETLOCAL
::
CALL :MakeDirectories

SET DEF_FILE=%~1

IF NOT ^
EXIST "%DEF_FILE%" %{%
        CALL :ExportsNotFound
        GOTO :EOF
        REM }
%}%

FOR /F "tokens=1,2 delims=." %%a IN ("%DEF_FILE%")^
DO %{%
        SET FILENAME=%%a
        REM }
%}%

LIB /NOLOGO /DEF:%~1 /OUT:%BIN_PATH_X86%\%FILENAME%.lib /MACHINE:X86
LIB /NOLOGO /DEF:%~1 /OUT:%BIN_PATH_X64%\%FILENAME%.lib /MACHINE:X64

GOTO :Clean
::
ENDLOCAL

:MakeDirectories
MKDIR %BIN_PATH%     %QUIET%
MKDIR %BIN_PATH_X86% %QUIET%
MKDIR %BIN_PATH_X64% %QUIET%
GOTO :EOF

:Clean
DEL %BIN_PATH_X86%\*.exp %QUIET%
DEL %BIN_PATH_X64%\*.exp %QUIET%
GOTO :EOF

:ExportsNotFound
debug_error.cmd %*
GOTO :EOF