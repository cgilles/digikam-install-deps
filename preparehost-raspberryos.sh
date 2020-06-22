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
      libexif-dev                  `#  AppImage legacy ?` \
      libxslt1-dev                 `#  DK deps.` \
      libdrm-dev                   `#  To compile Qt.` \
      libicu-dev                   `#  To compile Qt.` \
      libproxy-dev                 `#  To compile Qt.` \
      libical-dev                  `#  DK deps.` \
      libcap-dev                   `#  To compile Qt.` \
      libxml2-dev                  `#  DK deps.` \
      libnss3-dev                  `#  To compile Qt.` \
      libxkbcommon-dev             `#  To compile Qt.` \
      libxi-dev                    `#  For QtWebEngine` \
      libxtst-dev                  `#  For QtWebEngine` \
      libxrandr-dev                `#  For QtWebEngine` \
      libxcursor-dev               `#  For QtWebEngine` \
      libxcomposite-dev            `#  For QtWebEngine` \
      libxrender-dev               `#  For QtWebEngine` \
      libglu1-mesa-dev             `#  For QtWebEngine` \
      libegl1-mesa-dev             `#  For QtWebEngine` \
      libltdl-dev                  `#  For QtWebEngine` \
      libglib2.0-dev               `#  For QtWebEngine` \
      libusb-1.0-0-dev             `#  For Gphoto2 support` \
      libjpeg-dev                  `#  DK deps.` \
      libpng-dev                   `#  DK deps.` \
      libtiff-dev                  `#  DK deps.` \
      liblqr-1-0-dev               `#  DK deps.` \
      libfftw3-dev                 `#  QMicQt.` \
      libcurl4-nss-dev             `#  QMicQt.` \
      libmagick++-dev              `#  DK deps.` \
      libwayland-dev               `#  To Compile Qt.` \
      libssl-dev                   `#  To Compile Cmake.`

# Remove system based devel package to prevent conflict with new one.

apt-get remove -y qtbase5-dev \
                  libexiv2-dev \
                  liblensfun-dev \
                  libqtav-dev \
                  libmarble-dev \
                  libkf5sane-dev \
                  libkf5xmlgui-dev

