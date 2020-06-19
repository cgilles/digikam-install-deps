#!/bin/bash

# Script to prepare a Linux Host installation to compile digiKam dependencies.
# This script must be run as sudo
#
# Copyright (c) 2015-2020 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

if [[ "$(arch)" = "x86_64" ]] ; then
    LIBSUFFIX=lib64
else
    LIBSUFFIX=lib
fi

# Packages for base dependencies and Qt5.

urpmi --auto \
      wget \
      tar \
      bzip2 \
      gettext \
      git \
      subversion \
      libtool \
      which \
      fuse \
      automake \
      cmake \
      gcc-c++ \
      patch \
      libxcb \
      libxcb-devel \
      xcb-util-keysyms-devel \
      xcb-util-devel \
      xkeyboard-config \
      xscreensaver \
      gperf \
      ruby \
      bison \
      flex \
      zlib-devel \
      expat-devel \
      fuse-devel \
      glibc-devel \
      mysql-devel \
      eigen3-devel \
      openssl-devel \
      cppunit-devel \
      libstdc++-devel \
      libstdc++-static-devel \
      lcms2-devel \
      glibc-devel \
      lib64udev-devel \
      sqlite-devel \
      xz-devel \
      lz4-devel \
      inotify-tools-devel \
      cups-devel \
      openal-soft-devel \
      fontconfig-devel \
      freetype-devel \
      patchelf \
      dpkg \
      ninja \
      python \
      ruby \
      ruby-devel \
      sqlite3-devel \
      ffmpeg-devel \
      boost-devel \
      gphoto2-devel \
      sane-backends \
      jasper-devel \
      lib64exif-devel \
      lib64xslt-devel \
      lib64drm-devel \
      lib64ical-devel \
      lib64cap-devel \
      lib64xml2-devel \
      lib64nss-devel \
      lib64xkbcommon-devel \
      lib64sane1-devel \
      lib64xcb-util1 \
      lib64xi-devel \
      lib64xtst-devel \
      lib64xrandr-devel \
      lib64xcursor-devel \
      lib64xcomposite-devel \
      lib64xrender-devel \
      lib64mesagl1-devel \
      lib64mesaglu1-devel \
      lib64mesaegl1-devel \
      lib64mesaegl1 \
      lib64ltdl-devel \
      lib64glib2.0-devel \
      lib64usb1.0-devel \
      lib64jpeg-devel \
      lib64png-devel \
      lib64tiff-devel \
      lib64lqr-devel \
      lib64fftw-devel \
      lib64curl-devel \
      lib64magick-devel \
      lib64wayland-devel
