# Script to build Qt6.
#
# Copyright (c) 2015-2024 by Gilles Caulier <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

set(EXTPREFIX_qt ${EXTPREFIX})

SET(QT_URL https://download.qt.io/official_releases/qt/6.8/6.8.0/src/single/qt-everywhere-src-6.8.0.tar.xz)
SET(QT_HASH ce8676e8302d82c7e80ae0f1a316c132)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/qt6_cmake_path.patch.cmake.in
               ${CMAKE_CURRENT_BINARY_DIR}/qt6_cmake_path.patch)

# Linux with G++ compiler

include("config-qt6-linux.cmake")

ExternalProject_Add(ext_qt6
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    URL ${QT_URL}
    URL_MD5 ${QT_HASH}

    PATCH_COMMAND ${PATCH_COMMAND} -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/qt6-openssl-linked.patch

    CMAKE_ARGS -DOPENSSL_LIBS='-l${EXTPREFIX}/local/lib/libssl.a -l${EXTPREFIX}/local/lib/libcrypto.a -lpthread -ldl'
               -DOPENSSL_INCDIR='${EXTPREFIX}/local/include/openssl/'
               -DOPENSSL_LIBDIR='${EXTPREFIX}/local/lib'

    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${QT_CONFIG}

    # Compile with Ninja build framework.
    BUILD_COMMAND ninja

    INSTALL_COMMAND ninja install

    UPDATE_COMMAND ""
    BUILD_IN_SOURCE 1
    ALWAYS 0
)
