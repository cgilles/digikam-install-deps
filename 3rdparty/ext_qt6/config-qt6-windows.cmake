################################################################################
#
# Script to build Qt 6 - config for Windows
# See option details on configure-windows text file
#
# Copyright (c) 2015-2023 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
################################################################################

LIST(APPEND QT_CONFIG

            # Framework install path.
            -prefix ${EXTPREFIX_qt}

            -openssl                          # Enable openssl support
            -I ${EXTPREFIX}/include           # For openssl
            -L ${EXTPREFIX}/lib               # For openssl

            # Compilation rules to enable.
            -release                          # no debug symbols
            -opensource                       # Build open-source framework edition
            -confirm-license                  # Silency ack the license
            -opengl desktop                   # Enable OpenGL support from Desktop
            -mp                               # Use multiple processor while compiling if possible
            -shared                           # Build shared framework libraries
            -sql-sqlite                       # Enable Sqlite plugin supportm

            # Compilation rules to disable.
            -nomake tests                     # Do not build test codes
            -nomake examples                  # Do not build basis example codes
            -no-compile-examples              # Do not build extra example codes
#            -no-icu                           # Do not support ICU: https://wiki.qt.io/Qt_5_ICU
#            -no-angle                         # Do not compile Angle API support https://wiki.qt.io/Qt_5_on_Windows_ANGLE_and_OpenGL
#            -no-mtdev                         # Do not support multi-touch
#            -no-libproxy                      # Do not support network proxy

            # Specific 3rdParty libraries to enable.
            -qt-zlib                          # Use internal Z compression lib
            -qt-libpng                        # Use internal PNG lib
            -qt-libjpeg                       # Use internal JPEG lib
            -qt-pcre                          # Use internal regular expression lib https://doc.qt.io/archives/qt-5.8/qtcore-attribution-pcre.html
            -qt-harfbuzz                      # Use internal OpenType lib
            -qt-freetype                      # Use internal font rendering lib https://doc.qt.io/qt-5/qtgui-attribution-freetype.html

            -skip qt3d
            -skip qtactiveqt
            -skip qtcanvas3d
            -skip qtcharts
            -skip qtcoap
            -skip qtconnectivity
            -skip qtdatavis3d
            -skip qtdoc
            -skip qtfeedback
            -skip qtgamepad
            -skip qtgraphicaleffects
            -skip qtlanguageserver
            -skip qtlocation
            -skip qtlottie
            -skip qtopcua
            -skip qtpim
            -skip qtpositioning
            -skip qtqa
            -skip qtpurchasing
            -skip qtquick3d
            -skip qtquick3dphysics
            -skip qtquickcontrols             # QtQuick support      ==> QWebEngine dependency
            -skip qtquickcontrols2            # QtQuick support for QML
            -skip qtscript                    # No need scripting (deprecated)
            -skip qtquicktimeline
            -skip qtremoteobjects
            -skip qtrepotools
            -skip qtvirtualkeyboard
            -skip qtnetworkauth               # No need network authentification support.
            -skip qtandroidextras             # For embeded devices only
            -skip qtmacextras                 # For MacOS devices only
            -skip qtwebglplugin
            -skip qtwebview
            -skip qtwebengine                 # No need Chromium browser support.
            -skip qtwebchannel                # QtWebChannel support ==> QWebEngine dependency
)

MESSAGE(STATUS "Use Windows configuration:")
MESSAGE(STATUS ${QT_CONFIG})

