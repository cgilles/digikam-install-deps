# Script to build Cmake.
#
# Copyright (c) 2015-2024 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

SET(EXTPREFIX_cmake "${EXTPREFIX}")

SET(CMAKE_RELEASE 3.29.1)

ExternalProject_Add(ext_cmake
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    URL https://github.com/Kitware/CMake/archive/refs/tags/v${CMAKE_RELEASE}.tar.gz
    URL_MD5 ac638c4ad96078acda7e990aa2f1ce22

    INSTALL_DIR ${EXTPREFIX_cmake}

    CONFIGURE_COMMAND cd <SOURCE_DIR> && ./bootstrap --prefix=${EXTPREFIX_cmake}

    BUILD_COMMAND ${MAKE}

    UPDATE_COMMAND ""
    BUILD_IN_SOURCE 1
    ALWAYS 0
)
