################################################################################
#
# CMake script to find XCB libraries
#
# This is a component-based find module, which makes use of the COMPONENTS and
# OPTIONAL_COMPONENTS arguments to find_module.  The following components are
# available::
#
#   XCB
#   ATOM         AUX          COMPOSITE    CURSOR       DAMAGE
#   DPMS         DRI2         DRI3         EVENT        EWMH
#   GLX          ICCCM        IMAGE        KEYSYMS      PRESENT
#   RANDR        RECORD       RENDER       RENDERUTIL   RES
#   SCREENSAVER  SHAPE        SHM          SYNC         UTIL
#   XEVIE        XF86DRI      XFIXES       XINERAMA     XINPUT
#   XKB          XPRINT       XTEST        XV           XVMC
#
# If no components are specified, this module will act as though all components
# except XINPUT (which is considered unstable) were passed to
# OPTIONAL_COMPONENTS.
#
# This module will define the following variables, independently of the
# components searched for or found:
#
# ``XCB_FOUND``
#     True if (the requestion version of) xcb is available
# ``XCB_VERSION``
#     Found xcb version
# ``XCB_TARGETS``
#     A list of all targets imported by this module (note that there may be more
#     than the components that were requested)
# ``XCB_LIBRARIES``
#     This can be passed to target_link_libraries() instead of the imported
#     targets
# ``XCB_INCLUDE_DIRS``
#     This should be passed to target_include_directories() if the targets are
#     not used for linking
# ``XCB_DEFINITIONS``
#     This should be passed to target_compile_options() if the targets are not
#     used for linking
#
# For each searched-for components, ``XCB_<component>_FOUND`` will be set to
# true if the corresponding xcb library was found, and false otherwise.  If
# ``XCB_<component>_FOUND`` is true, the imported target ``XCB::<component>``
# will be defined.  This module will also attempt to determine
# ``XCB_*_VERSION`` variables for each imported target, although
# ``XCB_VERSION`` should normally be sufficient.
#
# In general we recommend using the imported targets, as they are easier to use
# and provide more control.  Bear in mind, however, that if any target is in the
# link interface of an exported library, it must be made available by the
# package config file.
#
# Copyright (c) 2015-2020, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
################################################################################

include(CMakeParseArguments)
include(FeatureSummary)

################################################################################

macro(macro_find_package_version_check module_name)

    if(CMAKE_VERSION VERSION_LESS 2.8.12)

        message(FATAL_ERROR "CMake 2.8.12 is required by Find${module_name}.cmake")

    endif()

    if(CMAKE_MINIMUM_REQUIRED_VERSION VERSION_LESS 2.8.12)

        message(AUTHOR_WARNING "Your project should require at least CMake 2.8.12 to use Find${module_name}.cmake")

    endif()

endmacro()

################################################################################

macro(macro_find_package_parse_components module_name)

    set(macro_fppc_options SKIP_DEPENDENCY_HANDLING)
    set(macro_fppc_oneValueArgs RESULT_VAR)
    set(macro_fppc_multiValueArgs KNOWN_COMPONENTS DEFAULT_COMPONENTS)
    cmake_parse_arguments(MACRO_FPPC "${macro_fppc_options}" "${macro_fppc_oneValueArgs}" "${macro_fppc_multiValueArgs}" ${ARGN})

    if(MACRO_FPPC_UNPARSED_ARGUMENTS)

        message(FATAL_ERROR "Unexpected arguments to macro_find_package_parse_components: ${MACRO_FPPC_UNPARSED_ARGUMENTS}")

    endif()

    if(NOT MACRO_FPPC_RESULT_VAR)

        message(FATAL_ERROR "Missing RESULT_VAR argument to macro_find_package_parse_components")

    endif()

    if(NOT MACRO_FPPC_KNOWN_COMPONENTS)

        message(FATAL_ERROR "Missing KNOWN_COMPONENTS argument to macro_find_package_parse_components")

    endif()

    if(NOT MACRO_FPPC_DEFAULT_COMPONENTS)

        set(MACRO_FPPC_DEFAULT_COMPONENTS ${MACRO_FPPC_KNOWN_COMPONENTS})

    endif()

    if(${module_name}_FIND_COMPONENTS)

        set(macro_fppc_requestedComps ${${module_name}_FIND_COMPONENTS})

        if(NOT MACRO_FPPC_SKIP_DEPENDENCY_HANDLING)

            # Make sure deps are included
            foreach(macro_fppc_comp ${macro_fppc_requestedComps})

                foreach(macro_fppc_dep_comp ${${module_name}_${macro_fppc_comp}_component_deps})

                    list(FIND macro_fppc_requestedComps "${macro_fppc_dep_comp}" macro_fppc_index)

                    if("${macro_fppc_index}" STREQUAL "-1")

                        if(NOT ${module_name}_FIND_QUIETLY)

                            message(STATUS "${module_name}: ${macro_fppc_comp} requires ${${module_name}_${macro_fppc_comp}_component_deps}")

                        endif()

                        list(APPEND macro_fppc_requestedComps "${macro_fppc_dep_comp}")

                    endif()

                endforeach()

            endforeach()
        else()

            message(STATUS "Skipping dependency handling for ${module_name}")

        endif()

        list(REMOVE_DUPLICATES macro_fppc_requestedComps)

        # This makes sure components are listed in the same order as
        # KNOWN_COMPONENTS (potentially important for inter-dependencies)
        set(${MACRO_FPPC_RESULT_VAR})

        foreach(macro_fppc_comp ${MACRO_FPPC_KNOWN_COMPONENTS})

            list(FIND macro_fppc_requestedComps "${macro_fppc_comp}" macro_fppc_index)

            if(NOT "${macro_fppc_index}" STREQUAL "-1")

                list(APPEND ${MACRO_FPPC_RESULT_VAR} "${macro_fppc_comp}")
                list(REMOVE_AT macro_fppc_requestedComps ${macro_fppc_index})

            endif()

        endforeach()

        # if there are any left, they are unknown components

        if(macro_fppc_requestedComps)

            set(macro_fppc_msgType STATUS)

            if(${module_name}_FIND_REQUIRED)

                set(macro_fppc_msgType FATAL_ERROR)

            endif()

            if(NOT ${module_name}_FIND_QUIETLY)

                message(${macro_fppc_msgType} "${module_name}: requested unknown components ${macro_fppc_requestedComps}")

            endif()

            return()

        endif()

    else()

        set(${MACRO_FPPC_RESULT_VAR} ${MACRO_FPPC_DEFAULT_COMPONENTS})

    endif()

endmacro()

################################################################################

macro(macro_find_package_handle_library_components module_name)

    set(macro_fpwc_options SKIP_PKG_CONFIG SKIP_DEPENDENCY_HANDLING)
    set(macro_fpwc_oneValueArgs)
    set(macro_fpwc_multiValueArgs COMPONENTS)
    cmake_parse_arguments(MACRO_FPWC "${macro_fpwc_options}" "${macro_fpwc_oneValueArgs}" "${macro_fpwc_multiValueArgs}" ${ARGN})

    if(MACRO_FPWC_UNPARSED_ARGUMENTS)

        message(FATAL_ERROR "Unexpected arguments to macro_find_package_handle_components: ${MACRO_FPWC_UNPARSED_ARGUMENTS}")

    endif()

    if(NOT MACRO_FPWC_COMPONENTS)

        message(FATAL_ERROR "Missing COMPONENTS argument to macro_find_package_handle_components")

    endif()

    include(FindPackageHandleStandardArgs)
    find_package(PkgConfig)

    foreach(macro_fpwc_comp ${MACRO_FPWC_COMPONENTS})

        set(macro_fpwc_dep_vars)
        set(macro_fpwc_dep_targets)

        if(NOT SKIP_DEPENDENCY_HANDLING)

            foreach(macro_fpwc_dep ${${module_name}_${macro_fpwc_comp}_component_deps})
                list(APPEND macro_fpwc_dep_vars "${module_name}_${macro_fpwc_dep}_FOUND")
                list(APPEND macro_fpwc_dep_targets "${module_name}::${macro_fpwc_dep}")
            endforeach()

        endif()

        if(NOT MACRO_FPWC_SKIP_PKG_CONFIG AND ${module_name}_${macro_fpwc_comp}_pkg_config)

            pkg_check_modules(PKG_${module_name}_${macro_fpwc_comp} QUIET
                              ${${module_name}_${macro_fpwc_comp}_pkg_config})

        endif()

        find_path(${module_name}_${macro_fpwc_comp}_INCLUDE_DIR
            NAMES ${${module_name}_${macro_fpwc_comp}_header}
            HINTS ${PKG_${module_name}_${macro_fpwc_comp}_INCLUDE_DIRS}
            PATH_SUFFIXES ${${module_name}_${macro_fpwc_comp}_header_subdir}
        )

        find_library(${module_name}_${macro_fpwc_comp}_LIBRARY
            NAMES ${${module_name}_${macro_fpwc_comp}_lib}
            HINTS ${PKG_${module_name}_${macro_fpwc_comp}_LIBRARY_DIRS}
        )

        set(${module_name}_${macro_fpwc_comp}_VERSION "${PKG_${module_name}_${macro_fpwc_comp}_VERSION}")

        if(NOT ${module_name}_VERSION)

            set(${module_name}_VERSION ${${module_name}_${macro_fpwc_comp}_VERSION})

        endif()

        find_package_handle_standard_args(${module_name}_${macro_fpwc_comp}
            FOUND_VAR
                ${module_name}_${macro_fpwc_comp}_FOUND
            REQUIRED_VARS
                ${module_name}_${macro_fpwc_comp}_LIBRARY
                ${module_name}_${macro_fpwc_comp}_INCLUDE_DIR
                ${macro_fpwc_dep_vars}
            VERSION_VAR
                ${module_name}_${macro_fpwc_comp}_VERSION
            )

        mark_as_advanced(
            ${module_name}_${macro_fpwc_comp}_LIBRARY
            ${module_name}_${macro_fpwc_comp}_INCLUDE_DIR
        )

        if(${module_name}_${macro_fpwc_comp}_FOUND)

            list(APPEND ${module_name}_LIBRARIES
                        "${${module_name}_${macro_fpwc_comp}_LIBRARY}")

            list(APPEND ${module_name}_INCLUDE_DIRS
                        "${${module_name}_${macro_fpwc_comp}_INCLUDE_DIR}")

            set(${module_name}_DEFINITIONS
                    ${${module_name}_DEFINITIONS}
                    ${PKG_${module_name}_${macro_fpwc_comp}_DEFINITIONS})

            if(NOT TARGET ${module_name}::${macro_fpwc_comp})

                add_library(${module_name}::${macro_fpwc_comp} UNKNOWN IMPORTED)
                set_target_properties(${module_name}::${macro_fpwc_comp} PROPERTIES
                    IMPORTED_LOCATION "${${module_name}_${macro_fpwc_comp}_LIBRARY}"
                    INTERFACE_COMPILE_OPTIONS "${PKG_${module_name}_${macro_fpwc_comp}_DEFINITIONS}"
                    INTERFACE_INCLUDE_DIRECTORIES "${${module_name}_${macro_fpwc_comp}_INCLUDE_DIR}"
                    INTERFACE_LINK_LIBRARIES "${macro_fpwc_dep_targets}"
                )

            endif()

            list(APPEND ${module_name}_TARGETS
                        "${module_name}::${macro_fpwc_comp}")
        endif()

    endforeach()

    if(${module_name}_LIBRARIES)

        list(REMOVE_DUPLICATES ${module_name}_LIBRARIES)

    endif()

    if(${module_name}_INCLUDE_DIRS)

        list(REMOVE_DUPLICATES ${module_name}_INCLUDE_DIRS)

    endif()

    if(${module_name}_DEFINITIONS)

        list(REMOVE_DUPLICATES ${module_name}_DEFINITIONS)

    endif()

    if(${module_name}_TARGETS)

        list(REMOVE_DUPLICATES ${module_name}_TARGETS)

    endif()

endmacro()

################################################################################

macro_find_package_version_check(XCB)

# Note that this list needs to be ordered such that any component
# appears after its dependencies
set(XCB_known_components
    XCB
    RENDER
    SHAPE
    XFIXES
    SHM
    ATOM
    AUX
    COMPOSITE
    CURSOR
    DAMAGE
    DPMS
    DRI2
    DRI3
    EVENT
    EWMH
    GLX
    ICCCM
    IMAGE
    KEYSYMS
    PRESENT
    RANDR
    RECORD
    RENDERUTIL
    RES
    SCREENSAVER
    SYNC
    UTIL
    XEVIE
    XF86DRI
    XINERAMA
    XINPUT
    XKB
    XPRINT
    XTEST
    XV
    XVMC
)

# XINPUT is unstable; do not include it by default
set(XCB_default_components ${XCB_known_components})
list(REMOVE_ITEM XCB_default_components "XINPUT")

# default component info: xcb components have fairly predictable
# header files, library names and pkg-config names
foreach(_comp ${XCB_known_components})

    string(TOLOWER "${_comp}" _lc_comp)
    set(XCB_${_comp}_component_deps XCB)
    set(XCB_${_comp}_pkg_config "xcb-${_lc_comp}")
    set(XCB_${_comp}_lib "xcb-${_lc_comp}")
    set(XCB_${_comp}_header "xcb/${_lc_comp}.h")

endforeach()

# exceptions
set(XCB_XCB_component_deps)
set(XCB_COMPOSITE_component_deps XCB XFIXES)
set(XCB_DAMAGE_component_deps XCB XFIXES)
set(XCB_IMAGE_component_deps XCB SHM)
set(XCB_RENDERUTIL_component_deps XCB RENDER)
set(XCB_XFIXES_component_deps XCB RENDER SHAPE)
set(XCB_XVMC_component_deps XCB XV)
set(XCB_XV_component_deps XCB SHM)
set(XCB_XCB_pkg_config "xcb")
set(XCB_XCB_lib "xcb")
set(XCB_ATOM_header "xcb/xcb_atom.h")
set(XCB_ATOM_lib "xcb-util")
set(XCB_AUX_header "xcb/xcb_aux.h")
set(XCB_AUX_lib "xcb-util")
set(XCB_CURSOR_header "xcb/xcb_cursor.h")
set(XCB_EVENT_header "xcb/xcb_event.h")
set(XCB_EVENT_lib "xcb-util")
set(XCB_EWMH_header "xcb/xcb_ewmh.h")
set(XCB_ICCCM_header "xcb/xcb_icccm.h")
set(XCB_IMAGE_header "xcb/xcb_image.h")
set(XCB_KEYSYMS_header "xcb/xcb_keysyms.h")
set(XCB_PIXEL_header "xcb/xcb_pixel.h")
set(XCB_RENDERUTIL_header "xcb/xcb_renderutil.h")
set(XCB_RENDERUTIL_lib "xcb-render-util")
set(XCB_UTIL_header "xcb/xcb_util.h")

macro_find_package_parse_components(XCB
    RESULT_VAR XCB_components
    KNOWN_COMPONENTS ${XCB_known_components}
    DEFAULT_COMPONENTS ${XCB_default_components}
)

list(FIND XCB_components "XINPUT" _XCB_XINPUT_index)

if (NOT _XCB_XINPUT_index EQUAL -1)

    message(AUTHOR_WARNING "XINPUT from XCB was requested: this is EXPERIMENTAL and is likely to unavailable on many systems!")

endif()

macro_find_package_handle_library_components(XCB
    COMPONENTS ${XCB_components}
)

find_package_handle_standard_args(XCB
    FOUND_VAR
        XCB_FOUND
    REQUIRED_VARS
        XCB_LIBRARIES
    VERSION_VAR
        XCB_VERSION
    HANDLE_COMPONENTS
)

set_package_properties(XCB PROPERTIES
    URL "http://xcb.freedesktop.org"
    DESCRIPTION "X protocol C-language Binding"
)

################################################################################
