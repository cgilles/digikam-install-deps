# Script to build breeze style for digiKam bundle (qt5).
#
# Copyright (c) 2015-2026 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

set(EXTPREFIX_breeze "${EXTPREFIX}")

if(APPLE)

    GetKF5PlasmaMd5Sums(breeze ${KP_VERSION})

    ExternalProject_Add(ext_breeze

                        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
                        URL https://download.kde.org/stable/plasma/${KP_VERSION}/breeze-${KP_VERSION}.tar.xz
                        URL_MD5 ${KF5_PLASMA_MD5SUM}

                        PATCH_COMMAND ${PATCH_COMMAND} -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/breeze-common-rules.patch

                        CONFIGURE_COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/../../../../bootstrap.${DK_APPLE_PACKAGE_MANAGER} <SOURCE_DIR>/. &&
                                          <SOURCE_DIR>/bootstrap.${DK_APPLE_PACKAGE_MANAGER} ${EXTPREFIX_breeze} debug ${ARCH_TARGET} "-DWITH_WALLPAPERS=OFF -DWITH_DECORATIONS=OFF -DBUILD_TESTING=OFF -Wno-dev"

                        BUILD_COMMAND cd <SOURCE_DIR>/build && $(MAKE)

                        INSTALL_COMMAND cd <SOURCE_DIR>/build && make install/fast

                        BUILD_IN_SOURCE 1

                        UPDATE_COMMAND ""
                        ALWAYS 0
    )

else() # Linux and Windows

    GetKF5PlasmaMd5Sums(breeze ${KP_VERSION})

    ExternalProject_Add(ext_breeze

                        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
                        URL https://download.kde.org/stable/plasma/${KP_VERSION}/breeze-${KP_VERSION}.tar.xz
                        URL_MD5 ${KF5_PLASMA_MD5SUM}

                        INSTALL_DIR ${EXTPREFIX_breeze}

                        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_breeze}
                                   -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                                   ${GLOBAL_PROFILE}
                                   -DCMAKE_SYSTEM_PREFIX_PATH=${EXTPREFIX}
                                   -DWITH_WALLPAPERS=OFF
                                   -DWITH_DECORATIONS=OFF
                                   -DBUILD_TESTING=OFF
                                   -Wno-dev

                        PATCH_COMMAND ${PATCH_COMMAND} -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/breeze-common-rules.patch

                        UPDATE_COMMAND ""
                        ALWAYS 0
    )

endif()
