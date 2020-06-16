################################################################################
#
# CMake script to find XKBCommon libraries
# Once done, this will define:
#
#   XKBCOMMON_FOUND         - System has XKBCommon
#   XKBCOMMON_INCLUDE_DIRS  - The XKBCommon include directories
#   XKBCOMMON_LIBRARIES     - The libraries needed to use XKBCommon
#   XKBCOMMON_DEFINITIONS   - Compiler switches required for using XKBCommon
#
# 2015-2020 - Gilles Caulier <gilles.caulier@cea.fr>
#
# Copyright (c) 2015-2020, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
################################################################################

find_package(PkgConfig)

pkg_check_modules(PC_XKBCOMMON QUIET xkbcommon)

set(XKBCOMMON_DEFINITIONS ${PC_XKBCOMMON_CFLAGS_OTHER})

find_path(XKBCOMMON_INCLUDE_DIR
          NAMES xkbcommon/xkbcommon.h
          HINTS ${PC_XKBCOMMON_INCLUDE_DIR} ${PC_XKBCOMMON_INCLUDE_DIRS}
)

find_library(XKBCOMMON_LIBRARY
             NAMES xkbcommon
             HINTS ${PC_XKBCOMMON_LIBRARY} ${PC_XKBCOMMON_LIBRARY_DIRS}
)

set(XKBCOMMON_LIBRARIES    ${XKBCOMMON_LIBRARY})
set(XKBCOMMON_LIBRARY_DIRS ${XKBCOMMON_LIBRARY_DIRS})
set(XKBCOMMON_INCLUDE_DIRS ${XKBCOMMON_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(XKBCommon DEFAULT_MSG
                                  XKBCOMMON_LIBRARY
                                  XKBCOMMON_INCLUDE_DIR
)

mark_as_advanced(XKBCOMMON_LIBRARY XKBCOMMON_INCLUDE_DIR)
