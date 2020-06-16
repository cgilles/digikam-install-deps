@ECHO OFF

REM Script to configure project based on CMake for Windows.
REM 
REM Copyright (c) 2013-2020, Gilles Caulier, <caulier dot gilles at gmail dot com>
REM 
REM Redistribution and use is allowed according to the terms of the BSD license.
REM For details see the accompanying COPYING-CMAKE-SCRIPTS file.

REM load configuration
call config.cmd

REM For elapsed time mesurement
call %ORIG_WD%/common.cmd :StartScript

REM --- Manage directories -------------

if exist "%INSTALL_DIR%" (
    echo Install Directory "%INSTALL_DIR%" already exist. Script aborted...
    goto :eof
)

md "%INSTALL_DIR%"
cd /d "%INSTALL_DIR%"

call %ORIG_WD%/common.cmd :RemoveDirectoryRecursively %BUILDING_DIR%

md "%BUILDING_DIR%"
cd /d "%BUILDING_DIR%"

REM --- Configure the project with CMake ---

cmake -DCMAKE_INSTALL_PREFIX:PATH="%INSTALL_DIR%" ^
      -DWINDOWS_TARGET_VERSION="%WIN_TARGET%" ^
      -DINSTALL_ROOT="%INSTALL_DIR%" ^
      -DQT_VERSION="%QT_VERSION%" ^
      -G "NMake Makefiles" ^
      -Wno-dev ^
      "%ORIG_WD%/3rdparty"

cmake --build . --config RelWithDebInfo --target ext_openssl
cmake --build . --config RelWithDebInfo --target ext_qt
cmake --build . --config RelWithDebInfo --target ext_qtav

REM For elapsed time mesurement

call %ORIG_WD%/common.cmd :TerminateScript
