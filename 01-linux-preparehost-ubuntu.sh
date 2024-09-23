#!/bin/bash

################################################################################
#
# Script to prepare a Linux Host installation to compile Qt dependencies
# This script must be run as sudo
#
# Copyright (c) 2013-2024, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
################################################################################

. ./common.sh
. ./config.sh

# protection

if [[ -d $INSTALL_DIR ]] ; then

    echo "$INSTALL_DIR already exists on this system. Aborded!"
    exit -1

fi

#################################################################################################
# Manage script traces to log file

mkdir -p $INSTALL_DIR/logs
exec > >(tee $INSTALL_DIR/logs/linux-preparehost-ubuntu.full.log) 2>&1

#################################################################################################
# Pre-processing checks

ChecksRunAsRoot
StartScript
ChecksLinuxVersionAndName

echo -e "---------- Update Linux Ubuntu Host\n"

# for downloading package information from all configured sources.

sudo apt-get update
sudo apt-get upgrade

# benefit from a higher version of certain software, update the key

sudo apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"

# To fix GPP key error with some repositories
# See: https://www.skyminds.net/linux-resoudre-les-erreurs-communes-de-cle-gpg-dans-apt/

sudo apt-get update 2>&1 | \
    sed -ne 's?^.*NO_PUBKEY ??p' | \
    xargs -r -- sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys

echo -e "---------- Install New Development Packages\n"

# Install dependencies to Checkout Source Code

sudo apt-get install -y git
sudo apt-get install -y perl

required_packages=("cmake"                   # To Compile Source Code
                   "ninja-build"             # To Compile Source Code
                   "build-essential"         # To Compile Source Code
                   "libpthread-stubs0-dev"   # Development files for pthread
                   "libtiff-dev"             # Tag image file format library
                   "libpng-dev"              # PNG library
                   "libjpeg-dev"             # JPEG library
                   "libssl-dev"
                   "libjxl-dev"
                    )


for pkg in ${required_packages[@]}; do

    sudo apt-get install -y ${pkg}

    current_version=$(dpkg-query --showformat='${Version}' --show ${pkg})

    case "${pkg}" in
    "cmake")
        required_version=3.3.2
        ;;
    "build-essential")
        required_version=11.0.0
        ;;
    "libpthread-stubs0-dev")
        required_version=2.0.0
        ;;
    esac

    echo $current_version

    if $(dpkg --compare-versions "$current_version" "lt" "$required_version"); then
            echo "less than $required_version";
            echo "please upgrade newer version or another packages";
    else
            echo "greater than $required_version ............. accepted";
    fi

    echo "-------------------------------------------------------------------"

done

# Install optional dependencies to Compile And Link Source Code

optional_packages=("ccache"                             # For compiling
                   "bison"                              # For Qt build (>= 2.5.0)
                   "flex"                               # For compiling (>= 2.5.0)
                   "mysql-server"                       # Run-time: mysql internal server init
                   "wget"
                   "tar"
                   "bzip2"
                   "gettext"
                   "libtool"
                   "clang"
                   "llvm"
                   "python"
                   "python3-lxml"
                   "libnss3-dev"
                   "fuse3"
                   "automake"
                   "yasm"
                   "patch"
                   "curl"
                   "xscreensaver"
                   "zlib1g-dev"
                   "libdrm-dev"
                   "libx11-dev"
                   "libx11-keyboard-perl"
                   "libx11-xcb-dev"
                   "libfuse-dev"
                   "libc6-dev"
                   "libcppunit-dev"
                   "libc++-dev"
                   "libudev-dev"
                   "libsqlite3-dev"
                   "liblzma-dev"
                   "liblz-dev"
                   "libinotifytools0-dev"
                   "libcups2-dev"
                   "libopenal-dev"
                   "libpulse-dev"
                   "libcap-dev"
                   "libfontconfig1-dev"
                   "libxkbcommon-dev"
                   "libxkbcommon-x11-dev"
                   "libxkbfile-dev"
                   "libxinerama-dev"
                   "libxi-dev"
                   "libxtst-dev"
                   "libxrandr-dev"
                   "libxcursor-dev"
                   "libxcomposite-dev"
                   "libxrender-dev"
                   "libxext-dev"
                   "libxfixes-dev"
                   "libltdl-dev"
                   "libglib2.0-dev"
                   "libusb-1.0-0-dev"
                   "libwayland-dev"
                   "libclang-dev"
                   "libsm-dev"
                   "freeglut3-dev"
                   "libinput-dev"
                   "libass-dev"
                   "libegl1-mesa-dev"
                   "libgl1-mesa-dev"
                   "libgles2-mesa-dev"
                   "libglu1-mesa-dev"
                   "libxcb*-dev"
                   "libdbus-1-dev"
                   "libmount-dev"
                   "libfreetype6-dev"
                   "libslang2-dev"
                   "libprotoc-dev"
                   "protobuf-compiler"
                   "protobuf-compiler-grpc"
                   "libgrpc++-dev"
                   "libpq-dev"
                   "unixodbc-dev"
                   "nodejs"
                   "gperf"
                   "libicu72"
                   "libicu-dev"
                   "icu-devtools"
                   "flite1-dev"
                   "libxshmfence-dev"
                   "libcanberra-dev"
                   "libjasper-dev"
                   "libgcrypt-dev"
                   "libical-dev"
                   "libsane-dev"
                   "libexiv2-dev"
                   "liblensfun-dev"
                   "default-libmysqlclient-dev"
)

for pkg in ${optional_packages[@]}; do
    sudo apt-get install -y ${pkg}
    echo "-------------------------------------------------------------------"
done

sudo apt remove libqt6* qml6*

#################################################################################################

TerminateScript
