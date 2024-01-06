Scripts to install Qt Framework to Linux
========================================

Authors : Gilles Caulier <caulier dot gilles at gmail dot com>

* Requirements:
---------------

- Linux Debian (tested with Ubuntu : Qt5 >= 18.04 / Qt6 >= 22.04)

* Configurations:
-----------------

Before to start Qt compilation, please take a look in configuration:

- Linux   : config.sh

See in files for a description of the options available.

* Build:
--------

To start Qt compilation use these scripts:

- Linux (require to be root):

    1) ./01-linux-preparehost-ubuntu.sh 

    2) ./02-linux-installqt6.sh

    3) ./03-linux-installkf6.sh

* Install:
----------

File are automatically installed in path defined in config file.
