
set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "/emsdk/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake")

set(VCPKG_TARGET_TRIPLET "wasm32-emscripten")

set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake")

# File from vcpkg submodule. This indicates inability to find this file or checkout submodules.
if(NOT EXISTS "${CMAKE_TOOLCHAIN_FILE}")
  set(msg "${CMAKE_TOOLCHAIN_FILE} doesn't exist. It seems that vcpkg submodule is not initialized.")
  set(msg "${msg}\nUse commands below to initialize:")
  set(msg "${msg}\n  git submodule init")
  set(msg "${msg}\n  git submodule update")
  message(FATAL_ERROR "${msg}")
endif()

cmake_minimum_required(VERSION 3.15)
project(openmw_web)

# use opengl
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s USE_WEBGL2=1")

# -s LEGACY_GL_EMULATION=1 to cxx flags
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s LEGACY_GL_EMULATION=1")

find_package(Boost REQUIRED)

file(GLOB_RECURSE src src/boost_hello_world/*)
add_executable(boost_hello_world ${src})

target_link_libraries(boost_hello_world PRIVATE Boost::boost)

# change suffix to .html
set_target_properties(boost_hello_world PROPERTIES SUFFIX ".html")

# find opengl
find_package(OpenGL REQUIRED)

file(GLOB_RECURSE src src/opengl_hello_world/*)
add_executable(opengl_hello_world ${src})

# link opengl (seems to use emscripten's opengl not vcpkg's)
target_link_libraries(opengl_hello_world PRIVATE ${OPENGL_LIBRARIES})
target_include_directories(opengl_hello_world PRIVATE ${OPENGL_INCLUDE_DIR})


# change suffix to .html
set_target_properties(opengl_hello_world PROPERTIES SUFFIX ".html")