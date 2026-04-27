#!/bin/bash

################################################################################
#
# Script to install KDE framework under Ubuntu.
#
# Copyright (c) 2013-2026, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
################################################################################

# Halt on errors
set -e

. ./common.sh
. ./config.sh

#################################################################################################
# Manage script traces to log file

mkdir -p $INSTALL_DIR/logs
exec > >(tee $INSTALL_DIR/logs/linux-installkf6.full.log) 2>&1

#################################################################################################
# Pre-processing checks

ChecksRunAsRoot
StartScript
ChecksCPUCores
ChecksPhyMemory
ChecksLinuxVersionAndName
ChecksGccVersion

# Create the build dir for the 3rdparty deps
if [ ! -d $BUILDING_DIR ] ; then
    mkdir $BUILDING_DIR
fi

if [ ! -d $DOWNLOAD_DIR ] ; then
    mkdir $DOWNLOAD_DIR
fi

#################################################################################################

cd $BUILDING_DIR

rm -rf $BUILDING_DIR/* || true

$INSTALL_DIR/bin/cmake $ORIG_WD/3rdparty \
      -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_DIR \
      -DINSTALL_ROOT=$INSTALL_DIR \
      -DEXTERNALS_DOWNLOAD_DIR=$DOWNLOAD_DIR \
      -DEXTERNALS_BUILD_DIR=$BUILDING_DIR \
      -DKA_VERSION=$DK_KA_VERSION \
      -DKP_VERSION=$DK_KP_VERSION \
      -DKDE_VERSION=$DK_KDE_VERSION \
      -DENABLE_QTVERSION=$DK_QTVERSION
      -Wno-dev

# NOTE: The order to compile each component here is very important.

# core KF frameworks dependencies
cmake --build . --config RelWithDebInfo --target ext_extra-cmake-modules        -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kconfig                    -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_breeze-icons               -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kcoreaddons                -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kwindowsystem              -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_solid                      -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_threadweaver               -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_karchive                   -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kdbusaddons                -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_ki18n                      -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kcrash                     -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kcodecs                    -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kauth                      -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kguiaddons                 -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kwidgetsaddons             -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kitemviews                 -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kcompletion                -- -j$CPU_CORES

if [[ $DK_QTVERSION == 6 ]] ; then

    cmake --build . --config RelWithDebInfo --target ext_kcolorscheme           -- -j$CPU_CORES

fi

cmake --build . --config RelWithDebInfo --target ext_kconfigwidgets             -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kiconthemes                -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kservice                   -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kglobalaccel               -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kxmlgui                    -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kbookmarks                 -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kimageformats              -- -j$CPU_CORES

# Extra support for digiKam

# Desktop integration support
cmake --build . --config RelWithDebInfo --target ext_knotifications             -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kjobwidgets                -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_kio                        -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_knotifyconfig              -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_sonnet                     -- -j$CPU_CORES
cmake --build . --config RelWithDebInfo --target ext_ktextwidgets               -- -j$CPU_CORES

# libksane support
if [[ $DK_QTVERSION == 6 ]] ; then

    cmake --build . --config RelWithDebInfo --target ext_qca                    -- -j$CPU_CORES
    cmake --build . --config RelWithDebInfo --target ext_kwallet                -- -j$CPU_CORES
    cmake --build . --config RelWithDebInfo --target ext_ksanecore              -- -j$CPU_CORES

fi

cmake --build . --config RelWithDebInfo --target ext_libksane                   -- -j$CPU_CORES

# Calendar support
cmake --build . --config RelWithDebInfo --target ext_kcalendarcore              -- -j$CPU_CORES

# Breeze style support
cmake --build . --config RelWithDebInfo --target ext_breeze                     -- -j$CPU_CORES

#################################################################################################

cd $ORIG_WD

TerminateScript
