# Script to build libksane for digiKam bundle.
#
# Copyright (c) 2015-2026 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

set(EXTPREFIX_libksane "${EXTPREFIX}" )

if(APPLE)

    GetKF5ApplicationMd5Sums(ksanecore ${KA_VERSION})

    ExternalProject_Add(ext_ksanecore
                        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
                        URL https://download.kde.org/stable/release-service/${KA_VERSION}/src/ksanecore-${KA_VERSION}.tar.xz
                        URL_MD5 ${KF5_APPLICATION_MD5SUM}

                        CONFIGURE_COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/../../../../bootstrap.${DK_APPLE_PACKAGE_MANAGER} <SOURCE_DIR>/. &&
                                          <SOURCE_DIR>/bootstrap.${DK_APPLE_PACKAGE_MANAGER} ${EXTPREFIX_libksane} debug ${ARCH_TARGET} "-DBUILD_TESTING=OFF -Wno-dev"

                        BUILD_COMMAND cd <SOURCE_DIR>/build && $(MAKE)

                        INSTALL_COMMAND cd <SOURCE_DIR>/build && make install/fast

                        BUILD_IN_SOURCE 1

                        UPDATE_COMMAND ""
                        ALWAYS 0
    )

    GetKF5ApplicationMd5Sums(libksane ${KA_VERSION})

    ExternalProject_Add(ext_libksane
                        DEPENDS ext_ksanecore

                        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
                        URL https://download.kde.org/stable/release-service/${KA_VERSION}/src/libksane-${KA_VERSION}.tar.xz
                        URL_MD5 ${KF5_APPLICATION_MD5SUM}

                        PATCH_COMMAND ${PATCH_COMMAND} -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/libksane-common-rules.patch

                        CONFIGURE_COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/../../../../bootstrap.${DK_APPLE_PACKAGE_MANAGER} <SOURCE_DIR>/. &&
                                          <SOURCE_DIR>/bootstrap.${DK_APPLE_PACKAGE_MANAGER} ${EXTPREFIX_libksane} debug ${ARCH_TARGET} "-DWITH_DESIGNER_PLUGIN=OFF -DBUILD_TESTING=OFF -Wno-dev"

                        BUILD_COMMAND cd <SOURCE_DIR>/build && $(MAKE)

                        INSTALL_COMMAND cd <SOURCE_DIR>/build && make install/fast

                        BUILD_IN_SOURCE 1

                        UPDATE_COMMAND ""
                        ALWAYS 0
    )

else() # Linux and Windows

    GetKF5ApplicationMd5Sums(ksanecore ${KA_VERSION})

    ExternalProject_Add(ext_ksanecore
                        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
                        URL https://download.kde.org/stable/release-service/${KA_VERSION}/src/ksanecore-${KA_VERSION}.tar.xz
                        URL_MD5 ${KF5_APPLICATION_MD5SUM}

                        INSTALL_DIR ${EXTPREFIX_libksane}

                        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_libksane}
                                   -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                                   ${GLOBAL_PROFILE}
                                   -DCMAKE_SYSTEM_PREFIX_PATH=${EXTPREFIX}
                                   -DBUILD_TESTING=OFF
                                   -Wno-dev

                        UPDATE_COMMAND ""
                        ALWAYS 0
    )

    GetKF5ApplicationMd5Sums(libksane ${KA_VERSION})

    ExternalProject_Add(ext_libksane
                        DEPENDS ext_ksanecore

                        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
                        URL https://download.kde.org/stable/release-service/${KA_VERSION}/src/libksane-${KA_VERSION}.tar.xz
                        URL_MD5 ${KF5_APPLICATION_MD5SUM}

                        INSTALL_DIR ${EXTPREFIX_libksane}

                        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_libksane}
                                   -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                                   ${GLOBAL_PROFILE}
                                   -DCMAKE_SYSTEM_PREFIX_PATH=${EXTPREFIX}
                                   -DWITH_DESIGNER_PLUGIN=OFF
                                   -DBUILD_TESTING=OFF
                                   -Wno-dev

                        PATCH_COMMAND ${PATCH_COMMAND} -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/libksane-common-rules.patch

                        UPDATE_COMMAND ""
                        ALWAYS 0
    )

endif()
