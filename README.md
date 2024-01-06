Scripts to install Qt6 Framework to Linux
=========================================

Authors : Gilles Caulier <caulier dot gilles at gmail dot com>

* Requirements

Linux Debian (tested with Ubuntu >= 22.04).

* Configurations

Before to start Qt compilation, please take a look in self documented config.sh configuration file.

NOTE: Wayland support is disabled in Qt and KDE frameworks.

* Build

To start Qt compilation use these scripts:

    1) sudo ./01-linux-preparehost-ubuntu.sh 

    2) sudo ./02-linux-installqt6.sh

    3) sudo ./03-linux-installkf6.sh

* Install

File are automatically installed in path defined in config.sh file.
