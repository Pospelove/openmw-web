FROM --platform=arm64 emscripten/emsdk:3.1.31

WORKDIR /openmw-web

RUN apt-get update -y \
    && apt-get install -y \
        autoconf \
        automake \
        libtool \
        pkg-config

 RUN mkdir vcpkg \
     && cd vcpkg \
     && git init \
     && git remote add pospelove https://github.com/Pospelove/vcpkg.git \
     && git fetch --depth=1 pospelove 31c8367c9f6b34fbf1614be1f399e605bee00269 \
     && git checkout FETCH_HEAD \
     && ./bootstrap-vcpkg.sh

COPY overlay_ports/ ./overlay_ports/
COPY patches/brotli/portfile.cmake vcpkg/ports/brotli/portfile.cmake

RUN ./vcpkg/vcpkg install boost-algorithm[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-align[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-array[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-asio[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-assert[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-bind[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-build[core]:x64-linux
RUN ./vcpkg/vcpkg install boost-chrono[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-concept-check[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-config[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-container[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-container-hash[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-conversion[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-core[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-date-time[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-describe[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-detail[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-exception[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-function[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-function-types[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-functional[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-fusion[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-integer[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-intrusive[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-io[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-iterator[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-lexical-cast[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-logic[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-modular-build-helper[core]:x64-linux
RUN ./vcpkg/vcpkg install boost-move[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-mp11[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-mpl[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-numeric-conversion[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-optional[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-predef[core]:wasm32-emscripten

RUN ./vcpkg/vcpkg install boost-preprocessor[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-range[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-ratio[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-rational[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-regex[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-smart-ptr[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-static-assert[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-system[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-throw-exception[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-tokenizer[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-tuple[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-type-index[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-type-traits[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-typeof[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-uninstall[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-uninstall[core]:x64-linux
RUN ./vcpkg/vcpkg install boost-unordered[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-utility[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-variant2[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-vcpkg-helpers[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install boost-winapi[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install brotli[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install bullet3[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install bzip2[core,tool]:wasm32-emscripten
RUN ./vcpkg/vcpkg install curl[core,non-http,openssl,ssl]:wasm32-emscripten
RUN ./vcpkg/vcpkg install dirent[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install egl-registry[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install expat[core]:wasm32-emscripten


COPY patches/ffmpeg/portfile.cmake vcpkg/ports/ffmpeg/portfile.cmake


RUN ./vcpkg/vcpkg install ffmpeg[avcodec,avdevice,avfilter,avformat,core,swresample,swscale]:wasm32-emscripten


RUN apt-get update -y \
    && apt-get install -y \
        bison

RUN ./vcpkg/vcpkg install gettext[core]:wasm32-emscripten

RUN ./vcpkg/vcpkg install fontconfig[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install freeglut[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install freetype[brotli,bzip2,core,png,zlib]:wasm32-emscripten
RUN ./vcpkg/vcpkg install freexl[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install gdal[core,curl,default-features,expat,geos,gif,hdf5,iconv,jpeg,lerc,libkml,libspatialite,libxml2,lzma,netcdf,openjpeg,openssl,pcre2,png,postgresql,qhull,recommended-features,sqlite3,webp,zstd]:wasm32-emscripten
RUN ./vcpkg/vcpkg install geos[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install getopt[core]:wasm32-emscripten
#RUN ./vcpkg/vcpkg install gettext[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install giflib[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install gperf[core]:x64-linux
RUN ./vcpkg/vcpkg install hdf5[core,cpp,szip,zlib]:wasm32-emscripten
RUN ./vcpkg/vcpkg install imath[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install jasper[core,default-features,opengl]:wasm32-emscripten
RUN ./vcpkg/vcpkg install json-c[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install lerc[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libgeotiff[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libgta[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libiconv[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libjpeg-turbo[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libkml[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install liblzma[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libpng[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libpq[core,lz4,openssl,zlib]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libspatialite[core,freexl,geocallbacks]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libsquish[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libuuid[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libwebp[core,libwebpmux,nearlossless,simd]:wasm32-emscripten
RUN ./vcpkg/vcpkg install libxml2[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install luajit[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install lz4[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install minizip[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install mygui[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install netcdf-c[core,dap,hdf5,nczarr,netcdf-4,platform-default-features]:wasm32-emscripten
RUN ./vcpkg/vcpkg install nlohmann-json[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install nvtt[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install openal-soft[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install openexr[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install opengl[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install opengl-registry[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install openjpeg[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install openssl[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install osg[core,default-features,fontconfig,freetype,nvtt,openexr,plugins,rest-http-device]:wasm32-emscripten
RUN ./vcpkg/vcpkg install pcre2[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install pkgconf[core]:x64-linux
RUN ./vcpkg/vcpkg install proj[core,net,tiff]:wasm32-emscripten
RUN ./vcpkg/vcpkg install pthread[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install pthreads[core]:wasm32-emscripten3
RUN ./vcpkg/vcpkg install qhull[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install sdl2[base,core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install sdl2-image[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install sqlite3[core,tool]:x64-linux
RUN ./vcpkg/vcpkg install sqlite3[core,rtree]:wasm32-emscripten
RUN ./vcpkg/vcpkg install szip[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install tiff[core,jpeg,lzma,zip]:wasm32-emscripten
RUN ./vcpkg/vcpkg install uriparser[core]:wasm32-emscripten

RUN ./vcpkg/vcpkg install zlib[core]:wasm32-emscripten
RUN ./vcpkg/vcpkg install zstd[core]:wasm32-emscripten

CMD ./vcpkg/vcpkg install openmw:wasm32-emscripten --overlay-ports=/openmw-web/overlay_ports