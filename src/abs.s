.globl abs

.text
# =================================================================
# FUNCTION: Absolute Value Converter
#
# Transforms any integer into its absolute (non-negative) value by
# modifying the original value through pointer dereferencing.
# For example: -5 becomes 5, while 3 remains 3.
#
# Args:
#   a0 (int *): Memory address of the integer to be converted
#
# Returns:
#   None - The operation modifies the value at the pointer address
# =================================================================
abs:
    # Prologue
    ebreak
    # Load number from memory
    lw t0 0(a0)
    bge t0, zero, done

    # TODO: Add your own implementation
    srai    t1, t0, 31 # mask = x >> 31; 1111... (-1)for neg, 000000.... (0)for pos
    xor     t0, t0, t1 # x = x XOR mask; like "not" => ~x
    sub     t0, t0, t1 # x = x - mask(-1 or 0); (x = ~x + 1) => 
    sw      t0, 0(a0) #store 
done:
    # Epilogue
    jr ra
