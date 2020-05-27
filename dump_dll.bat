@ECHO OFF
SETLOCAL
SET CWD=%~dp0
SET QUIET=^>nul 2^>nul

SET DLL_FILE=%~1
IF NOT EXIST "%DLL_FILE%" GOTO :DLLNotFound

FOR /F "tokens=1,2 delims=." %%a IN ("%DLL_FILE%") DO (SET DLL_DIR=%%a)
FOR /F "delims=" %%a in ("%DLL_DIR%") DO (SET OUTPUT_DIR=%CWD%%%~na)
MKDIR %OUTPUT_DIR% %QUIET%

REM "If you wish to have a full disassembly, use /ALL instead of /EXPORTS."
DUMPBIN /NOLOGO /EXPORTS %DLL_FILE% > "%OUTPUT_DIR%\dump.exp"
GOTO :EOF
ENDLOCAL

:DLLNotFound
debug_error.cmd %*
GOTO :EOF