#!/bin/bash

# Script to configure project based on CMake for Linux.
#
# Copyright (c) 2013-2020, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

# --- Qt5 build Settings ---------------

ORIG_WD="`pwd`"

if  [[ $arch == arm* ]]; then
    # Option to use QtWebEngine instead QtWebkit, as Chromium do not support yet this architecture.
    QT_WEBENGINE=0
else
    QT_WEBENGINE=1
fi

# Absolute path where are downloaded all tarballs to compile.
#DOWNLOAD_DIR="$ORIG_WD/dwnld.qt5"
DOWNLOAD_DIR="/mnt/devel/dwnld.qt5"

# Directory where code will be compiled.
#BUILDING_DIR="$ORIG_WD/build.qt5"
BUILDING_DIR="/mnt/devel/build.qt5"

# Directory where Qt5 will be installed.
INSTALL_DIR="/mnt/devel/qt5"
#INSTALL_DIR="/opt/qt5"
#INSTALL_DIR="$ORIG_WD/qt5"
