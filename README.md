Scripts to install Qt Framework to Linux or Windows
===================================================

Authors : Gilles Caulier <caulier dot gilles at gamil dot com>

* Requirements:
---------------

- Ubuntu : >= 22.04

- Raspbian:
    * GCC > 4.9.x
    * Perl
    * Python 2.x
    * Cmake >= 2.8.12
    * libfontconfig1-dev
    * libxcb1-dev
    * libxcb-image0-dev
    * libxcb-keysyms1-dev
    * libxcb-xkb-dev
    * x11-xkb-utils
    * libegl1-mesa-dev
    * libcups2-dev
    * libslang2-dev
    * libxkbcommon-dev

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

- Notes: for Windows, the script have been tested under Windows 7 and 10, with MSVC 2017 and 2019,
 and for a 32 or 64 bits Intel targets.

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

    1) ./01-linux-preparehost-ubuntu.sh && ./02-linux-installqt.sh

    2) ./03-linux-installextratools.sh

- Windows : installqt.bat

Under Windows, the script must be launch into a MSVC development console for the desired compiler version and 32|64 bits native support. We don't use the MSVC GUI.

* Install:
----------

File are automatically installed in path defined in config file.
