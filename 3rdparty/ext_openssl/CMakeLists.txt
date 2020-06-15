# Script to build OpenSSL.
#
# Copyright (c) 2015-2020 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

SET(EXTPREFIX_openssl "${EXTPREFIX}")

IF (MSVC)

    ExternalProject_Add(ext_openssl

        GIT_REPOSITORY https://github.com/janbar/openssl-cmake.git
        GIT_TAG 1.1.1g-20200510

        INSTALL_DIR ${EXTPREFIX_openssl}

        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_openssl}
                   -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                   ${GLOBAL_PROFILE}

        BUILD_COMMAND ${BUILD_CLI}

        UPDATE_COMMAND ""
        BUILD_IN_SOURCE 1
        ALWAYS 0
    )

ENDIF()
