# Script to build ffmpeg libraries for digiKam bundle.
#
# SPDX-FileCopyrightText: 2015-2026 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#

# NOTE: see build rules and tips at:
#       https://github.com/pyke369/sffmpeg/blob/master/CMakeLists.txt
#       https://www.linuxfromscratch.org/blfs/view/svn/multimedia/ffmpeg.html
#       https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
#

set(PREFIX_ext_ffmpeg "${EXTPREFIX}")

set(FFmpeg_Conf --prefix=${PREFIX_ext_ffmpeg}
                --extra-libs=-lstdc++
                --disable-doc
                --disable-debug
                --disable-programs
                --disable-outdevs
                --enable-shared
                --enable-gpl
                --enable-version3
                --enable-nonfree
                --enable-runtime-cpudetect
                --enable-libopencore-amrnb
                --enable-libopencore-amrwb
                --enable-libfdk-aac
                --enable-libmp3lame
                --enable-libspeex
                --enable-libtheora
                --enable-libvorbis
                --enable-libx264
                --enable-libx265
                --enable-libaom
                --enable-libxvid
                --enable-libvpx
                --enable-libopus
                --enable-librtmp
                --enable-libfreetype
                --enable-libass
                --enable-opengl
)

ExternalProject_Add(ext_ffmpeg
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
    URL https://ffmpeg.org/releases/ffmpeg-8.0.1.tar.xz
    URL_MD5 b4e86cef7b3333034977ae9df391896d

    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${FFmpeg_Conf}
    UPDATE_COMMAND ""
    ALWAYS 0
)
