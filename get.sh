mkdir -p build
docker run --rm openmwweb cat ./build/boost_hello_world.js > build/boost_hello_world.js
docker run --rm openmwweb cat ./build/boost_hello_world.wasm > build/boost_hello_world.wasm
docker run --rm openmwweb cat ./build/boost_hello_world.html > build/boost_hello_world.html

# opengl_hello_world
docker run --rm openmwweb cat ./build/opengl_hello_world.js > build/opengl_hello_world.js
docker run --rm openmwweb cat ./build/opengl_hello_world.wasm > build/opengl_hello_world.wasm
docker run --rm openmwweb cat ./build/opengl_hello_world.html > build/opengl_hello_world.html