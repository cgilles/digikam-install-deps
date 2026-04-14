# Script to build Boost.
#
# SPDX-FileCopyrightText: 2015-2026 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#
#

SET(PREFIX_ext_boost "${EXTPREFIX}")

ExternalProject_Add( ext_boost
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    GIT_REPOSITORY https://github.com/boostorg/boost.git
    GIT_TAG boost-1.90.0

    CONFIGURE_COMMAND <SOURCE_DIR>/bootstrap.sh --prefix=${PREFIX_ext_boost} --with-libraries=system
    BUILD_COMMAND <SOURCE_DIR>/b2 install
    INSTALL_COMMAND ""
    INSTALL_DIR ${PREFIX_ext_boost}

    UPDATE_COMMAND ""
    ALWAYS 0
    BUILD_IN_SOURCE 1
)
