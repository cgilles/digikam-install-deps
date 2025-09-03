# Script to build static version of OpenSSL
#
# SPDX-FileCopyrightText: 2015-2025 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#

if (NOT APPLE)

    SET(EXTPREFIX_openssl "${EXTPREFIX}/local/")

    ExternalProject_Add(ext_openssl

        GIT_REPOSITORY https://github.com/jimmy-park/openssl-cmake.git
        GIT_TAG 3.5.2

        INSTALL_DIR ${EXTPREFIX_openssl}

        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_openssl}
                   -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                   -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE
                   -DOPENSSL_BUILD_VERBOSE=ON
                   -DOPENSSL_ENABLE_PARALLEL=OFF
                   -DOPENSSL_INSTALL=ON
                   -DOPENSSL_INSTALL_CERT=OFF
                   -DOPENSSL_TEST=OFF
                   -DOPENSSL_USE_CCACHE=OFF
                   ${GLOBAL_PROFILE}

        BUILD_COMMAND ${BUILD_CLI}

        UPDATE_COMMAND ""
        ALWAYS 0
    )

endif()
