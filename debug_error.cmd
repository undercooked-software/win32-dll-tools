@ECHO OFF
ECHO This file contains error handling functionality and should not be ran by itself.
:: ========== FUNCTIONS ==========
EXIT /B

:DLLNotFound
SETLOCAL
  SET ERR_MSG="The specified .dll file cannot be found."
  CALL :DebugError %ERR_MSG%
  GOTO :EOF
ENDLOCAL

:ExportsNotFound
SETLOCAL
  SET ERR_MSG="The specified export file could not be found."
  CALL :DebugError %ERR_MSG%
  GOTO :EOF
ENDLOCAL

:DebugError
SETLOCAL
  REM Dequoting the error message in preparation for ECHO.
  SET ERR_MSG=%~1
  ECHO %ERR_MSG%
  GOTO :EOF
ENDLOCAL
