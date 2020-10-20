#include <stdio.h>

int powerOfTwo(int a){
    while(a > 2){
        if(a % 2 != 0) return 0;
        a /= 2;
    }
    return 1;
}

int main(){

    int index = 0;
    for(int parity = 0; parity < 17; parity *= 2){
        printf("p%d <= ", parity);
        for(int i = 0; i < 22; i++, index++){
            if(! powerOfTwo(i)){
                int choice = parity & i;
                if(choice)
                    printf("xor u_data(%d) ", index);
                //index++;
            }
        }
        index = 0;
        printf(";\n");
    }

    return 0;
}