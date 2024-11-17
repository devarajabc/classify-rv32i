.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li t0, 1             
    blt a1, t0, error  # beak, if the number of the array is less than 1 
    li t1, 0             # int i = 0;
    li t4, 0

loop_start:
    # TODO: Add your own implementation
    bge     t1, a1, exit # if i >= a1 break
    slli    t2, t1, 2 # Multiply i by 4
    add     t2, a0, t2 # update t2 (address of a0[i])
    addi    t1, t1, 1 # i++
    lw      t3, 0(t2) # t3 = a0[i] 
    bge     t3, t4, loop_start
    sw      t4, 0(t2) # set to zero
    j       loop_start # jump back to start of loop

error:
    li a0, 36          
    j exit          
exit: