REM Script to configure project based on CMake for Windows.
REM 
REM Copyright (c) 2013-2020, Gilles Caulier, <caulier dot gilles at gmail dot com>
REM 
REM Redistribution and use is allowed according to the terms of the BSD license.
REM For details see the accompanying COPYING-CMAKE-SCRIPTS file.

REM The first argument is the method name.
goto %1

REM ----------------------------------------------------------------------
REM --- Method to remove all contents from a directory.
REM     The second argument is the path to the directory to remove

:RemoveDirectoryRecursively

echo Remove '%2' recursively. Please Wait...

:_removedir_

if exist "%2" (
    rd /s /q "%2"
    goto _removedir_
)

echo '%2' removed.

goto _endofscript_

REM ----------------------------------------------------------------------
REM --- For time execution measurement ; startup

:StartScript

set STARTTIME=%TIME%
set STARTTIME=%STARTTIME: =0%
goto _endofscript_

REM ----------------------------------------------------------------------
REM --- For time execution measurement : shutdown

:TerminateScript

set ENDTIME=%TIME%
set ENDTIME=%ENDTIME: =0%
set /A STARTTIME=(1%STARTTIME:~0,2%-100)*360000 + (1%STARTTIME:~3,2%-100)*6000 + (1%STARTTIME:~6,2%-100)*100 + (1%STARTTIME:~9,2%-100)
set /A ENDTIME=(1%ENDTIME:~0,2%-100)*360000 + (1%ENDTIME:~3,2%-100)*6000 + (1%ENDTIME:~6,2%-100)*100 + (1%ENDTIME:~9,2%-100)
set /A DURATION=%ENDTIME%-%STARTTIME%

if %DURATION% == 0 set TIMEDIFF=00:00:00,00 && EXIT /B 0

if %ENDTIME% LSS %STARTTIME% set /A DURATION=%STARTTIME%-%ENDTIME%

set /A DURATIONH=%DURATION% / 360000
set /A DURATIONM=(%DURATION% - %DURATIONH%*360000) / 6000
set /A DURATIONS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000) / 100
set /A DURATIONHS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000 - %DURATIONS%*100)

if %DURATIONH% LSS 10 set DURATIONH=0%DURATIONH%

if %DURATIONM% LSS 10 set DURATIONM=0%DURATIONM%

if %DURATIONS% LSS 10 set DURATIONS=0%DURATIONS%

if %DURATIONHS% LSS 10 set DURATIONHS=0%DURATIONHS%

set TIMEDIFF=%DURATIONH%:%DURATIONM%:%DURATIONS%,%DURATIONHS%

echo Elaspsed time for script execution : (%TIMEDIFF%)

goto _endofscript_

:_endofscript_
