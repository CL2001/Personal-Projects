#include <stdio.h>
#include "myfunc.h"

int main(void) {
    printf("In main function\n");
    myFunction();  // Calling the function from myfunc.c
    return 0;
}
