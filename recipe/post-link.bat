@ECHO OFF

REM The menuinst v2 json file is not compatible with menuinst versions
REM older than 2.1.0. Copy the appropriate file as the menu file.

SET LOGFILE="%PREFIX%\.messages.txt"

FOR /F "delims=" %%i IN (
    '"%CONDA_PYTHON_EXE%" -c "import menuinst; print(tuple(int(x) for x in menuinst.__version__.split(\".\"))[:3] < (2, 1, 0))"'
) DO (
    IF "%%~i"=="True" GOTO :menuinst_too_old
)
GOTO :exit

:menuinst_too_old:
    ECHO. >> "%LOGFILE%"
    ECHO This package requires menuinst v2.1.0 in the base environment. >> "%LOGFILE%"
    ECHO Please update menuinst in the base environment and reinstall %PKG_NAME%. >> "%LOGFILE%"
    GOTO :exit

:exit
    EXIT /B %ERRORLEVEL%
