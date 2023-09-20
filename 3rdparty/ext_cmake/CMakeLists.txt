# Script to build Cmake.
#
# Copyright (c) 2015-2023 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

SET(EXTPREFIX_cmake "${EXTPREFIX}")

SET(CMAKE_RELEASE 3.27.5)

ExternalProject_Add(ext_cmake
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    URL https://github.com/Kitware/CMake/releases/tag/v${CMAKE_RELEASE}/cmake-${CMAKE_RELEASE}.tar.gz
    URL_MD5 fbda83fa70276f6971cab8cdb1407191

    INSTALL_DIR ${EXTPREFIX_cmake}

    CONFIGURE_COMMAND cd <SOURCE_DIR> && ./bootstrap --prefix=${EXTPREFIX_cmake}

    BUILD_COMMAND ${MAKE}

    UPDATE_COMMAND ""
    BUILD_IN_SOURCE 1
    ALWAYS 0
)
