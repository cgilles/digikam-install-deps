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
ChecksRunAsRoot
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

# --- In first install most recent cmake version

cd $BUILDING_DIR

rm -rf $BUILDING_DIR/* || true

cmake $ORIG_WD/3rdparty \
      -DCMAKE_INSTALL_PREFIX:PATH=/$INSTALL_DIR \
      -DENABLE_QTWEBENGINE=$QT_WEBENGINE \
      -DEXTERNALS_DOWNLOAD_DIR=$DOWNLOAD_DIR \
      -DINSTALL_ROOT=$INSTALL_DIR

cmake --build . --config RelWithDebInfo --target ext_cmake    -- -j$CPU_CORES

# --- In second install most recent version of low level libs and Qt

cd $BUILDING_DIR

rm -rf $BUILDING_DIR/* || true

export OPENSSL_LIBS="-lssl -lcrypto -lpthread -ldl"

$INSTALL_DIR/bin/cmake $ORIG_WD/3rdparty \
      -DCMAKE_INSTALL_PREFIX:PATH=/$INSTALL_DIR \
      -DENABLE_QTWEBENGINE=$QT_WEBENGINE \
      -DEXTERNALS_DOWNLOAD_DIR=$DOWNLOAD_DIR \
      -DINSTALL_ROOT=$INSTALL_DIR

$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_openssl   -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_opencv   -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_exiv2    -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_lensfun  -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_qt       -- -j$CPU_CORES

# --- In third, install Qt5 based frameworks

cd $BUILDING_DIR

rm -rf $BUILDING_DIR/* || true

export Qt5_DIR=$INSTALL_DIR

$INSTALL_DIR/bin/cmake $ORIG_WD/3rdparty \
      -DCMAKE_INSTALL_PREFIX:PATH=/$INSTALL_DIR \
      -DENABLE_QTWEBENGINE=$QT_WEBENGINE \
      -DEXTERNALS_DOWNLOAD_DIR=$DOWNLOAD_DIR \
      -DINSTALL_ROOT=$INSTALL_DIR

if [[ $QT_WEBENGINE = 0 ]] ; then
    $INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_qtwebkit  -- -j$CPU_CORES
fi

$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_qtav     -- -j$CPU_CORES

# core KF5 frameworks dependencies
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_extra-cmake-modules -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kconfig             -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_breeze-icons        -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kcoreaddons         -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kwindowsystem       -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_solid               -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_threadweaver        -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_karchive            -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kdbusaddons         -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_ki18n               -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kcrash              -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kcodecs             -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kauth               -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kguiaddons          -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kwidgetsaddons      -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kitemviews          -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kcompletion         -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kconfigwidgets      -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kiconthemes         -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kservice            -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kglobalaccel        -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kxmlgui             -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kbookmarks          -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kimageformats       -- -j$CPU_CORES

# Extra support for digiKam

# libksane support
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_libksane            -- -j$CPU_CORES

# Desktop integration support
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kjobwidgets         -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kio                 -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_knotifyconfig       -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_knotifications      -- -j$CPU_CORES

# Geolocation support
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_marble              -- -j$CPU_CORES

# Calendar support
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_kcalendarcore       -- -j$CPU_CORES

#################################################################################################

TerminateScript
