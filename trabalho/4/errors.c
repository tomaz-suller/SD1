#include <stdio.h>

int main(int argc, char** argv){
    if(argc == 1)
        for(int i = 0; i < 22; i++)
            printf("mem_data(%d) xor ", i);
    else
        for(int i = 1; i < argc; i++)
            printf("mem_data(%s) xor ", argv[i]);
    
    printf("\n");
    return 0;
}