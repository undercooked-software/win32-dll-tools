@ECHO OFF
SETLOCAL
  REM %~f0 is the fully qualified path for the index given that cooresponds to the argument passed via CLI.
  REM This can be viewed as [drive]:\[path]\[file] for argument index 0.
  SET PARENT_FILE=%~f0
  CALL env_init.bat %PARENT_FILE%
  
  SET DLL_FOUND=1
  IF NOT "%~x1" == ".dll" SET DLL_FOUND=
  IF NOT EXIST "%~f1"     SET DLL_FOUND=
  IF NOT DEFINED DLL_FOUND (
    CALL :DLLNotFound
    EXIT /B
  )

  SET DLL_FILE=%~f1
  SET OUTPUT_PATH=%DLL_FILE:.dll=%
  MKDIR %OUTPUT_PATH% %QUIET%

  PUSHD %TOOLCHAIN_SETUP_PATH%
    CALL "setup_cl_generic.bat" x64
  POPD

  SET OUTPUT_FILE="%OUTPUT_PATH%\dump.exp"
  DUMPBIN /NOLOGO /EXPORTS %DLL_FILE% > %OUTPUT_FILE%
ENDLOCAL

:: ========== FUNCTIONS ==========
EXIT /B

:DLLNotFound
  debug_error.cmd
  GOTO :EOF