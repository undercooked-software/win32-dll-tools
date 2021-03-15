@ECHO OFF
IF "%~1" == "" (
  ECHO The path to the parent script is missing.
  EXIT /B
)

:: Ultimately, we want to do a check here on a persistent environment variable containing %%~f of the parent script.
:: We would do a comparison between %~1 and the %%~f contained in the persistent variable to make sure they are equal.
:: Doing this would prevent env_init.bat from being called in the command-line with a valid %~1 passed.
:: This file would then perform cleanup of that persistent environment variable after finishing initialization.

SETLOCAL
  REM This check would be skipped in the event that the %~1 parameter is empty.
  FOR %%? IN (%~1) DO (
    REM ECHO FQP=%%~f?
    REM ECHO extension=%%~x?
    SET PARENT_FOUND=1
    IF NOT "%%~x?" == ".bat"  SET PARENT_FOUND=
    IF NOT EXIST "%%~f?"      SET PARENT_FOUND=
    IF NOT DEFINED PARENT_FOUND (
      ECHO The argument provided does not point to a parent script.
      EXIT /B
    )
  )
ENDLOCAL

SET CWD=%~dp0
SET QUIET=^>nul 2^>nul

SET BIN_PATH=bin
SET BIN_PATH_X86=%BIN_PATH%\x86
SET BIN_PATH_X64=%BIN_PATH%\x64

REM The majority of our scripts have a dependency on our msvc-no-vcvars compiler toolchain setup.
REM There is no harm in placing this here as this part only can no longer pollute ENV
SET TOOLCHAIN_SETUP_PATH="C:\dev_tools\bin\msvc-no-vcvars"

EXIT /B