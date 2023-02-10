mkdir -p build
docker run --rm openmwweb cat ./build/boost_hello_world.js > build/boost_hello_world.js
docker run --rm openmwweb cat ./build/boost_hello_world.wasm > build/boost_hello_world.wasm
docker run --rm openmwweb cat ./build/boost_hello_world.html > build/boost_hello_world.html