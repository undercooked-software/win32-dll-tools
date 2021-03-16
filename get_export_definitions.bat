@ECHO OFF
SETLOCAL
	REM I'm unsure if the dll dump containing the exported functions always has a header length of 16 lines.
	SET EXPORTS_HEADER_LEN=16
	SET EXPORTS_FILE=%~1
	IF NOT EXIST "%EXPORTS_FILE%" (
		CALL :ExportsNotFound
		EXIT /B
	)

	FOR /F "tokens=2 delims=." %%b IN ("%EXPORTS_FILE%") DO (
		IF NOT "%%b" == "exp" (
			ECHO The file path passed as an argument does not point to an exports file.
			EXIT /B
		)
		SET OUTPUT_FILE="%EXPORTS_FILE:exp=def%"
	)
	
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