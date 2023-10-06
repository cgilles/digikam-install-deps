# Script to build KF5 Frameworks.
#
# Copyright (c) 2015-2023 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

set(EXTPREFIX_frameworks "${EXTPREFIX}")

function(InstallKF6Component
         name
         version
         argoptions
         patch)

        if(${name} STREQUAL "libksane")
            set(giturl "https://invent.kde.org/graphics/${name}.git")
        elseif(${name} STREQUAL "ksanecore")
            set(giturl "https://invent.kde.org/libraries/${name}.git")
        elseif(${name} STREQUAL "qca")
            set(giturl "https://invent.kde.org/libraries/${name}.git")
        elseif(${name} STREQUAL "phonon")
            set(giturl "https://invent.kde.org/libraries/${name}.git")
        elseif(${name} STREQUAL "plasma-wayland-protocols")
            set(giturl "https://invent.kde.org/libraries/${name}.git")
        elseif(${name} STREQUAL "marble")
            set(giturl "https://invent.kde.org/education/${name}.git")
        else()
            set(giturl "https://invent.kde.org/frameworks/${name}.git")
        endif()

        message(STATUS "--------------------------------")
        message(STATUS "KDE component    : ${name}")
        message(STATUS "Component version: ${version}")
        message(STATUS "Component Git Url: ${giturl}")
        message(STATUS "Configure options: ${argoptions}")
        message(STATUS "Patch to apply   : ${patch}")

        if(NOT "${patch}" STREQUAL "")
            set(patch "${PATCH_COMMAND};-p1;-i;${CMAKE_CURRENT_SOURCE_DIR}/${patch}")
        endif()

        ExternalProject_Add(ext_${name}
                            DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
                            GIT_REPOSITORY ${giturl}
                            GIT_TAG ${version}

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

endfunction()

set(BreezeIconsOptions -DBINARY_ICONS_RESOURCE=ON)
set(MarbleQtOnlyOptions -DWITH_DESIGNER_PLUGIN=OFF -DBUILD_MARBLE_TESTS=OFF -DBUILD_MARBLE_TOOLS=OFF -DBUILD_MARBLE_EXAMPLES=OFF -DBUILD_MARBLE_APPS=OFF -DBUILD_WITH_DBUS=OFF -DQTONLY=ON -DBUILD_TESTING=OFF)

set(Qt6CommonOptions -DQT_MAJOR_VERSION=6 -DBUILD_WITH_QT6=ON)

InstallKF6Component(extra-cmake-modules      ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kconfig                  ${KDE_VERSION} "${Qt6CommonOptions};-DKCONFIG_USE_QML=OFF"              "")
InstallKF6Component(breeze-icons             ${KDE_VERSION} "${Qt6CommonOptions};${BreezeIconsOptions}"              "breeze-dropsvg-rccprefix.patch")
InstallKF6Component(solid                    ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kcoreaddons              ${KDE_VERSION} "${Qt6CommonOptions};-DKCOREADDONS_USE_QML=OFF"          "")
InstallKF6Component(threadweaver             ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kwindowsystem            ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(karchive                 ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kdbusaddons              ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(ki18n                    ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kcrash                   ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kcodecs                  ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kauth                    ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kguiaddons               ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kwidgetsaddons           ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kitemviews               ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kcompletion              ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kcolorscheme             ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kconfigwidgets           ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kiconthemes              ${KDE_VERSION} "${Qt6CommonOptions};-DKICONTHEMES_USE_QTQUICK=OFF"      "")
InstallKF6Component(kservice                 ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kglobalaccel             ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kcalendarcore            ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kxmlgui                  ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kbookmarks               ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kimageformats            ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(knotifyconfig            ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(knotifications           ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kjobwidgets              ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(plasma-wayland-protocols ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(sonnet                   ${KDE_VERSION} "${Qt6CommonOptions};-DSONNET_USE_QML=OFF"               "")
InstallKF6Component(ktextwidgets             ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kio                      ${KDE_VERSION} "${Qt6CommonOptions}"                                    "kio-drop-deps.patch")
InstallKF6Component(kinit                    ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kdoctools                ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(phonon                   ${KDE_VERSION} "${Qt6CommonOptions};-DPHONON_BUILD_QT5=OFF"             "")
InstallKF6Component(ksanecore                ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(libksane                 ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(marble                   "marble-qt6"   "${Qt6CommonOptions};${MarbleQtOnlyOptions}"             "")
InstallKF6Component(kfilemetadata            ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(qca                      ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kwallet                  ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kpackage                 ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(attica                   ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(knewstuff                ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(kitemmodels              ${KDE_VERSION} "${Qt6CommonOptions}"                                    "kitemmodels-drop-qml.patch")
InstallKF6Component(kparts                   ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
InstallKF6Component(krunner                  ${KDE_VERSION} "${Qt6CommonOptions}"                                    "")
