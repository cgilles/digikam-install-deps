#!/bin/bash

# Script to configure project based on CMake for Linux.
#
# Copyright (c) 2013-2020, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

# Halt on errors
set -e

#################################################################################################
# Manage script traces to log file

mkdir -p ./logs
exec > >(tee ./logs/installqt.full.log) 2>&1

#################################################################################################
# Pre-processing checks

. ./common.sh
. ./config.sh
StartScript
ChecksCPUCores
ChecksLinuxVersionAndName
ChecksGccVersion

#################################################################################################
# Check if GCC > 4.8

if [[ "$GCC_MAJOR" -lt "5" ]] && [[ "$GCC_MINOR" -lt "9" ]] ; then

    if [[ "$LINUX_NAME" = "CentOS Linux" ]] || [[ "$LINUX_NAME" = "CentOS" ]] ; then

        if [[ -f /opt/rh/devtoolset-8/enable ]] ; then

            . /opt/rh/devtoolset-8/enable
            ChecksGccVersion

        else

            echo "GCC is too old. Please install RedHat Devel Set version 8. See README file for details..."
            exit -1

        fi

    fi

fi

#################################################################################################
# Create the directories

if [[ ! -d $DOWNLOAD_DIR ]] ; then

    mkdir $DOWNLOAD_DIR

fi

if [[ ! -d $BUILDING_DIR ]] ; then

    mkdir $BUILDING_DIR

fi

if [[ ! -d $INSTALL_DIR ]] ; then

    mkdir $INSTALL_DIR

fi

#################################################################################################

cd $BUILDING_DIR

rm -rf $BUILDING_DIR/* || true

cmake $ORIG_WD/3rdparty \
      -DCMAKE_INSTALL_PREFIX:PATH=/$INSTALL_DIR \
      -DENABLE_QTWEBENGINE=$QT_WEBENGINE \
      -DEXTERNALS_DOWNLOAD_DIR=$DOWNLOAD_DIR \
      -DINSTALL_ROOT=$INSTALL_DIR

cmake --build . --config RelWithDebInfo --target ext_opencv   -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_exiv2    -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_lensfun  -- -j$CPU_CORES

cmake --build . --config RelWithDebInfo --target ext_qt       -- -j$CPU_CORES

if [[ $QT_WEBENGINE = 0 ]] ; then
    cmake --build . --config RelWithDebInfo --target ext_qtwebkit  -- -j$CPU_CORES
fi

cmake --build . --config RelWithDebInfo --target ext_qtav     -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_cmake    -- -j$CPU_CORES

#################################################################################################

TerminateScript
