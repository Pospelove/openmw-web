vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO OpenMW/openmw
	REF 18d488d968c3c8039d7c116e93e455c7649f3323
	SHA512 bd437c3cbbb750d61693fec4f0fb95aeefddab1e570c4e1cca2122ebbfb94609bce7e33f3f8e8012cd2f371a4b99e9c53b3b99eb0fba6561327b9a1b6c3bad56
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
        -DOPENMW_USE_SYSTEM_ICU=ON # OFF = FetchContent (didn't work for me)
        -DOPENMW_USE_SYSTEM_YAML_CPP=ON # uses FetchContent, TODO: use vcpkg yaml-cpp port instead
        -DUSE_LUAJIT=FALSE # not available in webassembly

        # didn't help at all
        "-DCMAKE_CXX_FLAGS=-s USE_ICU=1"
        "-DCMAKE_EXE_LINKER_FLAGS=-s USE_ICU=1"
        "-DCMAKE_SHARED_LINKER_FLAGS=-s USE_ICU=1" # not sure if this is needed and if this is a real variable
)

vcpkg_cmake_install()