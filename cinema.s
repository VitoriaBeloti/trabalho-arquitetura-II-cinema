.data

# texto geral
textinit:  .asciiz "\nSistema de venda de poltronas para cinema\n"
textexit:  .asciiz "\nSaindo...\n"

# texto do menu
textomenu:      .asciiz "\nMenu\n"
textop1:        .asciiz "1 - Ver Acentos Disponiveis\n"
textop2:        .asciiz "2 - Comprar Poltrona\n"
textop3:        .asciiz "3 - Sair\n"
textoinstrucao: .asciiz "\nDigite a opcao desejada: "
textopinvalid:  .asciiz "\nOpcao invalida!\n"

# texto da impressao de poltronas
textopoltronas:  .asciiz "\nPoltronas Disponiveis\n"
textopoltronas2: .asciiz "Poltronas: "

# texto de compra de poltronas
textocompra:  .asciiz "\nCompra de poltronas\n"

# vetor com as poltronas
poltronas: .space 35*4;

# textos de teste
textoteste: .asciiz "Caiu no else 1\n"

.text

.globl main
main:
    PRINT_STR = 4;
    PRINT_INT = 1;
    READ_KEYBOARD_INT = 5;
    END_PROGRAM = 10;

    li      $v0,    PRINT_STR            # syscall para imprimir na tela
    la      $a0,    textinit
    syscall 

    jal MENU                            # chama a funcao MENU

    li      $v0,    10                  # syscall para finalizar o programa
    syscall 

    #Funcao MENU
MENU:

    li      $v0,    PRINT_STR           # syscall para imprimir na tela
    la      $a0,    textomenu
    syscall 

    li      $v0,    PRINT_STR           # syscall para imprimir na tela
    la      $a0,    textop1
    syscall 

    li      $v0,    PRINT_STR           # syscall para imprimir na tela
    la      $a0,    textop2
    syscall 

    WHILE_LOOP:

        li      $v0,    PRINT_STR           # syscall para imprimir na tela
        la      $a0,    textoinstrucao
        syscall

        li      $v0,    READ_KEYBOARD_INT   # syscall para ler do teclado
        syscall
        move    $s0,    $v0                 # Salva o valor lido para $s0


        MAIOR = 4;
        MENOR = 0;
        
        li 	$t1, MAIOR                  # t4 = 4
        blt	$t1, $s0, ELSE1             # Se $s0 < 4, entra no ELSE1 
        bge	$s0, $t1, ELSE2	            # Se $s0 >= 4, entra no ELSE2

    ELSE1:
        li      $v0,    PRINT_STR           # syscall para imprimir na tela
        la      $a0,    textoteste
        syscall


        li $t1, MENOR                  # t4 = 0
        bgt $s0, $t1, END_WHILE        # Se $s0 > 0, entra no END_WHILE
        ble	$s0, $t1, ELSE2     	   # Se $s0 <= 0, entra no ELSE2
            
    ELSE2:
        li $v0, PRINT_STR          # syscall para imprimir na tela
        la $a0, textopinvalid      # Imprime mensagem de erro
        syscall

        j WHILE_LOOP

    END_WHILE:
        beq $s0, 1, COMPRAR_POLTRONA      # Se o valor lido for 1, chama a funcao COMPRAR_POLTRONA
        beq $s0, 2, IMPRIME_POLTRONAS     # Se o valor lido for 2, chama a funcao VER_ACENTOS
        beq $s0, 3, SAIR                  # Se o valor lido for 3, chama a funcao SAIR

    SAIR:
        li      $v0,    PRINT_STR           # syscall para imprimir na tela
        la      $a0,    textexit
        syscall

        li      $v0,    END_PROGRAM        # syscall para finalizar o programa
        syscall

    jr		$ra					        # retorna para o endereço de $ra
    

    #Funcao para imprimir as poltronas disponiveis
IMPRIME_POLTRONAS:
    
    li      $v0,    PRINT_STR           # syscall para imprimir na tela
    la      $a0,    textopoltronas
    syscall

    jr $ra

    #Funcao para comprar uma poltrona
COMPRAR_POLTRONA:
    li     $v0,    PRINT_STR           # syscall para imprimir na tela
    la     $a0,    textocompra
    syscall
    
    jr $ra    
