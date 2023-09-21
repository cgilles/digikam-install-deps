#!/bin/bash

# Script to create KF6 framework manifest.
#
# Copyright (c) 2015-2023 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

set -e
set -C

. ./common.sh
. ./config.sh

ORIG_WD="`pwd`"
KF6_GITREV_LST=$ORIG_WD/kf6_manifest.txt

echo "List git sub-module revisions in $KF6_GITREV_LST"

if [ -f $KF6_GITREV_LST ] ; then
    rm -f $KF6_GITREV_LST
fi

currentDate=`date +"%Y-%m-%d"`
echo "+KF6 Snapshot $currentDate" > $KF6_GITREV_LST

# --- List git revisions for all sub-modules

for COMPONENT in $FRAMEWORK_COMPONENTS ; do

    SUBDIR=$BUILDING_DIR/ext_kf6/$COMPONENT-prefix/src/$COMPONENT
    cd $SUBDIR
    echo "$(basename "$SUBDIR"):$(git rev-parse HEAD)" >> $KF6_GITREV_LST
    cd $ORIG_WD

done

cat $KF6_GITREV_LST
