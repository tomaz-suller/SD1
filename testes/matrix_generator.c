#include <stdio.h>
#include <math.h>

int main(){

    int conditional;
    int data_size = 16;
    int mem_size = 22;

    int height = mem_size - data_size - 2; 
    int width = mem_size - 1;

    int parity = 1;
    for(int i = 0; i <= height; i++, parity *= 2){
        for(int j = 1; j <= width; j++){
            conditional = (parity & j) != 0;   
            printf("%d", conditional);
        }
        printf("\n");
    }
    printf("\n");
}