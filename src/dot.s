.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0    # finanl        
    li t1, 0    # i 
    li t2, 0    #stride0 / value of arr0[i]
    li t3, 0    #stride1 / value of arr1[i]
loop_start:
    bge t1, a2, loop_end
    # for every `i`, get i * stride0 and i * stride1 than do mul
    lw t2, 0(a0) #arr0[i]
    lw t3, 0(a1) #arr1[i]
    
    li t4, 0    # inner counter
mul: # sum(arr0[i] * arr1[i])
    add t0, t0, t2
    addi t4, t4, 1
    blt t4, a4, index_of_arr1
    slli t3, t5, 2
      
    # update address
    slli t2, a3, 2
    slli t3, a4, 2
    add a0, a0, t2
    add a1, a1, t3
    addi t1, t1, 1
    j loop_start
loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit
