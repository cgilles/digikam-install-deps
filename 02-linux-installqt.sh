#!/bin/bash

################################################################################
#
# Script to install Qt framework on Ubuntu.
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
exec > >(tee $INSTALL_DIR/logs/linux-installqt6.full.log) 2>&1

#################################################################################################
# Pre-processing checks

ChecksRunAsRoot
StartScript
ChecksCPUCores
ChecksPhyMemory
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

$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_jasper                -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_openssl               -- -j$CPU_CORES

ln -s /usr/local/lib64/libssl.a    /usr/local/lib/libssl.a    || true
ln -s /usr/local/lib64/libcrypto.a /usr/local/lib/libcrypto.a || true

# NOTE: QtWebEngine require 4Gb of RAM by CPU cores to compile in parallel.

if [[ "$(arch)" = "x86_64" ]] ; then

    # Intel

    QT_CORES=$((PHY_MEM / 4 / 2))
    echo "Qt will be compiled with $QT_CORES CPU cores."
    taskset -c 0-$QT_CORES $INSTALL_DIR/bin/cmake --build . --parallel $QT_CORES --config RelWithDebInfo --target ext_qt6

else

    # arm64
    # According to Qt documentation (https://doc.qt.io/qt-6/linux.html),
    # arm64 is only supported on specific Linux distributions:
    # - Ubuntu 24.04 (GCC 13.x)
    # - Debian 11.6 (GCC 10)
    # - Debian 12 (GCC 12)

    ARM64_SUPPORTED=false

    if [[ "$LINUX_NAME" == *"Ubuntu"* ]] ; then

        if [[ "$LINUX_VERSION" == "24.04" ]] ; then
            ARM64_SUPPORTED=true
            echo "arm64: Ubuntu 24.04 is supported for Qt6 arm64 build."
        fi

        if [[ "$LINUX_VERSION" == "26.04" ]] ; then
            ARM64_SUPPORTED=true
            echo "arm64: Ubuntu 26.04 is supported for Qt6 arm64 build."
        fi

    elif [[ "$LINUX_NAME" == *"Debian"* ]] ; then

        if [[ "$LINUX_VERSION" == "11.6" || "$LINUX_VERSION" == "11" || "$LINUX_VERSION" == "12" ]] ; then

            ARM64_SUPPORTED=true
            echo "arm64: Debian $LINUX_VERSION is supported for Qt6 arm64 build."

        fi

    fi

    if [[ "$ARM64_SUPPORTED" == false ]] ; then

        echo "ERROR: arm64 architecture is not supported on $LINUX_NAME $LINUX_VERSION"
        echo "According to Qt documentation, arm64 is only supported on:"
        echo "  - Ubuntu 24.04 (GCC 13.x)"
        echo "  - Debian 11.6 (GCC 10)"
        echo "  - Debian 12 (GCC 12)"
        echo "Please use a supported distribution or x86_64 architecture."
        exit 1

    fi

    $INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_qt6 -- -j1

fi

rm -fr /usr/local/lib64/libssl.a    || true
rm -fr /usr/local/lib64/libcrypto.a || true
rm -fr /usr/local/lib/libssl.a      || true
rm -fr /usr/local/lib/libcrypto.a   || true
rm -fr /usr/local/include/openssl   || true

$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_opencv                -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_heif                  -- -j$CPU_CORES
$INSTALL_DIR/bin/cmake --build . --config RelWithDebInfo --target ext_exiv2                 -- -j$CPU_CORES

#################################################################################################

TerminateScript
