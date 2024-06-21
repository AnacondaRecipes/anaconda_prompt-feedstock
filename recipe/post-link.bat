@ECHO OFF

REM The menuinst v2 json file is not compatible with menuinst versions
REM older than 2.1.0. Copy the appropriate file as the menu file.

SET LOGFILE=%PREFIX%\.messages.txt

REM Cannot use usual FOR-loop way to assign output of command because
REM prefixes with spaces in the name cannot be properly escaped.
"%CONDA_PYTHON_EXE%" -c "import menuinst, sys; sys.exit(1 if tuple(int(x) for x in menuinst.__version__.split(\".\"))[:3] < (2, 1, 0) else 0)"
IF %ERRORLEVEL% == 1 GOTO :menuinst_too_old
GOTO :exit

:menuinst_too_old:
    ECHO. >> %LOGFILE%
    ECHO This package requires menuinst v2.1.0 in the base environment. >> %LOGFILE%
    ECHO Please update menuinst in the base environment and reinstall %PKG_NAME%. >> %LOGFILE%
    GOTO :exit

:exit
    EXIT /B %ERRORLEVEL%
