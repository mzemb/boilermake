#include <stdio.h>
#include "target/gitHash.h"

int main (void){
    printf( "hello world, I'm %s build on %s from %s\n"
    ,   __FILE__
    ,   __DATE__
    ,   GIT_HASH_STR
    );
    return 0;
}

