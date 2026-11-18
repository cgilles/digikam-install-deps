# Script to build AVIF library for digiKam bundle.
#
# SPDX-FileCopyrightText: 2015-2026 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#

set(PREFIX_libavif "${EXTPREFIX}")

set(AVIF_Conf -DBUILD_SHARED_LIBS=ON
              -DAVIF_ENABLE_WERROR=OFF
              -DAVIF_CODEC_AOM=ON
              -DAVIF_CODEC_AOM_DECODE=ON
              -DAVIF_CODEC_AOM_ENCODE=ON
              -DAVIF_LOCAL_AOM=OFF
              -DAVIF_LOCAL_ZLIBPNG=OFF
              -DAVIF_LOCAL_JPEG=OFF
              -DAVIF_LIBYUV=LOCAL
              -DAVIF_LOCAL_ZLIBPNG=OFF
              -DAVIF_CODEC_DAV1D=OFF
              -DAVIF_LOCAL_DAV1D=OFF
              -DAVIF_CODEC_LIBGAV1=OFF
              -DAVIF_LOCAL_LIBGAV1=OFF
              -DAVIF_CODEC_RAV1E=OFF
              -DAVIF_LOCAL_RAV1E=OFF
              -DAVIF_CODEC_SVT=OFF
              -DAVIF_LOCAL_SVT=OFF
              -DAVIF_ENABLE_COVERAGE=OFF
              -DAVIF_BUILD_APPS=OFF
              -DAVIF_BUILD_EXAMPLES=OFF
              -DAVIF_BUILD_TESTS=OFF
)

JoinListAsString("${AVIF_Conf}" " " BASH_OPTIONS_AVIF)

if(APPLE)

    ExternalProject_Add(ext_libavif

        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

        GIT_REPOSITORY https://github.com/AOMediaCodec/libavif.git
        GIT_TAG v1.4.2

        CONFIGURE_COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/../../../../bootstrap.${DK_APPLE_PACKAGE_MANAGER} <SOURCE_DIR>/. &&
                          <SOURCE_DIR>/bootstrap.${DK_APPLE_PACKAGE_MANAGER} ${PREFIX_libavif} RelWithDebInfo ${ARCH_TARGET} ${BASH_OPTIONS_AVIF}

        BUILD_COMMAND cd <SOURCE_DIR>/build && ${BUNDLE_CMAKE_BUILD_COMMAND}

        INSTALL_COMMAND cd <SOURCE_DIR>/build && ${BUNDLE_CMAKE_INSTALL_COMMAND}

        BUILD_IN_SOURCE 1

        UPDATE_COMMAND ""
        ALWAYS 0
    )

else() # Linux and Windows

    ExternalProject_Add(ext_libavif

        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

        GIT_REPOSITORY https://github.com/AOMediaCodec/libavif.git
        GIT_TAG v1.4.2

        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${PREFIX_libavif}
                   -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                   ${AVIF_Conf}
                   ${GLOBAL_PROFILE}

        BUILD_IN_SOURCE 1

        UPDATE_COMMAND ""
        ALWAYS 0
    )

endif()
