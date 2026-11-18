# SPDX-FileCopyrightText: 2026 by Andreas Winther <git.tumble747 at simplelogin dot com>
#
# SPDX-License-Identifier: BSD-3-Clause

# Recursive Make preserves the jobserver when the outer generator uses Makefiles.
if(CMAKE_GENERATOR MATCHES "Makefiles")
    set(BUNDLE_CMAKE_BUILD_COMMAND "$(MAKE)")
    set(BUNDLE_CMAKE_INSTALL_COMMAND "$(MAKE)" install)
else()
    set(BUNDLE_CMAKE_BUILD_COMMAND ${CMAKE_COMMAND} --build .)
    set(BUNDLE_CMAKE_INSTALL_COMMAND ${CMAKE_COMMAND} --build . --target install)
endif()
