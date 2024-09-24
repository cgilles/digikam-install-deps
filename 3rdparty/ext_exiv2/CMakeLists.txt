# Script to build Exiv2.
#
# SPDX-FileCopyrightText: 2015-2024 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#

set(PREFIX_ext_exiv2 "${EXTPREFIX}")

set(Exiv2_Conf -DBUILD_SHARED_LIBS=ON
               -DEXIV2_ENABLE_XMP=ON
               -DEXIV2_ENABLE_EXTERNAL_XMP=OFF
               -DEXIV2_ENABLE_PNG=ON
               -DEXIV2_ENABLE_NLS=ON
               -DEXIV2_ENABLE_BMFF=ON
               -DEXIV2_ENABLE_BROTLI=ON
               -DEXIV2_ENABLE_PRINTUCS2=ON
               -DEXIV2_ENABLE_LENSDATA=ON
               -DEXIV2_ENABLE_VIDEO=OFF
               -DEXIV2_ENABLE_WEBREADY=OFF
               -DEXIV2_ENABLE_DYNAMIC_RUNTIME=OFF
               -DEXIV2_ENABLE_CURL=OFF
               -DEXIV2_ENABLE_SSH=OFF
               -DEXIV2_ENABLE_INIH=OFF
               -DEXIV2_BUILD_SAMPLES=OFF
               -DEXIV2_BUILD_PO=OFF
               -DEXIV2_BUILD_EXIV2_COMMAND=OFF
               -DEXIV2_BUILD_UNIT_TESTS=OFF
               -DEXIV2_BUILD_FUZZ_TESTS=OFF
               -DEXIV2_BUILD_DOC=OFF
               -DEXIV2_TEAM_EXTRA_WARNINGS=OFF
               -DEXIV2_TEAM_WARNINGS_AS_ERRORS=OFF
               -DEXIV2_TEAM_USE_SANITIZERS=OFF
               -DEXIV2_TEAM_OSS_FUZZ=OFF
               -DEXIV2_TEAM_PACKAGING=OFF
)

JoinListAsString("${Exiv2_Conf}" " " BASH_OPTIONS)

if(APPLE)

    ExternalProject_Add(ext_exiv2
        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

        GIT_REPOSITORY https://github.com/Exiv2/exiv2.git
        GIT_TAG v0.28.3

        CONFIGURE_COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/../../../scripts/create_manifest.sh <SOURCE_DIR>/. &&
                          cd <SOURCE_DIR> &&
                          <SOURCE_DIR>/create_manifest.sh ${EXTERNALS_DOWNLOAD_DIR} exiv2 &&
                          cp -f ${CMAKE_CURRENT_SOURCE_DIR}/../../../../bootstrap.${DK_APPLE_PACKAGE_MANAGER} <SOURCE_DIR>/. &&
                          <SOURCE_DIR>/bootstrap.${DK_APPLE_PACKAGE_MANAGER} ${PREFIX_ext_exiv2} RelWithDebInfo ${CMAKE_HOST_SYSTEM_PROCESSOR} ${BASH_OPTIONS}

        BUILD_COMMAND cd <SOURCE_DIR>/build && $(MAKE)

        INSTALL_COMMAND cd <SOURCE_DIR>/build && $(MAKE) install/fast

        BUILD_IN_SOURCE 1

        UPDATE_COMMAND ""
        ALWAYS 0
    )

elseif(MSVC)

    ExternalProject_Add(ext_exiv2
        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

        GIT_REPOSITORY https://github.com/Exiv2/exiv2.git
        GIT_TAG v0.28.3

        PATCH_COMMAND ${PATCH_COMMAND} -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/exiv2-brotli-vcpkg.patch &&
                      cp -f ${CMAKE_CURRENT_SOURCE_DIR}/../../../scripts/create_manifest.sh <SOURCE_DIR>/. &&
                      cd <SOURCE_DIR> &&
                      bash --noprofile <SOURCE_DIR>/create_manifest.sh ${EXTERNALS_DOWNLOAD_DIR} exiv2

        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${PREFIX_ext_exiv2}
                   -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                   ${Exiv2_Conf}
                   ${GLOBAL_PROFILE}

        UPDATE_COMMAND ""
        ALWAYS 0
    )

else() # Linux

    ExternalProject_Add(ext_exiv2
        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

        GIT_REPOSITORY https://github.com/Exiv2/exiv2.git
        GIT_TAG v0.28.3

        CONFIGURE_COMMAND cd <SOURCE_DIR> &&
                          $(CMAKE_COMMAND) . -DCMAKE_INSTALL_PREFIX=${PREFIX_ext_exiv2}
                                             -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                                             -DICONV_INCLUDE_DIR=${PREFIX_ext_exiv2}/include
                                             ${Exiv2_Conf}
                                             ${GLOBAL_PROFILE}

        BUILD_COMMAND cd <SOURCE_DIR> && $(MAKE)

        INSTALL_COMMAND cd <SOURCE_DIR> && $(MAKE) install/fast

        UPDATE_COMMAND ""
        ALWAYS 0
    )

endif()
