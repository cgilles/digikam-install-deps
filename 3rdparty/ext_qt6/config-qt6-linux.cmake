################################################################################
#
# Script to build Qt 6 - config for Linux
# See option details on configure-linux text file
#
# 2015-2022 - Gilles Caulier <gilles.caulier@cea.fr>
#
# Licensed Material - Program Property of CABRI
# (c) CEA Cadarache - DER/CAD/SPESI/LP2E
#
################################################################################

LIST(APPEND QT_CONFIG

            -cmake-generator Ninja            #  Qt6 use Ninja build system by default.

            -prefix ${EXTPREFIX_qt}           # Framework install path.

            -release                          # no debug symbols
            -opensource                       # Build open-source framework edition
            -confirm-license                  # Silency ack the license

            -sql-odbc                         # Compile ODBC SQL plugin
            -sql-psql                         # Compile PostgreSql SQL plugin
            -sql-sqlite                       # Compile Sqlite SQL plugin
            -fontconfig
            -system-freetype                  # Use system font rendering lib https://doc.qt.io/qt-5/qtgui-attribution-freetype.html
            -openssl-linked                   # Ssl libraries from the system
            -system-zlib                      # Do not share the internal zlib and promote system lib instead to prevent mixed versions in client area.

            # Compilation rules to disable.

            -nomake tests                     # Do not build test codes
            -nomake examples                  # Do not build basis example codes
            -no-qml-debug

            # Compilation rules to disable.

            -no-icu                           # Do not support ICU: https://wiki.qt.io/Qt_5_ICU
            -no-mtdev
            -no-journald
            -no-syslog
            -no-tslib
            -no-directfb
            -no-linuxfb
            -no-libproxy
            -no-pch

            # Specific 3rdParty libraries to enable.

            -qt-pcre
            -qt-harfbuzz
            -xcb

            # Qt components to disable

            -skip qt3d
            -skip qtactiveqt
            -skip qtcanvas3d
            -skip qtcoap
            -skip qtconnectivity
            -skip qtdatavis3d
            -skip qtdoc
            -skip qtfeedback
            -skip qtgamepad
            -skip qtgraphicaleffects
            -skip qtlanguageserver
            -skip qtlottie
            -skip qtopcua
            -skip qtpim
            -skip qtqa
            -skip qtpurchasing
            -skip qtquick3d
            -skip qtquick3dphysics
            -skip qtquickcontrols2            # QtQuick support for QML
            -skip qtquickeffectmaker
            -skip qtscript                    # No need scripting (deprecated)
            -skip qtquicktimeline
            -skip qtremoteobjects
            -skip qtrepotools
            -skip qtspeech
            -skip qtvirtualkeyboard
            -skip qtwinextras                 # For Windows devices only
            -skip qtandroidextras             # For embeded devices only
            -skip qtmacextras                 # For MacOS devices only
            -skip qtwebglplugin               # No need browser OpenGL extention support
)

MESSAGE(STATUS "Use Linux configuration:")
MESSAGE(STATUS ${QT_CONFIG})
