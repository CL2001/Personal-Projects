//cd "Assembly/C_to_asm"
//gcc -S display_nums.c -o display_nums.asm
#include <stdio.h>

void display(int num) {
    printf("%d\n", num);
}

int main() {
    int N = 1;
    int M = 5;
    for (int i = N; i <= M; i++) {
        display(i);
    }
    return 0;
}