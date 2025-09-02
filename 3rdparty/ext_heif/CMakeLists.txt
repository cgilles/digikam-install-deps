# Script to build libheif.
#
# SPDX-FileCopyrightText: 2015-2025 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#
#

set(PREFIX_ext_heif "${EXTPREFIX}")

set(Heif_Conf -DBUILD_SHARED_LIBS=ON
              -DENABLE_PLUGIN_LOADING=OFF
              -DWITH_LIBDE265=ON
              -DWITH_X265=ON
              -DWITH_KVAZAAR=OFF
              -DWITH_UVG266=OFF
              -DWITH_VVDEC=OFF
              -DWITH_VVENC=OFF
              -DWITH_OpenH264_ENCODER=OFF
              -DWITH_OpenH264_DECODER=OFF
              -DWITH_OPENJPH_ENCODER=OFF
              -DWITH_OPENJPH_DECODER=OFF
              -DWITH_DAV1D=OFF
              -DWITH_AOM_DECODER=OFF
              -DWITH_AOM_ENCODER=OFF
              -DWITH_RAV1E=OFF
              -DWITH_RAV1E_PLUGIN=OFF
              -DWITH_JPEG_ENCODER=OFF
              -DWITH_JPEG_DECODER=OFF
              -DWITH_OpenJPEG_ENCODER=OFF
              -DWITH_OpenJPEG_DECODER=OFF
              -DWITH_FFMPEG_DECODER=OFF
              -DWITH_UNCOMPRESSED_CODEC=OFF
              -DWITH_SvtEnc=OFF
              -DWITH_SvtEnc_PLUGIN=OFF
              -DWITH_LIBSHARPYUV=ON
              -DWITH_EXAMPLES=OFF
              -DWITH_EXAMPLE_HEIF_VIEW=OFF
              -DWITH_GDK_PIXBUF=OFF
              -DWITH_REDUCED_VISIBILITY=ON
              -DWITH_HEADER_COMPRESSION=OFF
              -DENABLE_MULTITHREADING_SUPPORT=ON
              -DENABLE_PARALLEL_TILE_DECODING=ON
              -DENABLE_EXPERIMENTAL_MINI_FORMAT=OFF
              -DENABLE_COVERAGE=OFF
              -DBUILD_TESTING=OFF
              -DWITH_FUZZERS=OFF
)

JoinListAsString("${Heif_Conf}" " " BASH_OPTIONS)

if(APPLE)

    ExternalProject_Add(ext_heif

        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
        GIT_REPOSITORY https://github.com/strukturag/libheif.git
        GIT_TAG v1.20.2

        PATCH_COMMAND ${PATCH_COMMAND} -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/heif-lib-only.patch

        CONFIGURE_COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/../../../scripts/create_manifest.sh <SOURCE_DIR>/. &&
                          cd <SOURCE_DIR> &&
                          <SOURCE_DIR>/create_manifest.sh ${EXTERNALS_DOWNLOAD_DIR} heif &&
                          cp -f ${CMAKE_CURRENT_SOURCE_DIR}/../../../../bootstrap.${DK_APPLE_PACKAGE_MANAGER} <SOURCE_DIR>/. &&
                          <SOURCE_DIR>/bootstrap.${DK_APPLE_PACKAGE_MANAGER} ${PREFIX_ext_heif} RelWithDebInfo ${ARCH_TARGET} ${Heif_conf}

        BUILD_COMMAND cd <SOURCE_DIR>/build && $(MAKE)

        BUILD_IN_SOURCE 1

        INSTALL_COMMAND cd <SOURCE_DIR>/build && $(MAKE) install/fast

        UPDATE_COMMAND ""
        ALWAYS 0
    )

else() # Linux

    ExternalProject_Add(ext_heif

        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
        GIT_REPOSITORY https://github.com/strukturag/libheif.git
        GIT_TAG v1.20.2

        PATCH_COMMAND git reset --hard && ${PATCH_COMMAND} -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/heif-lib-only.patch

        CONFIGURE_COMMAND cd <SOURCE_DIR> &&
                          $(CMAKE_COMMAND) . -DCMAKE_INSTALL_PREFIX=${PREFIX_ext_heif}
                          -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                          ${GLOBAL_PROFILE}
                          ${Heif_Conf}

        BUILD_IN_SOURCE 1

        UPDATE_COMMAND ""
        ALWAYS 0
    )

endif()
