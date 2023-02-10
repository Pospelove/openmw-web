#include <boost/filesystem.hpp>
#include <iostream>

int main() {
    boost::filesystem::path p("hello_world.txt");
    std::cout << p << std::endl;
    return 0;
}