#include <stdio.h>

int main(){

    int H[4] = {1, 1, 0, 1};
    int v[2] = {1, 1};

    int p10 = H[2] & v[0];
    int p11 = (H[3] & v[1]) ^ p10;
    printf("%d %d\n", p10, p11);

    int p00 = H[0] & v[0];
    int p01 = (H[1] & v[1]) ^ p00;
    printf("%d %d\n", p00, p01);

    
    printf("%d %d\n", p01, p11);
    
    return 0;
}