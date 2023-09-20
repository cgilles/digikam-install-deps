#!/bin/bash

################################################################################
#
# Script to install extra tools under Ubuntu.
#
# Script to configure project based on CMake for Linux.
#
# Copyright (c) 2013-2020, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
################################################################################

# Halt on errors
set -e

#################################################################################################
# Manage script traces to log file

mkdir -p $INSTALL_DIR/logs
exec > >(tee $INSTALL_DIR/logs/installextratools.full.log) 2>&1

#################################################################################################
# Pre-processing checks

. ./common.sh
ChecksRunAsRoot

. ./config.sh
StartScript
ChecksCPUCores
ChecksLinuxVersionAndName
ChecksGccVersion

#################################################################################################
# Create the directories

if [[ ! -d $BUILDING_DIR ]] ; then

    mkdir $BUILDING_DIR

fi

if [ ! -d $DOWNLOAD_DIR ] ; then

    mkdir $DOWNLOAD_DIR

fi

if [[ ! -d $INSTALL_DIR ]] ; then

    mkdir $INSTALL_DIR

fi

#################################################################################################

cd $BUILDING_DIR

rm -rf $BUILDING_DIR/* || true

$INSTALL_DIR/bin/cmake $ORIG_WD/3rdparty \
      -DCMAKE_INSTALL_PREFIX:PATH=/$INSTALL_DIR \
      -DEXTERNALS_DOWNLOAD_DIR=$DOWNLOAD_DIR \
      -DINSTALL_ROOT=$INSTALL_DIR \
      -Wno-dev

if [[ $QT_VERSION == "5" ]] ; then

    $INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_qtmqtt$QT_VERSION   -- -j$CPU_CORES

fi

$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_mc                      -- -j$CPU_CORES

#################################################################################################

TerminateScript
