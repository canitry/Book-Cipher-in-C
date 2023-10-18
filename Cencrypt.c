// version 1.0 11/12/2022
#include <stdio.h>
#include "cipher.h"
#define NBITS 8
#ifdef MYENCRYPT_C
TODO("using Cencrypt.c");

int
encrypt(char *iobuf, char *bookbuf, int cnt)
{

    // your code here
    unsigned int byte; /* copy of iobuf bytes */
    unsigned int revByte; /* the var byte reversed */
    unsigned int mask = 1; /* mask to isolate each bit to reverse it */
    unsigned int masked; /* holds isolated bit that will be reversed */
    unsigned int bkByte; /* copies byte of bookbuf to encrypt byte */
   /*
    * traverses iobuf till all bytes in buffer are encrypted
    */
    for (int j = 0; j < cnt; j++){
        /* reverses the bits in the byte*/
        byte = *(iobuf + j);
        revByte = 0;
        for (int i = 0; i < NBITS; i++){
            masked = byte & mask;
            byte = byte >> 1;
            masked = masked << (NBITS-1-i);
            revByte = revByte + masked;
        }
        /* eors with book cipher */
        bkByte = *(bookbuf + j);
        revByte = revByte ^ bkByte;
        /* replaces byte in buffer with encrypted byte */
        *(iobuf+j)=revByte;
    }

    return cnt;
}

#elif defined MYENCRYPT_S
TODO("using encrypt.S");
#else
TODO("using solution encrypt");
#endif
