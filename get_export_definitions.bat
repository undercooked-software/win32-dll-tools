@ECHO OFF
SETLOCAL
SET EXPORTS_HEADER_LEN=19
SET EXPORTS_FILE=%~1

IF NOT EXIST "%EXPORTS_FILE%" GOTO :ExportsNotFound

REM "Split file name at '.' delimiter "
FOR /F "tokens=1,2 delims=." %%a IN ("%EXPORTS_FILE%") DO (SET FILENAME=%%a)

SET OUTPUT_FILE="%FILENAME%.def"

@ECHO Generating file: %OUTPUT_FILE%
@ECHO EXPORTS > %OUTPUT_FILE%
FOR /F "usebackq tokens=4 skip=%EXPORTS_HEADER_LEN% delims= " %%d IN (%EXPORTS_FILE%) DO (
	@ECHO %%d >> %OUTPUT_FILE%
)

GOTO :EOF
ENDLOCAL

:ExportsNotFound
debug_error.cmd %*
GOTO :EOF