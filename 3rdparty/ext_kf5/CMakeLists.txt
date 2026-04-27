# Script to build KDE Frameworks for digiKam bundle.
#
# SPDX-FileCopyrightText: 2015-2026 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#

set(EXTPREFIX_frameworks "${EXTPREFIX}")

function(InstallKDEComponent
         name
         version
         argoptions
         patch)

    if(APPLE)

        # Extract MD5 sums of each KDE components directly from server.
        execute_process(COMMAND
                            wget -q -O - -o /dev/null https://download.kde.org/stable/frameworks/${version}/${name}-${version}.0.tar.xz.md5
                        COMMAND
                            grep "tar.xz"
                        COMMAND
                            cut -d " " -f1
                        RESULT_VARIABLE
                            wgetresult
                        OUTPUT_VARIABLE
                            md5sm
                        OUTPUT_STRIP_TRAILING_WHITESPACE
        )

        message(STATUS "--------------------------------")
        message(STATUS "KDE component    : ${name}")
        message(STATUS "Component version: ${version}")
        message(STATUS "Component MD5    : ${md5sm}")
        message(STATUS "Configure options: ${argoptions}")
        message(STATUS "Patch to apply   : ${patch}")

        if(NOT "${patch}" STREQUAL "")
            set(patch "${PATCH_COMMAND};-p1;-i;${CMAKE_CURRENT_SOURCE_DIR}/${patch};&&")
        endif()

        ExternalProject_Add(ext_${name}
                            DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
                            URL https://download.kde.org/stable/frameworks/${version}/${name}-${version}.0.tar.xz
                            URL_MD5 ${md5sm}

                            PATCH_COMMAND ${patch}
                                          cp ${CMAKE_CURRENT_SOURCE_DIR}/../../macports/fixbundledatapath.sh <SOURCE_DIR>/. &&
                                          <SOURCE_DIR>/fixbundledatapath.sh

                            CONFIGURE_COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/../../../../bootstrap.${DK_APPLE_PACKAGE_MANAGER} <SOURCE_DIR>/. &&
                                              sed -i '' -e "s/DBUILD_TESTING=ON/DBUILD_TESTING=OFF/g" <SOURCE_DIR>/bootstrap.${DK_APPLE_PACKAGE_MANAGER} &&
                                              <SOURCE_DIR>/bootstrap.${DK_APPLE_PACKAGE_MANAGER} ${EXTPREFIX_frameworks} debug ${ARCH_TARGET} "${argoptions}"

                            BUILD_COMMAND cd <SOURCE_DIR>/build && $(MAKE)

                            INSTALL_COMMAND cd <SOURCE_DIR>/build && make install/fast

                            BUILD_IN_SOURCE 1

                            UPDATE_COMMAND ""
                            ALWAYS 0
        )

    else() # Linux and Windows

        # Extract MD5 sums of each KDE components directly from server.
        execute_process(COMMAND
                            wget -q -O - -o /dev/null https://download.kde.org/stable/frameworks/${version}/${name}-${version}.0.tar.xz.md5
                        COMMAND
                            grep "tar.xz"
                        COMMAND
                            cut -d " " -f1
                        RESULT_VARIABLE
                            wgetresult
                        OUTPUT_VARIABLE
                            md5sm
                        OUTPUT_STRIP_TRAILING_WHITESPACE
        )

        message(STATUS "--------------------------------")
        message(STATUS "KDE component    : ${name}")
        message(STATUS "Component version: ${version}")
        message(STATUS "Component MD5    : ${md5sm}")
        message(STATUS "Configure options: ${argoptions}")
        message(STATUS "Patch to apply   : ${patch}")

        if(NOT "${patch}" STREQUAL "")
            set(patch "${PATCH_COMMAND};-p1;-i;${CMAKE_CURRENT_SOURCE_DIR}/${patch}")
        endif()

        ExternalProject_Add(ext_${name}
                            DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
                            URL https://download.kde.org/stable/frameworks/${version}/${name}-${version}.0.tar.xz
                            URL_MD5 ${md5sm}

                            PATCH_COMMAND ${patch}

                            INSTALL_DIR ${EXTPREFIX_frameworks}
                            CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_frameworks}
                                       -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                                       ${GLOBAL_PROFILE}
                                       -DCMAKE_SYSTEM_PREFIX_PATH=${EXTPREFIX}
                                       -DBUILD_TESTING=OFF
                                       "${argoptions}"
                                       -Wno-dev
                            UPDATE_COMMAND ""
                            ALWAYS 0
        )

    endif()

endfunction()

if(APPLE)
    set(MacosThreadWeaverPatch threadweaver-macports.patch)
    set(MacosKauthBackend -DKAUTH_BACKEND_NAME=Apple)
else()
    set(KCalendarCorePatch kcalendarcore-libical.patch)
endif()

if(WIN32)
    set(WindowsConfigPatch kconfig-fix-header.patch)
endif()

if (${ENABLE_QTVERSION} MATCHES "5.*")
    set(Qt5CommonOptions -DQT_MAJOR_VERSION=5 -DBUILD_WITH_QT5=ON -DEXCLUDE_DEPRECATED_BEFORE_AND_AT=5.94.0 -DCMAKE_POLICY_VERSION_MINIMUM=3.5)
endif()

InstallKDEComponent(extra-cmake-modules ${KDE_VERSION} "${Qt5CommonOptions}"                       "extracmakemodules-compiler-options.patch")
InstallKDEComponent(kconfig             ${KDE_VERSION} "${Qt5CommonOptions}"                       "${WindowsConfigPatch}")
InstallKDEComponent(breeze-icons        ${KDE_VERSION} "${Qt5CommonOptions};${BreezeIconsOptions}" "breeze-dropsvg-rccprefix.patch")
InstallKDEComponent(solid               ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kcoreaddons         ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(threadweaver        ${KDE_VERSION} "${Qt5CommonOptions}"                       "${MacosThreadWeaverPatch}")
InstallKDEComponent(kwindowsystem       ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(karchive            ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kdbusaddons         ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(ki18n               ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kcrash              ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kcodecs             ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kauth               ${KDE_VERSION} "${Qt5CommonOptions};${MacosKauthBackend}"  "")
InstallKDEComponent(kguiaddons          ${KDE_VERSION} "${Qt5CommonOptions};-DWITH_WAYLAND=OFF"    "")
InstallKDEComponent(kwidgetsaddons      ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kitemviews          ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kcompletion         ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kconfigwidgets      ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kiconthemes         ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kservice            ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kglobalaccel        ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kcalendarcore       ${KDE_VERSION} "${Qt5CommonOptions}"                       "${KCalendarCorePatch}")
InstallKDEComponent(kxmlgui             ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kbookmarks          ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kimageformats       ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(knotifyconfig       ${KDE_VERSION} "${Qt5CommonOptions}"                       "knotifyconfig-drop-phonon.patch")
InstallKDEComponent(knotifications      ${KDE_VERSION} "${Qt5CommonOptions}"                       "knotifications-drop-phonon.patch")
InstallKDEComponent(kjobwidgets         ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(sonnet              ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(ktextwidgets        ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
InstallKDEComponent(kio                 ${KDE_VERSION} "${Qt5CommonOptions}"                       "kio-drop-ktextwidgets.patch")
InstallKDEComponent(kinit               ${KDE_VERSION} "${Qt5CommonOptions}"                       "")
