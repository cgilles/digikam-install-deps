REM ################################################################################
REM #
REM # Script to configure project based on CMake for Windows.
REM #
REM # Copyright (c) 2013-2023, Gilles Caulier, <caulier dot gilles at gmail dot com>
REM # 
REM # Redistribution and use is allowed according to the terms of the BSD license.
REM # For details see the accompanying COPYING-CMAKE-SCRIPTS file.
REM #
REM ################################################################################

REM --- Qt build Settings ---------------

set ORIG_WD=%CD%

set QT_VERSION=5
REM set QT_VERSION=6

REM Set to 1 to use jom replacement of nmake to support parallel compilation under Windows with MSVC.
REM Jom must be installed before, and install directory must be set to PATH.
REM More info : https://wiki.qt.io/Jom

set ENABLE_JOM=0

REM Directory where code will be compiled.

set BUILDING_DIR=E:/build.qt%QT_VERSION%

REM Directory where Qt5 will be installed.
REM At run-time, %INSTALL_DIR%/bin path must be set in user PATH to find Qt dll

set INSTALL_DIR=E:/qt%QT_VERSION%

REM Absolute path where are downloaded all tarballs to compile.

set DOWNLOAD_DIR=E:/download.qt%QT_VERSION%

REM Windows minimum target version to use for backward compatibility.
REM Possible values:
REM    10  => Windows 10
REM    6.3 => Windows 8.1
REM    6.2 => Windows 8.0
REM    6.1 => Windows 7
REM    6.0 => Windows Vista
REM    5.1 => Windows XP

set WIN_TARGET=6.1
