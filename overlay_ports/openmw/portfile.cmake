vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO Pospelove/openmw
	REF f689fab398d07a11bc991f9164d94dcd98a85b5c
	SHA512 b04fe47c83bc52e56e62e96307ad376938ac1f9380120d3954e54401d231b54e1b4a06f7da11bd0ecf274472ca913ce997d97d665d5f67a4160b989cd2c1cb27
	HEAD_REF master
)

file(WRITE ${SOURCE_PATH}/cmake/CheckBulletPrecision.cmake "set(HAS_DOUBLE_PRECISION_BULLET \"1\")")

file(WRITE ${SOURCE_PATH}/cmake/CheckLuaCustomAllocator.cmake "")

file(COPY ${CMAKE_CURRENT_LIST_DIR}/FindMyGUI.cmake DESTINATION ${SOURCE_PATH}/cmake)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/components/CMakeLists.txt DESTINATION ${SOURCE_PATH}/components)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})


vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DBUILD_LAUNCHER=OFF
        -DBUILD_OPENCS=OFF
        -DBUILD_WIZARD=OFF
        -Dcollada_dom_DIR=${CURRENT_INSTALLED_DIR}/share/collada-dom # TODO: fix collada-dom-config.cmake detection
        -DOPENMW_USE_SYSTEM_ICU=ON
        -DOPENMW_USE_SYSTEM_YAML_CPP=ON
        -DUSE_LUAJIT=FALSE # not available in webassembly

        "-DCMAKE_CXX_FLAGS=-s USE_ICU=1"
        "-DCMAKE_EXE_LINKER_FLAGS=-s USE_ICU=1"
        "-DCMAKE_SHARED_LINKER_FLAGS=-s USE_ICU=1" # not sure if this is needed and if this is a real variable
)

vcpkg_cmake_install()