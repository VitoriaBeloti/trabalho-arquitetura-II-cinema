.data

textinit:  .asciiz "\nSistema de venda de poltronas para cinema\n"
textomenu: .asciiz "\nMenu\n"
textop1:   .asciiz "1 - Ver Acentos Disponiveis\n"
textop2:   .asciiz "2 - Comprar Poltrona\n"
textoinstrucao: .asciiz "Digite a opcao desejada: "

.text

.globl main
main:
    li      $v0,    4           # syscall para imprimir na tela
    la      $a0,    textinit
    syscall 

    jal MENU                    # chama a funcao MENU

    li      $v0,    10          # syscall para finalizar o programa
    syscall 

MENU:

    li      $v0,    4           # syscall para imprimir na tela
    la      $a0,    textomenu
    syscall 

    li      $v0,    4           # syscall para imprimir na tela
    la      $a0,    textop1
    syscall 

    li      $v0,    4           # syscall para imprimir na tela
    la      $a0,    textop2
    syscall 

    li      $v0,    4           # syscall para imprimir na tela
    la      $a0,    textoinstrucao
    syscall

    jr		$ra					# retorna para o endereço de $ra
    