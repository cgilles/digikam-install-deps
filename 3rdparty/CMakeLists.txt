# Rules to build 3rd-party libraries.
#
# Copyright (c) 2015-2020, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

cmake_minimum_required(VERSION 2.8.12)

IF(WIN32)

    SET(CMAKE_SYSTEM_VERSION ${WINDOWS_TARGET_VERSION} CACHE TYPE INTERNAL FORCE)
    MESSAGE(STATUS "Windows version for backward compatibility: ${WINDOWS_TARGET_VERSION}")

ENDIF()

PROJECT(installdeps)

SET(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/modules ${CMAKE_MODULE_PATH})

function(JoinListAsString VALUES GLUE OUTPUT)

    string(REPLACE ";" "${GLUE}" _TMP_STR "${VALUES}")
    set(${OUTPUT} "${_TMP_STR}" PARENT_SCOPE)

endfunction()

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)

    message(FATAL_ERROR "Compiling in the source directory is not supported. Use for example 'mkdir build; cd build; cmake ..'.")

endif()

# Check Compile requirements

find_package(Perl         REQUIRED)
find_package(PythonInterp REQUIRED)

if(NOT WIN32)

    find_package(X11        REQUIRED)
    find_package(XCB        REQUIRED)
    find_package(Cups       REQUIRED)
    find_package(EGL        REQUIRED)
    find_package(XKBCommon  REQUIRED)
    find_package(FontConfig REQUIRED)
    find_package(OpenSSL    REQUIRED)

    # Check libstd++ for QWebEngine

endif()

# Check if Jom is present if necessary under Windows

if(MSVC)

    find_program(JOMEXEC jom.exe)

    if(JOMEXEC)

        # Parallel compilation with automatic detection of core to use.
        set(BUILD_CLI jom)
        message(STATUS "Jom is detected on this system and will be used to parallelize compilation...")

    else()

        # Single core compilation with M$ tools...
        set(BUILD_CLI nmake)
        message(STATUS "Jom is not detected on this system. Compilation will not be parallelized...")

    endif()

endif()

# Tools must be obtained to work with:
include(ExternalProject)

# allow specification of a directory with pre-downloaded
# requirements
if(NOT IS_DIRECTORY ${EXTERNALS_DOWNLOAD_DIR})

    message(FATAL_ERROR "No externals download dir set. Use -DEXTERNALS_DOWNLOAD_DIR")

endif()

if(NOT IS_DIRECTORY ${INSTALL_ROOT})

    message(FATAL_ERROR "No install dir set. Use -DINSTALL_ROOT")

endif()

set(TOP_INST_DIR ${INSTALL_ROOT})
set(EXTPREFIX "${TOP_INST_DIR}")
set(CMAKE_PREFIX_PATH "${EXTPREFIX}")

message(STATUS "CMAKE_GENERATOR: ${CMAKE_GENERATOR}")
message(STATUS "CMAKE_CL_64: ${CMAKE_CL_64}")

set(GLOBAL_BUILD_TYPE RelWithDebInfo)
set(GLOBAL_PROFILE ${GLOBAL_PROFILE} -DBUILD_TESTING=false)
set(PATCH_COMMAND patch)

# Function to get MD5 sums from download area for a KF5 application
# The sum is available in ${KF5_APPLICATION_MD5SUM}
function(GetKF5ApplicationMd5Sums
         name
         version)

    if(MINGW)

        # Extract MD5 sums of KF5 application directly from server.
        execute_process(COMMAND
                        wget -q -O - -o /dev/null http://download.kde.org/stable/release-service/${version}/src/${name}-${version}.tar.xz.mirrorlist
                        COMMAND
                        grep "MD5 Hash"
                        COMMAND
                        grep -o -P "(?<=<tt>).*(?=</tt>)"
                        RESULT_VARIABLE
                        wgetresult
                        OUTPUT_VARIABLE
                        md5sm
                        OUTPUT_STRIP_TRAILING_WHITESPACE
        )

        if(NOT ${wgetresult} MATCHES 0)
            message(WARNING "Cannot download MD5 sum for ${name}!")
        endif()

    elseif(APPLE)

        # Extract MD5 sums of KF5 application directly from server.
        execute_process(COMMAND
                            wget -q -O - -o /dev/null http://download.kde.org/stable/release-service/${version}/src/${name}-${version}.tar.xz.mirrorlist
                        COMMAND
                            grep "MD5 Hash"
                        COMMAND
                            grep -o "<tt>.*</tt>"
                        COMMAND
                            cut -c 5-
                        COMMAND
                            rev
                        COMMAND
                            cut -c 6-
                        COMMAND
                            rev
                        RESULT_VARIABLE
                            wgetresult
                        OUTPUT_VARIABLE
                            md5sm
                        OUTPUT_STRIP_TRAILING_WHITESPACE
        )

        if(NOT ${wgetresult} MATCHES 0)
            message(WARNING "Cannot download MD5 sum for ${name}!")
        endif()

    else() # Linux

        # Extract MD5 sums of KF5 application directly from server.
        execute_process(COMMAND
                        wget -q -O - -o /dev/null http://download.kde.org/stable/release-service/${version}/src/${name}-${version}.tar.xz.mirrorlist
                        COMMAND
                        grep "MD5 Hash"
                        COMMAND
                        grep -o -P "(?<=<tt>).*(?=</tt>)"
                        RESULT_VARIABLE
                        wgetresult
                        OUTPUT_VARIABLE
                        md5sm
                        OUTPUT_STRIP_TRAILING_WHITESPACE
        )

        if(NOT ${wgetresult} MATCHES 0)
            message(WARNING "Cannot download MD5 sum for ${name}!")
        endif()

    endif()

    message(STATUS "--------------------------------")
    message(STATUS "KF5 application    : ${name}")
    message(STATUS "application version: ${version}")
    message(STATUS "application MD5    : ${md5sm}")

    set(${KF5_APPLICATION_MD5SUM} ${md5sm} PARENT_SCOPE)

endfunction()

# this list must be dependency-ordered
add_subdirectory(ext_openssl)
add_subdirectory(ext_opencv)
add_subdirectory(ext_exiv2)
add_subdirectory(ext_lensfun)
add_subdirectory(ext_qt)
add_subdirectory(ext_qtwebkit)
add_subdirectory(ext_qtav)
add_subdirectory(ext_kf5_frameworks)
add_subdirectory(ext_libksane)
add_subdirectory(ext_marble)
add_subdirectory(ext_cmake)
