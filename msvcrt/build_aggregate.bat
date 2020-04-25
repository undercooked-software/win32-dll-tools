@ECHO OFF
PUSHD ..
CALL env_init.bat
XCOPY /S /I %BIN_PATH% "msvcrt/bin"
POPD

SETLOCAL
::
SET AGGREGATE_FILE="msvcrt_aggregate"

CL /c "%AGGREGATE_FILE%.cpp"
REM "Build for x86."
IF ^
"%Platform%"=="x86" %{%
	LIB /NOLOGO "%AGGREGATE_FILE%.obj" "%BIN_PATH_X86%\msvcrt.lib" /OUT:"msvcrt.lib" /MACHINE:X86
	REM }
%}%
REM "Build for x64."
IF ^
"%Platform%"=="x64" %{%
	LIB /NOLOGO "%AGGREGATE_FILE%.obj" "%BIN_PATH_X64%\msvcrt.lib" /OUT:"msvcrt.lib" /MACHINE:X64
	REM }
%}%
::
ENDLOCAL

