# Script to build llama.cpp
#
# SPDX-FileCopyrightText: 2026 by Srirupa Datta <srirupa dot sps at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#

set(PREFIX_ext_llamacpp "${EXTPREFIX}")

# Pin to the same revision as the vendored snapshot (2026-07-07). A tagged
# release could be used instead once confirmed to match the API the code needs.

set(LLAMA_CPP_GIT_TAG v0.3.0)

# Match the flags used by the vendored wrapper: library only, CPU-only, and a
# portable CPU baseline (GGML_NATIVE OFF) so the distributed binary does not
# SIGILL on older CPUs.

set(Llama_Conf -DLLAMA_BUILD_IS_DEV=OFF
               -DLLAMA_BUILD_TESTS=OFF
               -DLLAMA_BUILD_EXAMPLES=OFF
               -DLLAMA_BUILD_TOOLS=OFF
               -DLLAMA_BUILD_SERVER=OFF
               -DLLAMA_BUILD_APP=OFF
               -DLLAMA_BUILD_COMMON=OFF
               -DLLAMA_CURL=OFF
               -DGGML_CUDA=OFF
               -DGGML_METAL=OFF
               -DGGML_VULKAN=OFF
               -DGGML_NATIVE=OFF
               -DBUILD_SHARED_LIBS=ON
)

JoinListAsString("${Llama_Conf}" " " BASH_OPTIONS)

if(APPLE)

    ExternalProject_Add(ext_llamacpp
        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
        GIT_REPOSITORY https://github.com/ggml-org/llama.cpp.git
        GIT_TAG ${LLAMA_CPP_GIT_TAG}

        CONFIGURE_COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/../../../scripts/create_manifest.sh <SOURCE_DIR>/. &&
                          cd <SOURCE_DIR> &&
                          <SOURCE_DIR>/create_manifest.sh ${EXTERNALS_DOWNLOAD_DIR} llamacpp &&
                          cp -f ${CMAKE_CURRENT_SOURCE_DIR}/../../../../bootstrap.${DK_APPLE_PACKAGE_MANAGER} <SOURCE_DIR>/. &&
                          <SOURCE_DIR>/bootstrap.${DK_APPLE_PACKAGE_MANAGER} ${PREFIX_ext_llamacpp} Release ${CMAKE_HOST_SYSTEM_PROCESSOR} ${BASH_OPTIONS}

        BUILD_COMMAND cd <SOURCE_DIR>/build && $(MAKE)

        INSTALL_COMMAND cd <SOURCE_DIR>/build && $(MAKE) install/fast

        BUILD_IN_SOURCE 1

        UPDATE_COMMAND ""
        ALWAYS 0
    )

elseif(MSVC)

    ExternalProject_Add(ext_llamacpp
        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
        GIT_REPOSITORY https://github.com/ggml-org/llama.cpp.git
        GIT_TAG ${LLAMA_CPP_GIT_TAG}

        PATCH_COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/../../../scripts/create_manifest.sh <SOURCE_DIR>/. &&
                      cd <SOURCE_DIR> &&
                      bash --noprofile <SOURCE_DIR>/create_manifest.sh ${EXTERNALS_DOWNLOAD_DIR} llamacpp

        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${PREFIX_ext_llamacpp}
                   -DCMAKE_BUILD_TYPE=Release
                   ${Llama_Conf}
                   ${GLOBAL_PROFILE}

        UPDATE_COMMAND ""
        ALWAYS 0
    )

else() # Linux

    ExternalProject_Add(ext_llamacpp
        DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
        GIT_REPOSITORY https://github.com/ggml-org/llama.cpp.git
        GIT_TAG ${LLAMA_CPP_GIT_TAG}

        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${PREFIX_ext_llamacpp}
                   -DCMAKE_BUILD_TYPE=Release
                   ${Llama_Conf}
                   ${GLOBAL_PROFILE}

        UPDATE_COMMAND ""
        ALWAYS 0
    )

endif()
