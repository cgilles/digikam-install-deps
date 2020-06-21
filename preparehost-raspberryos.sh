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

apt-get install -y \
      wget                         `#  For GMicQt.` \
      tar                          `#  AppImage legacy ?` \
      bzip2                        `#  AppImage legacy ?` \
      gettext                      `#  i18n.` \
      git                          `#  source code is hosted on git server.` \
      subversion                   `#  translations are hosted on svn server.` \
      libtool                      `#  AppImage legacy ?` \
      fuse                         `#  AppImage legacy ?` \
      automake                     `#  AppImage legacy ?` \
      cmake                        `#  To compile source code.` \
      gcc-8                        `#  To compile source code.` \
      patch                        `#  To compile source code.` \
      libx11-xcb-dev               `#  X11 requirement for QtBase.` \
      libxcb-keysyms1-dev          `#  X11 requirement for QtBase.` \
      libxcb-util0-dev             `#  X11 requirement for QtBase.` \
      xkb-data                     `#  X11 requirement for QtBase.` \
      xscreensaver                 `#  X11 requirement for QtBase.` \
      gperf                        `#  To compile Qt.` \
      zlib1g-dev                   `#  To compile Qt.` \
      ruby                         `#  translations extractions scripts.` \
      bison                        `#  Panorama tool.` \
      flex                         `#  Panorama tool.` \
      libexpat1-dev                `#  For Exiv2 and Adobe DSK` \
      libfuse-dev                  `#  AppImage legacy ?` \
      libc6-dev                    `#  To compile Qt.` \
      libmariadb-dev               `#  To compile Qt.` \
      libeigen3-dev                `#  Refocus tool.` \
      libcppunit-dev               `#  AppImage legacy ?` \
      libstdc++-8-dev              `#  For QtWebEngine` \
      liblcms2-dev                 `#  Color management support.` \
      libudev-dev                  `#  AppImage legacy ?` \
      liblzma-dev                  `#  To compile Qt.` \
      libinotifytools0-dev         `#  To compile Qt.` \
      libcups2-dev                 `#  To compile Qt.` \
      libopenal-dev                `#  For QtAv` \
      libfontconfig1-dev           `#  To compile Qt.` \
      libfreetype6-dev             `#  To compile Qt.` \
      patchelf                     `#  AppImage legacy ?` \
      dpkg                         `#  AppImage legacy ?` \
      ninja                        `#  For QtWebEngine` \
      python                       `#  For QtWebEngine` \
      ruby-dev                     `#  For QtWebEngine` \
      libsqlite3-dev               `#  To compile Qt.` \
      libavcodec-dev               `#  For QtAv` \
      libavdevice-dev              `#  For QtAv` \
      libavfilter-dev              `#  For QtAv` \
      libavformat-dev              `#  For QtAv` \
      libavresample-dev            `#  For QtAv` \
      libavutil-dev                `#  For QtAv` \
      libpostproc-dev              `#  For QtAv` \
      libswresample-dev            `#  For QtAv` \
      libboost-dev                 `#  DK deps.` \
      libgphoto2-dev               `#  DK deps.` \
      libsane-dev                  `#  DK deps.` \
      libjasper-dev                `#  DK deps.` \

exit

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

