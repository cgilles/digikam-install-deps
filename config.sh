#!/bin/bash

################################################################################
#
# Script to configure project based on CMake for Linux.
#
# Copyright (c) 2013-2026, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
################################################################################

# --- Qt build Settings ---------------

ORIG_WD="`pwd`"

# Qt version to use in bundle. Possible values:
# - 5:    stable Qt5 release.
# - 6:    stable Qt6 release.

DK_QTVERSION="5"
#DK_QTVERSION="6"

# Absolute path where are downloaded all tarballs to compile.

DOWNLOAD_DIR="$ORIG_WD/download"
#DOWNLOAD_DIR="/mnt/data2/download.qt$DK_QTVERSION"

# Absolute path where code will be compiled.

BUILDING_DIR="$ORIG_WD/build.qt$DK_QTVERSION"
#BUILDING_DIR="/mnt/data2/build.qt$DK_QTVERSION"

# Absolute path where Qt will be installed.

#INSTALL_DIR="$ORIG_WD/qt$DK_QTVERSION"
INSTALL_DIR="/opt/qt$DK_QTVERSION"

########################################################################

if [[ $DK_QTVERSION == 5 ]] ; then

    # KDE KF5 frameworks version.
    # See official release here: https://download.kde.org/stable/frameworks/
    DK_KDE_VERSION="5.116"

    # KDE Plasma version.
    # See official release here: https://download.kde.org/stable/plasma/
    DK_KP_VERSION="5.27.12"

    # KDE Application version.
    # See official release here: https://download.kde.org/stable/release-service/
    DK_KA_VERSION="24.05.1"

else

    # KDE KF6 frameworks version.
    # See official release here: https://download.kde.org/stable/frameworks/
    DK_KDE_VERSION="v6.25.0"

    # KDE Plasma version.
    # See official release here: https://download.kde.org/stable/plasma/
    DK_KP_VERSION="v6.6.4"

    # KDE Application version.
    # See official release here: https://download.kde.org/stable/release-service/
    DK_KA_VERSION="v25.12.3"

fi

