# Nome: André Avelino Freitas de Oliveira
#
# Revisões/Commits:
# 
# 1° commit:
# Data: 30/11/2025 | Hora: 17:57:00 | Revisao: 1.0
# Comentário: Estrutura inicial e conversao Decimal -> Binario.
#
# 2° commit:
# Data: 30/11/2025 | Hora: 18:21:00 | Revisao: 2.0 
# Comentário: Implementacao das conversoes Octal, Hexadecimal e BCD.

.data
    msg_titulo:     .asciiz "CALCULADORA PROGRAMADOR DIDATICA MIPS\n"
    msg_prompt_dec: .asciiz "Digite um numero decimal positivo: "
    msg_dec_bin:    .asciiz "Passo a passo Decimal -> Binario:\n"
    msg_resto:      .asciiz "Quociente: "
    msg_quoc:       .asciiz " | Resto: "
    msg_resultado:  .asciiz "Resultado Binario: "
    newline:        .asciiz "\n"

.text
.globl main

main:
    li $v0, 4
    la $a0, msg_titulo
    syscall

    li $v0, 4
    la $a0, msg_prompt_dec
    syscall

    li $v0, 5
    syscall
    move $s0, $v0

    move $a0, $s0
    jal dec_para_bin
    
    move $a0, $s0
    jal dec_para_oct
    
    move $a0, $s0
    jal dec_para_hex
    
    move $a0, $s0
    jal dec_para_bcd

    li $v0, 10
    syscall

dec_para_bin:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $v0, 4
    la $a0, msg_dec_bin
    syscall

    move $t0, $a0
    li $t1, 2

dec_para_oct:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    li $v0, 4; la $a0, msg_dec_oct; syscall
    move $t0, $a0; li $t1, 8
    jal conversao_generica
    li $v0, 4; la $a0, msg_resultado_oct; syscall
    jal imprime_resultado
    lw $ra, 0($sp); addi $sp, $sp, 4; jr $ra

dec_para_hex:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    li $v0, 4; la $a0, msg_dec_hex; syscall
    move $t0, $a0; li $t1, 16
    jal conversao_generica
    li $v0, 4; la $a0, msg_resultado_hex; syscall
    jal imprime_hex_resultado
    lw $ra, 0($sp); addi $sp, $sp, 4; jr $ra

dec_para_bcd:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    li $v0, 4; la $a0, msg_dec_bcd; syscall
    li $v0, 4; la $a0, msg_resultado_bcd; syscall
    lw $ra, 0($sp); addi $sp, $sp, 4; jr $ra
    
conversao_loop:
    beq $t0, $zero, fim_loop

    li $v0, 4
    la $a0, msg_resto
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    div $t0, $t1
    mflo $t0
    mfhi $t2

    li $v0, 4
    la $a0, msg_quoc
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    addi $sp, $sp, -4
    sw $t2, 0($sp)

    j conversao_loop

fim_loop:
    li $v0, 4
    la $a0, msg_resultado
    syscall

    lw $s1, 0($sp)
    addi $sp, $sp, 4

imprime_loop:
    lw $t3, 0($sp)
    addi $sp, $sp, 4

    li $v0, 1
    move $a0, $t3
    syscall

    lw $t4, 0($sp)
    bne $sp, 4($s0), imprime_loop

    li $v0, 4
    la $a0, newline
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra