@ECHO OFF
IF "%~1" == "" (
  ECHO A fully qualified path to a parent script is missing.
  EXIT /B
)

REM This check would be skipped in the event that the %~1 parameter failed to exist.
:: Ultimately, we want to make this check be done on a persistent variable containing %%~f of the parent script.
:: This file would then perform cleanup of that persistent variable after initializing the environment.
FOR %%? IN (%~1) DO (
  REM ECHO FQP=%%~f?
  REM ECHO extension=%%~x?
  IF NOT "%%~x?" == ".bat" (
    ECHO The argument provided does not point to a parent script.
    EXIT /B
  )
)

REM Just in case we CALL env_init.bat, we can grab env_init as the function name
FOR /F "tokens=1 delims=." %%A IN ("%~0") DO (SET FUNC_NAME=%%A)
REM Can't call :ENV_INIT via :env_init, so we capitilize the whole thing.
REM https://www.robvanderwoude.com/battech_convertcase.php describes this approach.
FOR /F "tokens=2 delims=-" %%A IN ('FIND "" "%FUNC_NAME%" 2^>^&1') DO (
  SET FUNC=%%A
  SET "FUNC_NAME="
)
SET FUNC=%FUNC: =%
CALL :%FUNC%
SET "FUNC="
EXIT /B

:ENV_INIT
  SET CWD=%~dp0
  SET QUIET=^>nul 2^>nul
  
  SET BIN_PATH=bin
  SET BIN_PATH_X86=%BIN_PATH%\x86
  SET BIN_PATH_X64=%BIN_PATH%\x64