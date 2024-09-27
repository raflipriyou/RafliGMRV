#include <stdio.h>

int getFib(int n, int a, int b) {
    // If the number of terms is smaller than 1
    if (n < 1) {
        return -1; // Mengembalikan nilai error jika n kurang dari 1
    }

    int curr = 0;

    // for loop that computes n terms of Fibonacci series
    for (int i = 1; i <= n; i++) {
        if (i > 2) {
            curr = a + b;
            a = b;
            b = curr;
        }
        else if (i == 1) {
            curr = a; // First Fibonacci number
        }
        else if (i == 2) {
            curr = b; // Second Fibonacci number
        }
    }
    
    return curr; // Mengembalikan elemen Fibonacci terakhir
}

int main() {
    int n = 14;
    int a = 0;
    int b = 1;
    
    // Call getFib function and store the result
    int fibResult = getFib(n, a, b);
    
    // Return the result
    return fibResult;
}