# Script to build Wayland Protocol for digiKam bundle.
#
# SPDX-FileCopyrightText: 2015-2026 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#
#

SET(PREFIX_ext_plasma-wayland-protocols "${EXTPREFIX}")

ExternalProject_Add(ext_plasma-wayland-protocols
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    GIT_REPOSITORY https://invent.kde.org/libraries/plasma-wayland-protocols.git
    GIT_TAG v1.18.0

    INSTALL_DIR ${EXTPREFIX_waylandprotocols}
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_waylandprotocols}
               -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
               ${GLOBAL_PROFILE}
               -DCMAKE_SYSTEM_PREFIX_PATH=${EXTPREFIX}
               -DBUILD_TESTING=OFF
               "${argoptions}"
               -Wno-dev

    UPDATE_COMMAND ""
    ALWAYS 0
)
