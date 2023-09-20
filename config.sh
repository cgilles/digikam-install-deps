#!/bin/bash

################################################################################
#
# Script to configure project based on CMake for Linux.
#
# Copyright (c) 2013-2023, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
################################################################################

# --- Qt build Settings ---------------

ORIG_WD="`pwd`"

# Qt version to install

# Absolute path where are downloaded all tarballs to compile.

DOWNLOAD_DIR="/mnt/data/download.qt6"

# Absolute path where code will be compiled.

#BUILDING_DIR="$ORIG_WD/build.qt6"
BUILDING_DIR="/mnt/data/build.qt6"

# Absolute path where Qt will be installed.

#INSTALL_DIR="$ORIG_WD/qt6"
INSTALL_DIR="/opt/qt6"
