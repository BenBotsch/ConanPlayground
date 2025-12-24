#include <iostream>
#include <hello/hello.h>
#include <adder/adder.h>

int main() 
{
    std::cout << hello::greet("Playground") << " 2+3=" << adder::add(2,3) << std::endl;
    return 0;
}
