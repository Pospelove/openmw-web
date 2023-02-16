set(MyGUI_Debug_FOUND 1)
set(MyGUI_LIBRARIES
  optimized
    /openmw-web/vcpkg/installed/wasm32-emscripten/lib/libMyGUIEngineStatic.a
    /openmw-web/vcpkg/installed/wasm32-emscripten/lib/libMyGUI.OpenGLESPlatform.a
  debug
    /openmw-web/vcpkg/installed/wasm32-emscripten/debug/lib/libMyGUIEngineStatic_d.a
    /openmw-web/vcpkg/installed/wasm32-emscripten/debug/lib/libMyGUI.OpenGLESPlatform_d.a
)
# TODO: fix _d on vcpkg side?
set(MyGUI_INCLUDE_DIRS /openmw-web/vcpkg/installed/wasm32-emscripten/include/MYGUI)