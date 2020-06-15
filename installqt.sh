#!/bin/bash

# Copyright (c) 2015-2017, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

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

# Create the build dir for the 3rdparty deps
if [ ! -d $BUILDING_DIR ] ; then
    mkdir $BUILDING_DIR
fi

if [ ! -d $DOWNLOAD_DIR ] ; then
    mkdir $DOWNLOAD_DIR
fi

if [ ! -d $INSTALL_DIR ] ; then
    mkdir $INSTALL_DIR
fi

#################################################################################################

rm -rf $BUILDING_DIR/* || true
rm -rf $INSTALL_DIR/*  || true

cd $BUILDING_DIR

cmake $ORIG_WD/3rdparty \
      -DCMAKE_INSTALL_PREFIX:PATH=/$INSTALL_DIR \
      -DINSTALL_ROOT=$INSTALL_DIR \
      -DEXTERNALS_DOWNLOAD_DIR=$DOWNLOAD_DIR

cmake --build . --config RelWithDebInfo --target ext_qt         -- -j$CPU_CORES

#################################################################################################

TerminateScript
