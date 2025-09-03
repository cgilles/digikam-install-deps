# Script to build Cmake.
#
# Copyright (c) 2015-2025 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

SET(EXTPREFIX_cmake "${EXTPREFIX}")

ExternalProject_Add(ext_cmake
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    GIT_REPOSITORY https://gitlab.kitware.com/cmake/cmake.git
#    GIT_TAG v3.31.8
    GIT_TAG v4.1.1

    INSTALL_DIR ${EXTPREFIX_cmake}

    CONFIGURE_COMMAND cd <SOURCE_DIR> && ./bootstrap --prefix=${EXTPREFIX_cmake}

    BUILD_COMMAND ${MAKE}

    UPDATE_COMMAND ""
    BUILD_IN_SOURCE 1
    ALWAYS 0
)
