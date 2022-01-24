@ECHO OFF
SETLOCAL
  REM %~f0 is the fully qualified path for the index given that cooresponds to the argument passed via CLI.
  REM This can be viewed as [drive]:\[path]\[file] for argument index 0.
  SET PARENT_FILE=%~f0
  CALL env_init.bat %PARENT_FILE%

  SET DEF_FILE=%~1
  IF NOT EXIST "%DEF_FILE%" (
    CALL :ExportsNotFound
    EXIT /B
  )

  FOR /F "tokens=1,2 delims=\" %%a IN ("%DEF_FILE%") DO (
    SET FILENAME=%%a
  )

  CALL :MakeDirectories

  PUSHD %TOOLCHAIN_SETUP_PATH%
    CALL "setup_cl_generic.bat" x64
  POPD

  LIB /NOLOGO /DEF:%~1 /OUT:%BIN_PATH_X86%\%FILENAME%.lib /MACHINE:X86
  LIB /NOLOGO /DEF:%~1 /OUT:%BIN_PATH_X64%\%FILENAME%.lib /MACHINE:X64

  GOTO :Clean
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