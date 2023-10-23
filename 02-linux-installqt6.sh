#!/bin/bash

################################################################################
#
# Script to install Qt framework on Ubuntu.
#
# Copyright (c) 2013-2023, Gilles Caulier, <caulier dot gilles at gmail dot com>
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
exec > >(tee $INSTALL_DIR/logs/linux-installqt6.full.log) 2>&1

#################################################################################################
# Pre-processing checks

ChecksRunAsRoot
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

# Clean up previous openssl install

rm -fr /usr/local/lib/libssl.a    || true
rm -fr /usr/local/lib/libcrypto.a || true
rm -fr /usr/local/include/openssl || true

#################################################################################################

cd $BUILDING_DIR

rm -rf $BUILDING_DIR/* || true

cmake $ORIG_WD/3rdparty \
      -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_DIR \
      -DEXTERNALS_DOWNLOAD_DIR=$DOWNLOAD_DIR \
      -DINSTALL_ROOT=$INSTALL_DIR \
      -DKA_VERSION=$DK_KA_VERSION \
      -DKP_VERSION=$DK_KP_VERSION \
      -DKDE_VERSION=$DK_KDE_VERSION \
      -Wno-dev

cmake --build . --config RelWithDebInfo --target ext_cmake    -- -j$CPU_CORES

#################################################################################################

cd $BUILDING_DIR

rm -rf $BUILDING_DIR/* || true

$INSTALL_DIR/bin/cmake $ORIG_WD/3rdparty \
      -DCMAKE_INSTALL_PREFIX:PATH=/$INSTALL_DIR \
      -DEXTERNALS_DOWNLOAD_DIR=$DOWNLOAD_DIR \
      -DINSTALL_ROOT=$INSTALL_DIR \
      -DKA_VERSION=$DK_KA_VERSION \
      -DKP_VERSION=$DK_KP_VERSION \
      -DKDE_VERSION=$DK_KDE_VERSION \
      -Wno-dev

$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_openssl               -- -j$CPU_CORES

$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_qt6                   -- -j$CPU_CORES

rm -fr /usr/local/lib/libssl.a    || true
rm -fr /usr/local/lib/libcrypto.a || true
rm -fr /usr/local/include/openssl || true

#################################################################################################

TerminateScript
