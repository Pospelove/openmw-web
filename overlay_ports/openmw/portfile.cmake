vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO OpenMW/openmw
	REF 18d488d968c3c8039d7c116e93e455c7649f3323
	SHA512 bd437c3cbbb750d61693fec4f0fb95aeefddab1e570c4e1cca2122ebbfb94609bce7e33f3f8e8012cd2f371a4b99e9c53b3b99eb0fba6561327b9a1b6c3bad56
	HEAD_REF master
)

file(WRITE ${SOURCE_PATH}/cmake/CheckBulletPrecision.cmake "set(HAS_DOUBLE_PRECISION_BULLET \"1\")")

file(COPY ${CMAKE_CURRENT_LIST_DIR}/FindMyGUI.cmake DESTINATION ${SOURCE_PATH}/cmake)
#file(COPY ${CMAKE_CURRENT_LIST_DIR}/FindRecastNavigation.cmake DESTINATION ${SOURCE_PATH}/cmake)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/components/CMakeLists.txt DESTINATION ${SOURCE_PATH}/components)


vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DBUILD_LAUNCHER=OFF
        -DBUILD_OPENCS=OFF
        -DBUILD_WIZARD=OFF
        -Dcollada_dom_DIR=${CURRENT_INSTALLED_DIR}/share/collada-dom # TODO: fix collada-dom-config.cmake detection
        -DOPENMW_USE_SYSTEM_ICU=OFF # uses FetchContent, TODO: use vcpkg icu port instead
        -DOPENMW_USE_SYSTEM_YAML_CPP=OFF # uses FetchContent, TODO: use vcpkg yaml-cpp port instead
        -DUSE_LUAJIT=FALSE # not available in webassembly
)