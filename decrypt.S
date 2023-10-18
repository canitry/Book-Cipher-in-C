#ifndef MYDECRYPT_S
#else
// version 1.0 11/12/2022
    .arch armv6
    .arm
    .fpu vfp
    .syntax unified

    #include "cipher.h"

    .text     // start of text segment

    //////////////////////////////////////////////////
    // int decrypt(char *iobuf, char *bookbuf, int cnt)
    // decrypts iobuf using bookbuf; result in iobuf
    //////////////////////////////////////////////////
    .global decrypt
    .type   decrypt, %function
    .equ    FP_OFF, 28

decrypt:
    push    {r4-r9, fp, lr}
    add     fp, sp, FP_OFF
    // do not alter anything above this line
    // r0 contains char *iobuf
    // r1 contains char *bookbuf
    // r2 contains cnt
    // r3 is ok to use
    // r4-r9 preserved registers are ok to use

    cmp     r2, 0               // if buffer empty we are done
    ble     .Ldone

    // your code here
    // r4 contains copy of encoded iobuf byte
    // r5 contains corresponding bookbuf byte
    // r6 contains isolated bit in byte to be unreversed
    // r7 contains the counter (j) for the outer loop traversing the iobuf
    // r8 contains the counter (i) for the inner loop unreversing the bits
    
    //traverses iobuf till all bytes in buffer are decrypted
    mov     r7, 0 //sets counter for outer loop (j) to 0
.Loutfor:
    // reverses the bits in the byte
    ldrb    r4, [r0, r7] //loads copy of the *(iobuf+j) byte
    ldrb    r5, [r1, r7] //loads copy of the *(bookbuf+j) byte
    eor     r4, r4, r5

    // r5 is repurposed to hold the decoded byte
    mov     r5, 0 //reset decoded byte to 0
    mov     r8, 0 //set counter for inner loop (i) to 0.
.Linfor:
    cmp     r8, 8 //NBITS for inner loop guard
    bge     .Linforend

    and     r6, r4, 1 //mask off rightmost bit
    lsr     r4, r4, 1 
    mov     r9, 7 //NBITS -1
    sub     r9, r9, r8 //(NBITS-1)-i
    lsl     r6, r6, r9 //shift isolated bit to unreversed position
    add     r5, r5, r6 //add shifted bit to decoded byte
    add     r8, r8, 1 //increment i
    b       .Linfor

.Linforend:
    // r4 is repurposed to contain the byte from the book cipher
    strb    r5, [r0, r7] //replace encrypted byte in io buffer with decrypted byte

    add     r7, r7, 1 //increment j

    cmp     r7, r2 // loop guard for outer loop
    blt     .Loutfor

    // do not alter anything below this line
.Ldone:
    mov     r0, r2              // return cnt processed
    sub     sp, fp, FP_OFF
    pop     {r4-r9, fp, lr}
    bx      lr

    .size decrypt, (. - decrypt)
    .section .note.GNU-stack,"",%progbits
.end
#endif
