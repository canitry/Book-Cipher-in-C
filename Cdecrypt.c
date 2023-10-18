// version 1.0 11/12/2022
#include <stdio.h>
#include "cipher.h"
#define NBITS 8

#ifdef MYDECRYPT_C
TODO("using Cdecrypt.c");

int
decrypt(char *iobuf, char *bookbuf, int cnt)
{

    // your code here
    unsigned int byte; /* copies encrypted bytes in iobuf to decode */
    unsigned int decByte; /* the decrypted byte */
    unsigned int mask = 1; /* mask to isolate each bit to un-reverse it */
    unsigned int masked; /* isolated bit to be unreversed */
    unsigned int bkByte; /* copy of coresp byte of book buf to var byte */
   /*
    * traverses iobuf till all bytes in buffer are encrypted
    */
    for (int j = 0; j < cnt; j++){
        byte = *(iobuf + j);
        /* eors with book cipher */
        bkByte = *(bookbuf + j);
        byte = byte ^ bkByte;
        /* unreverses the byte */
        decByte = 0;
        for (int i = 0; i < NBITS; i++){
            masked = byte & mask;
            byte = byte >> 1;
            masked = masked << (NBITS-1-i);
            decByte = decByte + masked;
        }

        /* replaces the byte in buffer with the decrypted byte */
        *(iobuf+j)=decByte;
    }

    return cnt;
}

#elif defined MYDECRYPT_S
TODO("using decrypt.S");
#else
TODO("using solution decrypt");
#endif
