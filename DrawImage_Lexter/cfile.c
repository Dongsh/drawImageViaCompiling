//
//  cfile.c
//  cstring
//
//  Created by Dongsh.
//  Copyright (c) 2015年 Dongsh.dev. All rights reserved.
//
#include <stdio.h>

void getString(char *str) {
    char *a = str;
    char temp;
    int i = 0;
    do{
        temp = getchar();
//        if (temp == '\n')
//            a[i] = ' ';
//        else
            a[i] = temp;
        i++;
    }while (temp != '#');
    
    str = a;
    
}
