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
#   a3 (int):   Skip distance in first array (stride0)
#   a4 (int):   Skip distance in second array (stride1)
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

    li t0, 0    # final sum        
    li t1, 0    # i 

loop_start:
    bge t1, a2, loop_end

    # Load elements arr0[i * stride0] and arr1[i * stride1]
    lw t3, 0(a0) # Load arr0[i]
    lw t4, 0(a1) # Load arr1[i]
    
    li t5, 0    # accumulator for this pair

    # Long multiplication loop
multiply_loop:
    andi t6, t4, 1          # Check if LSB of t4 is 1
    beqz t6, skip_add       # If LSB is 0, skip addition
    add t5, t5, t3          # Add t3 to t5

skip_add:
    slli t3, t3, 1          # Shift t3 left by 1 (double t3)
    srli t4, t4, 1          # Shift t4 right by 1 (half t4)
    bnez t4, multiply_loop  # Continue loop if t4 != 0

    # Add product to final sum
    add t0, t0, t5
    
    # Update pointers a0 and a1 based on strides
    slli t2, a3, 2    # stride0 * sizeof(int)
    slli t3, a4, 2    # stride1 * sizeof(int)
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
