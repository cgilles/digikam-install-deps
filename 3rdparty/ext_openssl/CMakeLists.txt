# Script to build OpenSSL.
#
# Copyright (c) 2015-2025 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

IF(MSVC)
    SET(EXTPREFIX_openssl ${EXTPREFIX})
ELSE()
    SET(EXTPREFIX_openssl "/usr/local")
ENDIF()

ExternalProject_Add(ext_openssl
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    GIT_REPOSITORY https://github.com/janbar/openssl-cmake
    GIT_TAG 1.1.1w-20231130

    INSTALL_DIR ${EXTPREFIX_openssl}

    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_openssl}
               -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
               -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE
               -DWITH_APPS=OFF
               -DWITH_DOCS=OFF
               -DWITH_TESTS=OFF
               ${GLOBAL_PROFILE}

    BUILD_COMMAND ${BUILD_CLI}

    UPDATE_COMMAND ""
    ALWAYS 0
)
