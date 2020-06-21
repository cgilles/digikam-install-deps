#!/bin/bash

# Script to prepare a Linux Host installation to compile digiKam dependencies.
# This script must be run as sudo
#
# Copyright (c) 2015-2020 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

# Packages for base dependencies and Qt5.

. ./common.sh
ChecksRunAsRoot

urpmi --auto \
      wget                         `#  For GMicQt.` \
      tar                          `#  AppImage legacy ?` \
      bzip2                        `#  AppImage legacy ?` \
      gettext                      `#  i18n.` \
      git                          `#  source code is hosted on git server.` \
      subversion                   `#  translations are hosted on svn server.` \
      libtool                      `#  AppImage legacy ?` \
      which                        `#  AppImage legacy ?` \
      fuse                         `#  AppImage legacy ?` \
      automake                     `#  AppImage legacy ?` \
      cmake                        `#  To compile source code.` \
      gcc-c++                      `#  To compile source code.` \
      patch                        `#  To compile source code.` \
      libxcb                       `#  X11 requirement for QtBase.` \
      libxcb-devel                 `#  X11 requirement for QtBase.` \
      xcb-util-keysyms-devel       `#  X11 requirement for QtBase.` \
      xcb-util-devel               `#  X11 requirement for QtBase.` \
      xkeyboard-config             `#  X11 requirement for QtBase.` \
      xscreensaver                 `#  X11 requirement for QtBase.` \
      gperf                        `#  To compile Qt.` \
      zlib-devel                   `#  To compile Qt.` \
      ruby                         `#  translations extractions scripts.` \
      bison                        `#  Panorama tool.` \
      flex                         `#  Panorama tool.` \
      expat-devel                  `#  For Exiv2 and Adobe DSK` \
      fuse-devel                   `#  AppImage legacy ?` \
      glibc-devel                  `#  To compile Qt.` \
      mysql-devel                  `#  To compile Qt.` \
      eigen3-devel                 `#  Refocus tool.` \
      cppunit-devel                `#  AppImage legacy ?` \
      libstdc++-devel              `#  For QtWebEngine` \
      libstdc++-static-devel       `#  For QtWebEngine` \
      lcms2-devel                  `#  Color management support.` \
      glibc-devel                  `#  To compile Qt.` \
      lib64udev-devel              `#  AppImage legacy ?` \
      xz-devel                     `#  To compile Qt.` \
      lz4-devel                    `#  To compile Qt.` \
      inotify-tools-devel          `#  To compile Qt.` \
      cups-devel                   `#  To compile Qt.` \
      openal-soft-devel            `#  For QtAv` \
      fontconfig-devel             `#  To compile Qt.` \
      freetype-devel               `#  To compile Qt.` \
      patchelf                     `#  AppImage legacy ?` \
      dpkg                         `#  AppImage legacy ?` \
      ninja                        `#  For QtWebEngine` \
      python                       `#  For QtWebEngine` \
      ruby-devel                   `#  For QtWebEngine` \
      sqlite3-devel                `#  To compile Qt.` \
      ffmpeg-devel                 `#  For QtAv` \
      boost-devel                  `#  DK deps.` \
      gphoto2-devel                `#  DK deps.` \
      sane-backends                `#  DK deps.` \
      jasper-devel                 `#  DK deps.` \
      lib64exif-devel              `#  AppImage legacy ?` \
      lib64xslt-devel              `#  DK deps.` \
      lib64drm-devel               `#  To compile Qt.` \
      lib64icu-devel               `#  To compile Qt.` \
      lib64proxy-devel             `#  To compile Qt.` \
      lib64ical-devel              `#  DK deps.` \
      lib64cap-devel               `#  To compile Qt.` \
      lib64xml2-devel              `#  DK deps.` \
      lib64nss-devel               `#  To compile Qt.` \
      lib64xkbcommon-devel         `#  To compile Qt.` \
      lib64sane1-devel             `#  KF5 deps.` \
      lib64xcb-util1               `#  For QtWebEngine` \
      lib64xi-devel                `#  For QtWebEngine` \
      lib64xtst-devel              `#  For QtWebEngine` \
      lib64xrandr-devel            `#  For QtWebEngine` \
      lib64xcursor-devel           `#  For QtWebEngine` \
      lib64xcomposite-devel        `#  For QtWebEngine` \
      lib64xrender-devel           `#  For QtWebEngine` \
      lib64mesagl1-devel           `#  For QtWebEngine` \
      lib64mesaglu1-devel          `#  For QtWebEngine` \
      lib64mesaegl1-devel          `#  For QtWebEngine` \
      lib64mesaegl1                `#  For QtWebEngine` \
      lib64ltdl-devel              `#  For QtWebEngine` \
      lib64glib2.0-devel           `#  For QtWebEngine` \
      lib64usb1.0-devel            `#  For Gphoto2 support` \
      lib64jpeg-devel              `#  DK deps.` \
      lib64png-devel               `#  DK deps.` \
      lib64tiff-devel              `#  DK deps.` \
      lib64lqr-devel               `#  DK deps.` \
      lib64fftw-devel              `#  QMicQt.` \
      lib64curl-devel              `#  QMicQt.` \
      lib64magick-devel            `#  DK deps.` \
      lib64wayland-devel           `#  To Compile Qt.`

# Remove system based devel package to prevent conflict with new one.

urpme --auto --force lib64qt5core5-devel \
                     lib64openssl-devel \
                     lib64exiv2-devel \
                     lensfun-devel \
                     lib64qtav-devel \
                     marble-devel \
                     lib64kf5sane-devel \
                     lib64kf5xmlgui-devel

