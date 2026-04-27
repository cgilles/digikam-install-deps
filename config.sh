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

#DK_QTVERSION="5"
DK_QTVERSION="6"

# Absolute path where are downloaded all tarballs to compile.

DOWNLOAD_DIR="$ORIG_WD/download.qt$DK_QTVERSION"
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

# NOTE: The order to compile each component here is very important.

FRAMEWORK_COMPONENTS="\
ext_extra-cmake-modules \
ext_kconfig \
ext_breeze-icons \
ext_kcoreaddons \
ext_kwindowsystem \
ext_solid \
ext_threadweaver \
ext_karchive \
ext_kdbusaddons \
ext_ki18n \
ext_kcrash \
ext_kcodecs \
ext_kauth \
ext_kguiaddons \
ext_kwidgetsaddons \
ext_kitemviews \
ext_kcompletion \
ext_kcolorscheme \
ext_kconfigwidgets \
ext_kiconthemes \
ext_kservice \
ext_kglobalaccel \
ext_kxmlgui \
ext_kbookmarks \
ext_kimageformats \
ext_plasma-wayland-protocols \
ext_knotifications \
ext_kjobwidgets \
ext_kio \
ext_knotifyconfig \
ext_sonnet \
ext_ktextwidgets \
ext_qca \
ext_kwallet \
ext_ksanecore \
ext_libksane \
ext_kcalendarcore \
"



#ext_kfilemetadata \
#ext_kdoctools \
#ext_phonon \
#ext_qca \
#ext_kpackage \
#ext_attica \
#ext_knewstuff \
#ext_kitemmodels \
#ext_kparts \
#ext_krunner \
