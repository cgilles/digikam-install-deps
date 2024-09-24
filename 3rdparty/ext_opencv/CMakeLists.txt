# Script to build OpenCV.
#
# SPDX-FileCopyrightText: 2015-2024 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#
#

set(EXTPREFIX_opencv "${EXTPREFIX}" )

set(Opencv_Conf -DBUILD_EXAMPLES=OFF
                -DBUILD_TESTS=OFF
                -DBUILD_DOCS=OFF
                -DBUILD_PERF_TESTS=OFF
                -DBUILD_NEW_PYTHON_SUPPORT=OFF
                -DBUILD_ZLIB=OFF
                -DOPENCV_BUILD_3RDPARTY_LIBS=OFF
                -DINSTALL_C_EXAMPLES=OFF
                -DINSTALL_PYTHON_EXAMPLES=OFF
                -DBUILD_opencv_core=ON
                -DBUILD_opencv_imgproc=ON
                -DBUILD_opencv_imgcodecs=ON
                -DBUILD_opencv_objdetect=ON
                -DBUILD_opencv_calib3d=ON
                -DBUILD_opencv_features2d=ON
                -DBUILD_opencv_flann=ON
                -DBUILD_opencv_dnn=ON
                -DBUILD_opencv_photo=OFF
                -DBUILD_opencv_java=OFF
                -DBUILD_opencv_java_bindings_generator=OFF
                -DBUILD_opencv_js=OFF
                -DBUILD_opencv_python2=OFF
                -DBUILD_opencv_python3=OFF
                -DBUILD_opencv_python_bindings_generator=OFF
                -DBUILD_opencv_ml=ON
                -DBUILD_opencv_shape=ON
                -DBUILD_opencv_highgui=ON
                -DBUILD_opencv_superres=ON
                -DBUILD_opencv_stitching=ON
                -DBUILD_opencv_videostab=OFF
                -DBUILD_opencv_videoio=OFF
                -DBUILD_opencv_video=OFF
                -DBUILD_opencv_apps=OFF
                -DBUILD_opencv_gapi=OFF
                -DWITH_PROTOBUF=ON
                -DWITH_1394=OFF
                -DWITH_VTK=OFF
                -DWITH_DIRECTX=OFF
                -DWITH_DSHOW=OFF
                -DWITH_EIGEN=OFF
                -DWITH_FFMPEG=OFF
                -DWITH_GSTREAMER=OFF
                -DWITH_GTK=OFF
                -DWITH_IPP=OFF
                -DWITH_JASPER=OFF
                -DWITH_JPEG=OFF
                -DWITH_MATLAB=OFF
                -DWITH_OPENEXR=OFF
                -DWITH_OPENNI=OFF
                -DWITH_OPENMP=OFF
                -DWITH_OPENJPEG=OFF
                -DWITH_PNG=OFF
                -DWITH_PVAPI=OFF
                -DWITH_WIN32UI=OFF
                -DWITH_QT=OFF
                -DWITH_QUICKTIME=OFF
                -DWITH_QT_OPENGL=OFF
                -DWITH_TBB=OFF
                -DWITH_TIFF=OFF
                -DWITH_UNICAP=OFF
                -DWITH_V4L=OFF
                -DWITH_VFW=OFF
                -DWITH_VIDEOINPUT=OFF
                -DWITH_XINE=OFF
                -DWITH_VA_INTEL=OFF
                -DWITH_GPHOTO2=OFF
                -DWITH_WEBP=OFF
                -DWITH_IMGCODEC_HDR=OFF
                -DWITH_IMGCODEC_SUNRASTER=OFF
                -DWITH_IMGCODEC_PXM=OFF
                -DCV_TRACE=OFF
                -DCV_ENABLE_INTRINSICS=OFF
                -DCV_DISABLE_OPTIMIZATION=ON
                -DWITH_CUDA=OFF
                -DWITH_CUFFT=OFF
                -DWITH_CUBLAS=OFF
                -DWITH_NVCUVID=OFF
                -DWITH_OPENCL=ON
                -DWITH_OPENCLAMDFFT=ON
                -DWITH_OPENCLAMDBLAS=ON
                -DWITH_OPENCL_D3D11_NV=ON
)

# See https://github.com/opencv/opencv/issues/23458#issuecomment-1495841155
# OPenCL SVM support under MacOS is not functional.

if(APPLE)

    set(Opencv_Conf ${Opencv_Conf}
                    -DWITH_OPENCL_SVM=OFF
    )
else()

    set(Opencv_Conf ${Opencv_Conf}
                    -DWITH_OPENCL_SVM=ON
    )

endif()

JoinListAsString("${Opencv_Conf}" " " BASH_OPTIONS)

if(APPLE)

    ExternalProject_Add(ext_opencv
        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

        GIT_REPOSITORY https://github.com/opencv/opencv.git
        GIT_TAG 4.10.0

        CONFIGURE_COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/../../../../bootstrap.${DK_APPLE_PACKAGE_MANAGER} <SOURCE_DIR>/. &&
                          <SOURCE_DIR>/bootstrap.${DK_APPLE_PACKAGE_MANAGER} ${EXTPREFIX_opencv} RelWithDebInfo ${ARCH_TARGET} "${BASH_OPTIONS}"

        BUILD_COMMAND cd <SOURCE_DIR>/build && $(MAKE)

        INSTALL_COMMAND cd <SOURCE_DIR>/build && make install/fast

        BUILD_IN_SOURCE 1

        UPDATE_COMMAND ""
        ALWAYS 0
    )

else() # Linux

    ExternalProject_Add(ext_opencv
        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

        GIT_REPOSITORY https://github.com/opencv/opencv.git
        GIT_TAG 4.10.0

        INSTALL_DIR ${EXTPREFIX_opencv}

        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_opencv}
                   -DCMAKE_BUILD_TYPE=${GLOBAL_BUILD_TYPE}
                   ${GLOBAL_PROFILE}
                   ${Opencv_Conf}

        UPDATE_COMMAND ""
        ALWAYS 0
    )

endif()
