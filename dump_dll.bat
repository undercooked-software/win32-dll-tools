@ECHO OFF
SETLOCAL
  REM %~f0 is the fully qualified path for the index given that cooresponds to the argument passed via CLI.
  REM This can be viewed as [drive]:\[path]\[file] for argument index 0.
  SET PARENT_FILE=%~f0
  CALL env_init.bat %PARENT_FILE%

  EXIT /B
  
  SET DLL_FILE=%~f1
  IF NOT EXIST "%DLL_FILE%" (
    CALL :DLLNotFound
    EXIT /B
  )
  
  FOR /F "delims=." %%a IN ("%DLL_FILE%") DO (SET DLL_DIR=%%a)
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