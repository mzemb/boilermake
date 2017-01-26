#include <stdio.h>
#include "target/gitHash.h"

int main (void){
    printf( "hello world, I'm %s build on %s from %s (len=%u)\n"
    ,   __FILE__
    ,   __DATE__
    ,   GIT_HASH_STR
    ,   (unsigned)GIT_HASH_LEN
    );
    return 0;
}

