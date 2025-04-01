#include <iostream>
#include "greetings.h"

int main() {
    // Call the function from greetings.cpp
    sayHello();
    
    // Also print "Hello, World!" directly from main
    std::cout << "Hello, World from main!" << std::endl;
    
    return 0;
}
