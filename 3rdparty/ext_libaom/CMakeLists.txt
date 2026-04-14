# Script to build AOM library for digiKam bundle.
#
# SPDX-FileCopyrightText: 2015-2026 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#

set(PREFIX_libaom "${EXTPREFIX}")

# NOTES:
# - Libaom is installed with Macports under MacOS

set(AOM_Conf -DENABLE_EXAMPLES=OFF
             -DENABLE_TESTS=OFF
             -DENABLE_TOOLS=OFF
             -DENABLE_DOCS=OFF
             -DENABLE_TESTDATA=OFF
             -DCONFIG_PIC=1
             -DBUILD_SHARED_LIBS=ON
)

JoinListAsString("${AOM_Conf}" " " BASH_OPTIONS_AOM)

ExternalProject_Add(ext_libaom

    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
    GIT_REPOSITORY https://aomedia.googlesource.com/aom
    GIT_TAG v3.13.1

    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${PREFIX_libaom}
               -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
               ${GLOBAL_PROFILE}
               ${AOM_Conf}

    BUILD_IN_SOURCE 0

    UPDATE_COMMAND ""
    ALWAYS 0
)
