# Script to build jpegXL library for digiKam bundle.
#
# Copyright (c) 2015-2026 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

set(PREFIX_ext_libjxl "${EXTPREFIX}")

set(JpegXL_Conf -DBUILD_SHARED_LIBS=ON
                -DBUILD_TESTING=OFF
                -DJPEGXL_ENABLE_EXAMPLES=OFF
                -DJPEGXL_ENABLE_PLUGINS=OFF
                -DJPEGXL_ENABLE_TOOLS=OFF
                -DJPEGXL_ENABLE_FUZZERS=OFF
                -DJPEGXL_ENABLE_DEVTOOLS=OFF
                -DJPEGXL_ENABLE_JPEGLI=OFF
                -DJPEGXL_ENABLE_JPEGLI_LIBJPEG=ON
                -DJPEGXL_ENABLE_DOXYGEN=OFF
                -DJPEGXL_ENABLE_MANPAGES=OFF
                -DJPEGXL_ENABLE_BENCHMARK=OFF
                -DJPEGXL_BUNDLE_LIBPNG=OFF
                -DJPEGXL_ENABLE_JNI=OFF
                -DJPEGXL_ENABLE_SJPEG=OFF
                -DJPEGXL_ENABLE_OPENEXR=OFF
                -DJPEGXL_ENABLE_SKCMS=OFF
                -DJPEGXL_BUNDLE_SKCMS=OFF
                -DJPEGXL_ENABLE_VIEWERS=OFF
                -DJPEGXL_ENABLE_TCMALLOC=OFF
                -DJPEGXL_ENABLE_COVERAGE=OFF
                -DJPEGXL_ENABLE_PROFILER=OFF
                -DJPEGXL_ENABLE_SIZELESS_VECTORS=OFF
                -DJPEGXL_ENABLE_TRANSCODE_JPEG=ON
                -DJPEGXL_ENABLE_BOXES=ON
                -DJPEGXL_STATIC=OFF
                -DJPEGXL_WARNINGS_AS_ERRORS=OFF
                -DJPEGXL_FORCE_NEON=OFF
                -DJPEGXL_FORCE_SYSTEM_BROTLI=OFF
                -DJPEGXL_FORCE_SYSTEM_GTEST=OFF
                -DJPEGXL_FORCE_SYSTEM_LCMS2=OFF
                -DJPEGXL_FORCE_SYSTEM_HWY=OFF
)

JoinListAsString("${JpegXL_Conf}" " " BASH_OPTIONS)

if(APPLE)

    ExternalProject_Add(ext_libjxl
        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

        # To use official release tarball

        GIT_REPOSITORY https://github.com/libjxl/libjxl.git
        GIT_TAG v0.11.2

        CONFIGURE_COMMAND git submodule update --init --recursive --depth 1 --recommend-shallow &&
                          cp -f ${CMAKE_CURRENT_SOURCE_DIR}/../../../../bootstrap.${DK_APPLE_PACKAGE_MANAGER} <SOURCE_DIR>/. &&
                          <SOURCE_DIR>/bootstrap.${DK_APPLE_PACKAGE_MANAGER} ${PREFIX_ext_libjxl} RelWithDebInfo ${ARCH_TARGET} ${BASH_OPTIONS}

        BUILD_COMMAND cd <SOURCE_DIR>/build && $(MAKE)

        INSTALL_COMMAND cd <SOURCE_DIR>/build && $(MAKE) install/fast

        BUILD_IN_SOURCE 1

        UPDATE_COMMAND ""
        ALWAYS 0
    )

else() # Linux and Windows

    ExternalProject_Add(ext_libjxl
        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

        GIT_REPOSITORY https://github.com/libjxl/libjxl.git
        GIT_TAG v0.11.2

        CONFIGURE_COMMAND git submodule update --init --recursive --depth 1 --recommend-shallow &&
                          $(CMAKE_COMMAND) . -DCMAKE_INSTALL_PREFIX=${PREFIX_ext_libjxl}
                                             -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                                             -DICONV_INCLUDE_DIR=${PREFIX_ext_libjxl}/include
                                             ${JpegXL_Conf}
                                             ${GLOBAL_PROFILE}

        BUILD_COMMAND cd <SOURCE_DIR> && $(MAKE)

        INSTALL_COMMAND cd <SOURCE_DIR> && $(MAKE) install/fast

        BUILD_IN_SOURCE 1

        UPDATE_COMMAND ""
        ALWAYS 0
    )

endif()
