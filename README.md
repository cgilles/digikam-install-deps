Scripts to install Qt Framework to Linux or Windows
===================================================

Authors : Gilles Caulier <caulier dot gilles at gmail dot com>

* Requirements:
---------------

- Linux Debian (tested with Ubuntu : Qt5 >= 18.04 / Qt6 >= 22.04)

- Windows:
    * Microsoft Visual C++ >= 2019 Community (https://visualstudio.microsoft.com/downloads/)
        * C++ Desktop development set.
        * Base C++ features
        * Update redistributable C++ 2019
        * MSBuild
        * Windows XP C++ support       (optional to generate backward compatible Qt version)
        * VS 2015 C++ build tools      (optional to generate backward compatible Qt version)
        * VS 2017 C++ build tools      (optional to generate backward compatible Qt version)
        * VS 2019 C++ build tools
        * C++ CMake tool for Windows
        * ATL SDK support
        * Python 2                     (check path to interpreter after install)
        * Jom to compile in parallel             (optional, see http://wiki.qt.io/Jom)
            * check path to CLI tool after install
        * Perl                                   (https://strawberryperl.com/releases.html)
            * check path to interpreter after install
        * Python 2.x                             (https://www.python.org/downloads/)

- Notes: for Windows, the script have been tested under Windows 7 and 10, with MSVC 2017 and 2019.

* Configurations:
-----------------

Before to start Qt compilation, please take a look in configuration:

- Linux   : config.sh

- Windows : config.bat

See in files for a description of the options available.

* Build:
--------

To start Qt compilation use these scripts:

- Linux (require to be root):

    1) ./01-linux-preparehost-ubuntu.sh 

    2) ./02-linux-installqt6.sh

    3) ./03-linux-installkf6.sh

- Windows : installqt.bat

Under Windows, the script must be launch into a MSVC development console for the desired compiler version and 32|64 bits native support. We don't use the MSVC GUI.

* Install:
----------

File are automatically installed in path defined in config file.
