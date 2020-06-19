digiKam dependencies installer for local compilation purpose
------------------------------------------------------------

This script prepare a host computer to install the most recent digiKam dependencies for developement compilations.

Included dependencies are:

- CMake         > 3.17
- Openssl       > 1.1.1
- OpenCV        > 4.3
- Exiv2         > 0.27
- Lensfun       > master
- Qt5           > 5.15
- QtAV          > master
- KF5           > 5.71

Target OS with low level dependencies install script are

- Linux
    * Mageia    done        preparehost-mageia.sh
    * Raspbian  todo
    * Centos    todo
    * Suse      todo
    * Ubuntu    todo
    * Raspbian  todo

- Windows
    * MSVC2019  todo

To setup computer you need to:

- run as root the "preparehost" script for your operating system.
- configure paths to use in config file.
- run the installdeps script and take a coffee.

All dependencies are installed at the same place (aka /opt/qt5).

To configure digiKam for Linux compilation with the customized dependencies:

- export Qt5_DIR=/opt/qt5
- export CMAKE_BINARY=/opt/qt5/bin/cmake
- ./bootstrap.sh

------------------------------------------------------------
Gilles Caulier