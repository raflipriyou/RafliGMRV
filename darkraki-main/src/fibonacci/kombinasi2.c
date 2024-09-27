#include <stdio.h>

long long factorial(int n) {
    long long result = 1;
    for (int i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
}

long long combination(int n, int r) {
    return factorial(n) / (factorial(r) * factorial(n-r));
}

int main() {
    int n = 5;
    int r = 3;
    long long result = combination(n, r);
    //printf("The combination C(%d, %d) is: %lld\n", n, r, result);
    return 0;
}