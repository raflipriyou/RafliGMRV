#include <stdio.h>

long factorial(int n) {
    if (n == 0 || n == 1)
        return 1;
    long factorial = 1;
    for (int i = 2; i <= n; i++)
        factorial = factorial * i;
    return factorial;
}

long nCr(int n, int r) {
    return factorial(n) / (factorial(r) * factorial(n - r));
}

int main() {
    int n = 5, r = 3;
    int ComResult = nCr(n, r);  // Memanggil fungsi tanpa menampilkan hasil

    return ComResult;
}
