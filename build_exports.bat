@ECHO OFF
SETLOCAL
  REM I'm unsure if the dll dump containing the exported functions always has a header length of 16 lines.
  SET EXPORTS_HEADER_LEN=16
  SET EXPORTS_FILE=%~1

  SET EXPORTS_FOUND=1
  IF NOT "%~x1" == ".exp" SET EXPORTS_FOUND=
  IF NOT EXIST "%~f1"     SET EXPORTS_FOUND=
  IF NOT DEFINED EXPORTS_FOUND (
    CALL :ExportsNotFound
    EXIT /B
  )

  SET EXPORTS_FILE=%~1
  SET OUTPUT_FILE="%EXPORTS_FILE:exp=def%"
  
  ECHO Generating file: %OUTPUT_FILE%
  ECHO EXPORTS > %OUTPUT_FILE%
  FOR /F "usebackq tokens=4 skip=%EXPORTS_HEADER_LEN% delims= " %%d IN (%EXPORTS_FILE%) DO (
    ECHO %%d >> %OUTPUT_FILE%
  )
ENDLOCAL

:: ========== FUNCTIONS ==========
EXIT /B

:ExportsNotFound
  debug_error.cmd
  GOTO :EOF