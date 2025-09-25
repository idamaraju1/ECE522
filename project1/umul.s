## Author: Iresh Damaraju
##
## You may implement the following with any of the instructions in the RV32I instruction set
## and described in the reference sheet. Do not use any of the mul[h][s][u] instructions which
## are *not* described in the reference sheet. Remember to respect the calling convention - if
## you choose to use any of the callee saved registers s[0-11], remember to save them to the
## stack before reusing them (note, you should not need to do this but are free to do so).
##
## [Description]
## Multiplies two 32-bit *unsigned* numbers and provides a 32-bit *unsigned* result
## consisting of the lower 32 bits of the product.
##
## [Arguments]
## a0 = multiplicand
## a1 = multiplier
##
## [Returns]
## a0 = 32-bit product

.text
.globl umul
umul:

    addi    t0, x0, 0       # res = 0
    addi    t1, a1, 0       # t1 = multiplier (b)
    addi    t2, a0, 0       # t2 = multiplicand (a)

    beq     t1, x0, 1f      # if b==0, return 0

0:  andi    t3, t1, 1       # t3 = b & 1
    beq     t3, x0, 2f      # if LSB==0, skip add
    add     t0, t0, t2      # res += a (mod 2^32)
2:  slli    t2, t2, 1       # a <<= 1
    srli    t1, t1, 1       # b >>= 1
    bne     t1, x0, 0b      # loop while b != 0

1:  addi    a0, t0, 0       # move result to a0 (no 'mv' pseudo)
    jalr    x0, ra, 0       # return (no 'ret' pseudo)