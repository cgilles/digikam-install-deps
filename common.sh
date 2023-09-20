#!/bin/bash

################################################################################
#
# Script to host common methods for Linux.
#
# Copyright (c) 2013-2023, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
################################################################################

########################################################################
# Check if run as root
ChecksRunAsRoot()
{

if [[ $EUID -ne 0 ]]; then
    echo "This script should be run as root using sudo command."
    exit 1
else
    echo "Check run as root passed..."
fi

}

########################################################################
# Check CPU core available (Linux or MacOS)
ChecksCPUCores()
{

CPU_CORES=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)

if [[ $CPU_CORES -gt 1 ]]; then
    CPU_CORES=$((CPU_CORES-1))
fi

echo "CPU Cores to use : $CPU_CORES"

}

########################################################################
# For time execution measurement ; startup
StartScript()
{

BEGIN_SCRIPT=$(date +"%s")

}

########################################################################
# For time execution measurement : shutdown
TerminateScript()
{

TERMIN_SCRIPT=$(date +"%s")
difftimelps=$(($TERMIN_SCRIPT-$BEGIN_SCRIPT))
echo "Elaspsed time for script execution : $(($difftimelps / 3600 )) hours $((($difftimelps % 3600) / 60)) minutes $(($difftimelps % 60)) seconds"

}

########################################################################
# For time execution measurement : shutdown
CentOS6Adjustments()
{

# Chek if we are inside CentOS 6 or not.
grep -r "CentOS release 6" /etc/redhat-release || exit 1

# That's not always set correctly in CentOS 6.7
export LC_ALL=en_US.UTF-8
export LANG=en_us.UTF-8

# Determine which architecture should be built
if [[ "$(arch)" = "i686" || "$(arch)" = "x86_64" ]] ; then
    ARCH=$(arch)
    echo "Architecture is $ARCH"
else
    echo "Architecture could not be determined"
    exit 1
fi

# if the library path doesn't point to our usr/lib, linking will be broken and we won't find all deps either
export LD_LIBRARY_PATH=/usr/lib64/:/usr/lib

}

########################################################################
# Copy dependencies with ldd analysis
# arg1 : original file path to parse.
# arg2 : target path to copy dependencies
CopyReccursiveDependencies()
{

echo "Scan dependencies for $1"

FILES=$(ldd $1 | grep "=>" | awk '{print $3}')

for FILE in $FILES ; do
    if [ -f "$FILE" ] ; then
        cp $FILE $2 2> /dev/null || true
#        echo "   ==> $FILE"
    fi
done

}

#################################################################################################
# Check Linux OS version and name.
ChecksLinuxVersionAndName()
{

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    LINUX_NAME=$NAME
    LINUX_VERSION=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    LINUX_NAME=$(lsb_release -si)
    LINUX_VERSION=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    LINUX_NAME=$DISTRIB_ID
    LINUX_VERSION=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    LINUX_NAME=Debian
    LINUX_VERSION=$(cat /etc/debian_version)
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    LINUX_NAME=$(uname -s)
    LINUX_VERSION=$(uname -r)
fi

echo "System Info: $LINUX_NAME $LINUX_VERSION"

}

#################################################################################################
# Check GCC version.
ChecksGccVersion()
{

GCC_VERSION=$(gcc -dumpversion)

GCC_MAJOR=$(echo $GCC_VERSION | cut -d '.' -f 1)
GCC_MINOR=$(echo $GCC_VERSION | cut -d '.' -f 2)
GCC_PATCH=$(echo $GCC_VERSION | cut -d '.' -f 3)

echo "GCC Version: $GCC_MAJOR.$GCC_MINOR.$GCC_PATCH"

}
