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
    li t3, 0
    li t4, 0 
    li t5, 0  #Initialize product
    

loop_start:
    bge t1, a2, loop_end
    # get the offset
    
    slli t2, t1, 2  
index_of_arr0:
    add t5, t5, t2
    addi t3, t3, 1
    blt t3, a3, index_of_arr0
    mv t2, t5 # store the offset 
    li t5, 0 # reset the Initialize product
    
    slli t3, t1, 2 # set t3
index_of_arr1:
    add t5, t5, t3
    addi t4, t4, 1
    blt t4, a4, index_of_arr1
    mv t3, t5 # store the offset 
    li t5, 0 # reset the Initialize product
    li t4, 0 # reset Loop index
    
    
    # load the value
    add t2, t2, a0
    add t3, t3, a1
    lw t2, 0(t2) #arr0[i * stride0]
    lw t3, 0(t3) #arr1[i * stride1]

mul_loop:
    add t0, t0, t2
    addi t4, t4, 1
    blt t4, t3, mul_loop
    addi t1, t1, 1
    li t4, 0 # reset Loop index
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
