@ECHO OFF
SETLOCAL
  REM ECHO %%~f0 in dump_dll.bat = %~f0
  CALL env_init.bat %~f0
  ECHO %CWD%
  EXIT /B
  
  SET DLL_FILE=%~f1
  IF NOT EXIST "%DLL_FILE%" (
    CALL :DLLNotFound
    EXIT /B
  )
  
  FOR /F "tokens=1,2 delims=." %%a IN ("%DLL_FILE%") DO (SET DLL_DIR=%%a)
  FOR /F "delims=" %%a in ("%DLL_DIR%") DO (SET OUTPUT_DIR=%CWD%%%~na)
  MKDIR %OUTPUT_DIR% %QUIET%
  
  REM "If you wish to have a full disassembly, use /ALL instead of /EXPORTS."
  DUMPBIN /NOLOGO /EXPORTS %DLL_FILE% > "%OUTPUT_DIR%\dump.exp"
  GOTO :EOF
ENDLOCAL

REM Until we find different way to do this, we'll use the label trick to call our ENV_INIT function from env_init.bat
:ENV_INIT

:DLLNotFound
  debug_error.cmd
  GOTO :EOF