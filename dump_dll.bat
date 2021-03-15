@ECHO OFF
SETLOCAL
  CALL env_init.bat %~f0
  
  SET DLL_FILE=%~f1
  IF NOT EXIST "%DLL_FILE%" (
    CALL :DLLNotFound
    EXIT /B
  )
  
  FOR /F "tokens=1,2 delims=." %%a IN ("%DLL_FILE%") DO (SET DLL_DIR=%%a)
  FOR /F "delims=" %%a in ("%DLL_DIR%") DO (SET OUTPUT_DIR=%CWD%%%~na)
  MKDIR %OUTPUT_DIR% %QUIET%

  PUSHD %TOOLCHAIN_SETUP_PATH%
    CALL "setup_cl_generic.bat" x64
  POPD
  
  REM If you wish to have a full disassembly, use /ALL instead of /EXPORTS.
  DUMPBIN /NOLOGO /EXPORTS %DLL_FILE% > "%OUTPUT_DIR%\dump.exp"
ENDLOCAL

:: ========== FUNCTIONS ==========
EXIT /B

:DLLNotFound
  debug_error.cmd
  GOTO :EOF