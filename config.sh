#!/bin/bash

################################################################################
#
# Script to configure project based on CMake for Linux.
#
# Copyright (c) 2013-2024, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
################################################################################

# --- Qt build Settings ---------------

ORIG_WD="`pwd`"

# Absolute path where are downloaded all tarballs to compile.

DOWNLOAD_DIR="/mnt/data/download.qt6"

# Absolute path where code will be compiled.

#BUILDING_DIR="$ORIG_WD/build.qt6"
BUILDING_DIR="/mnt/data/build.qt6"

# Absolute path where Qt will be installed.

#INSTALL_DIR="$ORIG_WD/qt6"
INSTALL_DIR="/opt/qt6"

########################################################################

# KDE Plasma git tag version.
DK_KP_VERSION="v6.1.5"

# KDE Application git tag version.
DK_KA_VERSION="v24.08.1"

# KDE KF6 frameworks git tag version.
DK_KDE_VERSION="v6.6.0"

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
