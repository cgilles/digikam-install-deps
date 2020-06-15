#!/bin/bash

# Copyright (c) 2015-2017, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

ORIG_WD="`pwd`"

# Where to download tarballs
DOWNLOAD_DIR="$ORIG_WD/download"

# Where to uncompress and build tarballs
BUILDING_DIR="$ORIG_WD/build"

# Where to install libraries
INSTALL_DIR="$ORIG_WD/qt5"
