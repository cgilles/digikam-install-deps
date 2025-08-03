#!/bin/bash

# Script to cleanup installation of KDE framework from the host system.
# This script must be run as sudo
#
# SPDX-FileCopyrightText: 2015-2025 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#

# Halt and catch errors
set -eE
trap 'PREVIOUS_COMMAND=$THIS_COMMAND; THIS_COMMAND=$BASH_COMMAND' DEBUG
trap 'echo "FAILED COMMAND: $PREVIOUS_COMMAND"' ERR

#################################################################################################
# Pre-processing checks

. ../common.sh
. ../config.sh
ChecksRunAsRoot

rm -vfr $INSTALL_DIR/lib64/libKF*
rm -vfr $INSTALL_DIR/share/ECM
rm -vfr $INSTALL_DIR/include/KF*
rm -vfr $INSTALL_DIR/lib/x86_64-linux-gnu/cmake/KF*
rm -vfr $INSTALL_DIR/include/astro
rm -vfr $INSTALL_DIR/include/marble
rm -vfr $INSTALL_DIR/share/marble
rm -vfr $INSTALL_DIR/share/k*5
rm -vfr $INSTALL_DIR/plugins/k*5
rm -vfr $INSTALL_DIR/share/k*6
rm -vfr $INSTALL_DIR/plugins/k*6
rm -vfr $INSTALL_DIR/plugins/imageformats/kimg*
rm -vfr $INSTALL_DIR/plugins/kauth
rm -vfr $INSTALL_DIR/plugins/plasma
rm -vfr $INSTALL_DIR/plugins/styles/breeze*
rm -vfr $INSTALL_DIR/plugins/iconengines/KIcon*
rm -vfr $INSTALL_DIR/plugins/designer/k*
rm -vfr $INSTALL_DIR/plugins/org.kde*
rm -vfr $INSTALL_DIR/plugins/marble*
rm -vfr $INSTALL_DIR/plugins/kcm*
rm -vfr $INSTALL_DIR/lib64/marble
rm -vfr $INSTALL_DIR/lib64/libastro*
rm -vfr $INSTALL_DIR/lib64/libmarble*
rm -vfr $INSTALL_DIR/lib64/cmake/Marble
rm -vfr $INSTALL_DIR/lib64/cmake/Astro
