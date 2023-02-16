FROM --platform=arm64 emscripten/emsdk:3.1.31

WORKDIR /openmw-web

RUN apt-get update -y \
    && apt-get install -y \
        autoconf \
        automake \
        libtool \
        pkg-config \
        bison

 RUN mkdir vcpkg \
     && cd vcpkg \
     && git init \
     && git remote add pospelove https://github.com/Microsoft/vcpkg.git \
     && git fetch --depth=1 pospelove 1c48ec7f49d69bb753e6afefba51368e18263255 \
     && git checkout FETCH_HEAD \
     && ./bootstrap-vcpkg.sh

COPY patches/brotli/portfile.cmake vcpkg/ports/brotli/portfile.cmake
COPY patches/ffmpeg/portfile.cmake vcpkg/ports/ffmpeg/portfile.cmake

RUN ./vcpkg/vcpkg install ffmpeg:wasm32-emscripten
RUN ./vcpkg/vcpkg install bullet3:wasm32-emscripten

RUN ./vcpkg/vcpkg install sqlite3:wasm32-emscripten
RUN ./vcpkg/vcpkg install lz4:wasm32-emscripten
RUN ./vcpkg/vcpkg install sdl2:wasm32-emscripten
RUN ./vcpkg/vcpkg install mygui:wasm32-emscripten
RUN ./vcpkg/vcpkg install openal-soft:wasm32-emscripten

COPY patches/boost-build/portfile.cmake vcpkg/ports/boost-build/portfile.cmake
COPY patches/boost-build/0003-fix-emscripten.patch vcpkg/ports/boost-build/0003-fix-emscripten.patch
COPY patches/boost-modular-build-helper/boost-modular-build.cmake vcpkg/ports/boost-modular-build-helper/boost-modular-build.cmake
COPY patches/boost-modular-build-helper/CMakeLists.txt vcpkg/ports/boost-modular-build-helper/CMakeLists.txt

COPY patches/liblzma/portfile.cmake vcpkg/ports/liblzma/portfile.cmake
RUN ./vcpkg/vcpkg install liblzma:wasm32-emscripten

# CMD ./vcpkg/vcpkg install pcre:wasm32-emscripten

# collada-dom deps except pcre which is problematic
RUN ./vcpkg/vcpkg install \
    boost-filesystem:wasm32-emscripten \
    boost-system:wasm32-emscripten \
    libxml2:wasm32-emscripten \
    minizip:wasm32-emscripten \
    uriparser:wasm32-emscripten \
    zlib:wasm32-emscripten

RUN ./vcpkg/vcpkg install libpng:wasm32-emscripten

COPY patches/collada-dom/vcpkg.json vcpkg/ports/collada-dom/vcpkg.json
COPY patches/collada-dom/portfile.cmake vcpkg/ports/collada-dom/portfile.cmake
COPY patches/collada-dom/fix-emscripten.patch vcpkg/ports/collada-dom/fix-emscripten.patch
RUN ./vcpkg/vcpkg install collada-dom:wasm32-emscripten

#RUN ./vcpkg/vcpkg install opengl:wasm32-emscripten

# RUN ./vcpkg/vcpkg install libjpeg:wasm32-emscripten
COPY patches/osg/portfile.cmake vcpkg/ports/osg/portfile.cmake
COPY patches/osg/vcpkg.json vcpkg/ports/osg/vcpkg.json

RUN ./vcpkg/vcpkg install osg:wasm32-emscripten

# COPY CMakeLists.txt CMakeLists.txt
# COPY src src
# RUN mkdir build \
#     && cd build \
#     && cmake .. \
#     && cmake --build .

# CMD npx http-server build

#CMD ./vcpkg/vcpkg install osg:wasm32-emscripten
#COPY overlay_ports/ ./overlay_ports/


# RUN ./vcpkg/vcpkg install boost-winapi:wasm32-emscripten \
#     boost-vcpkg-helpers:wasm32-emscripten \
#     boost-type-traits:wasm32-emscripten \
#     boost-throw-exception:wasm32-emscripten \
#     boost-system:wasm32-emscripten \
#     boost-smart-ptr:wasm32-emscripten \
#     boost-predef:wasm32-emscripten \
#     boost-iterator:wasm32-emscripten \
#     boost-io:wasm32-emscripten \
#     boost-detail:wasm32-emscripten \
#     boost-core:wasm32-emscripten \
#     boost-container-hash:wasm32-emscripten \
#     boost-config:wasm32-emscripten \
#     boost-atomic:wasm32-emscripten \
#     boost-assert:wasm32-emscripten \
#     boost-build \
#     boost-modular-build-helper \
#     vcpkg-cmake
# CMD ./vcpkg/vcpkg install boost-filesystem:wasm32-emscripten

#--overlay-ports=/openmw-web/overlay_ports