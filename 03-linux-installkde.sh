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
exec > >(tee $INSTALL_DIR/logs/installkf6.full.log) 2>&1

. ./common.sh
. ./config.sh
ChecksRunAsRoot
StartScript
ChecksCPUCores

ORIG_WD="`pwd`"

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

cmake $ORIG_WD/3rdparty \
      -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_DIR \
      -DINSTALL_ROOT=$INSTALL_DIR \
      -DEXTERNALS_DOWNLOAD_DIR=$DOWNLOAD_DIR \
      -DEXTERNALS_BUILD_DIR=$BUILDING_DIR \
      -DKA_VERSION=$DK_KA_VERSION \
      -DKP_VERSION=$DK_KP_VERSION \
      -DKDE_VERSION=$DK_KDE_VERSION \
      -Wno-dev

# Install core KF6 frameworks dependencies

for COMPONENT in $FRAMEWORK_COMPONENTS ; do

    cmake --build . --config RelWithDebInfo --target $COMPONENT -- -j$CPU_CORES

done

#################################################################################################

cd $ORIG_WD
$ORIG_WD/kf6-create-manifest.sh

TerminateScript
