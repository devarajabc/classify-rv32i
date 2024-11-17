.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1 
    blt a1, t6, handle_error # break if there's no element
    lw t0, 0(a0) # max
    li t1, 0 # i
    li t2, 0 # address of i
    li t4, 0 # position of the max
loop_start:
    # TODO: Add your own implementation
    bge     t1, a1, end
    slli    t2, t1, 2
    add     t2, a0, t2
    addi    t1, t1, 1
    lw      t2, 0(t2)
    bge     t0, t2, loop_start #if max >= a0[i] -> continue
    mv      t0, t2 # set Max()
    addi    t4, t1, -1 # set the index of max
    j   loop_start

handle_error:
    li a0, 36
    j exit

end:
    mv a0, t4
    jr ra
