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

# texto da lista de poltronas
textopoltronaslinha: .asciiz "\n-----------\n"
textopoltronasdiv: .asciiz "|"
textopoltronasocupado: .asciiz "X"
textopoltronaslivre: .asciiz "L"

# legenda da impressao de poltronas
textopoltronaslegenda: .asciiz "\nLegenda:\n"
textopoltronaslegenda1: .asciiz "X - Poltrona Ocupada\n"
textopoltronaslegenda2: .asciiz "L - Poltrona Livre\n"
textopoltronaslegenda3: .asciiz "COLUNA\n"
textopoltronaslegenda4: .asciiz "F"
textopoltronaslegenda5: .asciiz "I"
textopoltronaslegenda6: .asciiz "L"
textopoltronaslegenda7: .asciiz "A"
textopoltronaslegenda8: .asciiz " "
textopoltronaslegenda9: .asciiz "\n"

# texto de compra de poltronas
textocompra:  .asciiz "\nCompra de poltronas\n"

# vetor com as poltronas
poltronasArray: .space 35*4;

# textos de teste
textoteste: .asciiz "Caiu\n"

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

    li      $v0,    PRINT_STR           # syscall para imprimir na tela
    la      $a0,    textop3
    syscall 

    MENU_LOOP:

        li      $v0,    PRINT_STR           # syscall para imprimir na tela
        la      $a0,    textoinstrucao
        syscall

        li      $v0,    READ_KEYBOARD_INT   # syscall para ler do teclado
        syscall
        move    $s0,    $v0                 # Salva o valor lido para $s0


        MAIOR = 4;
        MENOR = 0;
        
        li 	    $t1,    MAIOR                     # t4 = 4
        bge	    $s0,    $t1,    VALOR_INVALIDO    # Se $s0 >= 4, entra no VALOR_INVALIDO
        blt	    $t1,    $s0,    ELSE              # Se $s0 < 4, entra no ELSE 
        
    ELSE:
        li      $t1,    MENOR                    # t4 = 0
        bgtz    $s0,    END_WHILE                # Se $s0 > 0, entra no END_WHILE
        ble	    $s0,    $t1,    VALOR_INVALIDO   # Se $s0 <= 0, entra no VALOR_INVALIDO
            
    VALOR_INVALIDO:
        li      $v0,    PRINT_STR          # syscall para imprimir na tela
        la      $a0,    textopinvalid      # Imprime mensagem de erro
        syscall

        j MENU_LOOP

    END_WHILE:
        beq     $s0,    1,      IMPRIME_POLTRONAS      # Se o valor lido for 1, chama a funcao IMPRIME_POLTRONAS
        beq     $s0,    2,      COMPRAR_POLTRONA       # Se o valor lido for 2, chama a funcao COMPRAR_POLTRONA
        beq     $s0,    3,      SAIR                   # Se o valor lido for 3, chama a funcao SAIR

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

    li      $v0,    PRINT_STR           # syscall para imprimir na tela
    la      $a0,    textopoltronaslegenda8
    syscall

    li      $v0,    PRINT_STR           # syscall para imprimir na tela
    la      $a0,    textopoltronaslegenda3
    syscall

    li      $v0,    PRINT_STR           # syscall para imprimir na tela
    la      $a0,    textopoltronaslegenda8
    syscall

    addi    $t0,    $zero,      0                  # t0 = 0
    addi    $t2,    $zero,      0                  # t2 = 0
    addi    $t5,    $zero,      1                  # t3 = 0

    PRINT_LOOP_LEGENDA:
        beq    $t5,    6,    END_PRINT_LOOP_LEGENDA  # Se $t5 == 6, entra no END_PRINT_LOOP_LEGENDA

        li     $v0,    PRINT_INT           # syscall para imprimir na tela
        move   $a0,    $t5                 # Imprime o valor de $t5
        syscall

        li     $v0,    PRINT_STR                # syscall para imprimir na tela
        la     $a0,    textopoltronaslegenda8   # Imprime a quebra de linha
        syscall

        addi   $t5,    $t5,     1          # Incrementa $t5

        j      PRINT_LOOP_LEGENDA          # Volta para o inicio do loop

    END_PRINT_LOOP_LEGENDA:
        li     $v0,    PRINT_STR                # syscall para imprimir na tela
        la     $a0,    textopoltronaslegenda9   # Imprime a quebra de linha
        syscall

    # Loop para imprimir a linha de poltronas
    PRINT_LOOP_LINE:

        beq     $t0,    7,   END_PRINT_LOOP_LINE    # Se t0 == 8, entra no END_PRINT_LOOP_LINE

        addi    $t0,    $t0,        1               # t0 = t0 + 1
        addi    $t1,    $zero,      0               # t1 = 0

        li      $v0,    PRINT_STR                   # syscall para imprimir na tela
        la      $a0,    textopoltronaslinha
        syscall

        li      $v0,    PRINT_STR                   # syscall para imprimir na tela
        la      $a0,    textopoltronasdiv
        syscall

        # Loop para imprimir a coluna de poltronas
        PRINT_LOOP_COL:
            beq     $t1,    5,      END_PRINT_LOOP_COL      # Se t1 == 5, entra no END_PRINT_LOOP_COL

            addi    $t1,    $t1,    1                       # t1 = t1 + 1

            addi    $t2,    $t2,    4                       # t2 = t2 + 4

            lw		$t3,    poltronasArray($t2)		        # t3 = poltronasArray[t2]

            beq     $t4,    0,       POLTRONA_LIVRE         # Se t4 == 0, entra no POLTRONA_LIVRE

            li      $v0,    PRINT_STR                       # syscall para imprimir na tela
            la      $a0,    textopoltronasocupado
            syscall

            li      $v0,    PRINT_STR                       # syscall para imprimir na tela
            la      $a0,    textopoltronasdiv
            syscall

            j     PRINT_LOOP_COL                            # Chama a funcao PRINT_LOOP_COL
        END_PRINT_LOOP_COL:
            li      $v0,    PRINT_STR                       # syscall para imprimir na tela
            la      $a0,    textopoltronaslegenda8
            syscall

            li      $v0,    PRINT_INT                       # syscall para imprimir na tela
            move    $a0,    $t0                             # Imprime o valor de $t0
            syscall

            blt		$t0,    5,      PRINT_LETRA	            # if $t0 < 5 chama a função PRINT_LETRA

            j       PRINT_LOOP_LINE                         # Chama a funcao PRINT_LOOP_LINE

        PRINT_LETRA:
            li      $v0,    PRINT_STR                       # syscall para imprimir na tela
            la      $a0,    textopoltronaslegenda8
            syscall

            beq    $t0,    1,       PRINT_F             # Se $t0 == 1, entra no PRINT_F
            beq    $t0,    2,       PRINT_I             # Se $t0 == 2, entra no PRINT_I
            beq    $t0,    3,       PRINT_L             # Se $t0 == 3, entra no PRINT_L
            beq    $t0,    4,       PRINT_A             # Se $t0 == 4, entra no PRINT_A

        PRINT_F:
            li     $v0,    PRINT_STR                    # syscall para imprimir na tela
            la     $a0,    textopoltronaslegenda4
            syscall

            j       PRINT_LOOP_LINE                     # Chama a funcao PRINT_LOOP_LINE

        PRINT_I:
            li     $v0,    PRINT_STR                    # syscall para imprimir na tela
            la     $a0,    textopoltronaslegenda5
            syscall

            j       PRINT_LOOP_LINE                     # Chama a funcao PRINT_LOOP_LINE

        PRINT_L:
            li     $v0,    PRINT_STR                    # syscall para imprimir na tela
            la     $a0,    textopoltronaslegenda6
            syscall

            j       PRINT_LOOP_LINE                     # Chama a funcao PRINT_LOOP_LINE

        PRINT_A:
            li     $v0,    PRINT_STR                    # syscall para imprimir na tela
            la     $a0,    textopoltronaslegenda7
            syscall

            j       PRINT_LOOP_LINE                     # Chama a funcao PRINT_LOOP_LINE
                

        POLTRONA_LIVRE:
            li      $v0,    PRINT_STR                   # syscall para imprimir na tela
            la      $a0,    textopoltronaslivre
            syscall

            li      $v0,    PRINT_STR                   # syscall para imprimir na tela
            la      $a0,    textopoltronasdiv
            syscall

            j       PRINT_LOOP_COL                      # Chama a funcao PRINT_LOOP_LINE

    END_PRINT_LOOP_LINE:
        li      $v0,    PRINT_STR               # syscall para imprimir na tela
        la      $a0,    textopoltronaslinha
        syscall

        li      $v0,    PRINT_STR               # syscall para imprimir na tela
        la      $a0,    textopoltronaslegenda
        syscall

        li      $v0,    PRINT_STR               # syscall para imprimir na tela
        la      $a0,    textopoltronaslegenda1
        syscall

        li      $v0,    PRINT_STR               # syscall para imprimir na tela
        la      $a0,    textopoltronaslegenda2
        syscall

        j MENU

    jr $ra

        #Funcao para comprar uma poltrona
COMPRAR_POLTRONA:
    li     $v0,    PRINT_STR           # syscall para imprimir na tela
    la     $a0,    textocompra
    syscall

    COMPRA_LINHA_LOOP:

        li      $v0,    PRINT_STR           # syscall para imprimir na tela
        la      $a0,    textocompralinha
        syscall

        li      $v0,    READ_KEYBOARD_INT   # syscall para ler do teclado
        syscall
        move    $s0,    $v0                 # Salva o valor lido para $s0

        MAIORLINHA = 8;
        MENORLINHA = 0;
        
        li 	    $t1,    MAIORLINHA                     # t8 = 8
        bge	    $s0,    $t1,    VALOR_LINHA_INVALIDO    # Se $s0 >= 8, entra no VALOR_INVALIDO
        blt	    $t1,    $s0,    ELSE_LINHA              # Se $s0 < 8, entra no ELSE_LINHA

    ELSE_LINHA:
        li      $t1,    MENORLINHA                     # t4 = 0
        bgtz    $s0,    END_WHILE_LINHA                # Se $s0 > 0, entra no END_WHILE_LINHA
        ble	    $s0,    $t1,    VALOR_LINHA_INVALIDO   # Se $s0 <= 0, entra no VALOR_INVALIDO
            
    VALOR_LINHA_INVALIDO:
        li      $v0,    PRINT_STR          # syscall para imprimir na tela
        la      $a0,    textopinvalid      # Imprime mensagem de erro
        syscall

    END_WHILE_LINHA:
        beq     $s0,    1,      COMPRA_COLUNA_LOOP       # Se o valor lido for 1, chama a funcao COMPRA_COLUNA_LOOP
        beq     $s0,    2,      COMPRA_COLUNA_LOOP       # Se o valor lido for 2, chama a funcao COMPRA_COLUNA_LOOP
        beq     $s0,    3,      COMPRA_COLUNA_LOOP       # Se o valor lido for 3, chama a funcao COMPRA_COLUNA_LOOP
        beq     $s0,    4,      COMPRA_COLUNA_LOOP       # Se o valor lido for 4, chama a funcao COMPRA_COLUNA_LOOP
        beq     $s0,    5,      COMPRA_COLUNA_LOOP       # Se o valor lido for 5, chama a funcao COMPRA_COLUNA_LOOP
        beq     $s0,    6,      COMPRA_COLUNA_LOOP       # Se o valor lido for 6, chama a funcao COMPRA_COLUNA_LOOP
        beq     $s0,    7,      COMPRA_COLUNA_LOOP       # Se o valor lido for 7, chama a funcao COMPRA_COLUNA_LOOP

        j COMPRA_LINHA_LOOP

    COMPRA_COLUNA_LOOP:

        li      $v0,    PRINT_STR           # syscall para imprimir na tela
        la      $a0,    textocompracoluna
        syscall

        li      $v0,    READ_KEYBOARD_INT   # syscall para ler do teclado
        syscall
        move    $s0,    $v0                 # Salva o valor lido para $s0

        MAIORCOLUNA = 6;
        MENORCOLUNA = 0;
        
        li 	    $t1,    MAIORCOLUNA                     # t8 = 8
        bge	    $s0,    $t1,    VALOR_COLUNA_INVALIDO    # Se $s0 >= 8, entra no VALOR_INVALIDO
        blt	    $t1,    $s0,    ELSE_COLUNA              # Se $s0 < 8, entra no ELSE_COLUNA

    ELSE_COLUNA:
        li      $t1,    MENORCOLUNA                    # t4 = 0
        bgtz    $s0,    END_WHILE_COLUNA                # Se $s0 > 0, entra no END_WHILE_COLUNA
        ble	    $s0,    $t1,    VALOR_COLUNA_INVALIDO   # Se $s0 <= 0, entra no VALOR_INVALIDO
            
    VALOR_COLUNA_INVALIDO:
        li      $v0,    PRINT_STR          # syscall para imprimir na tela
        la      $a0,    textopinvalid      # Imprime mensagem de erro
        syscall

    END_WHILE_COLUNA:
        beq     $s0,    1,      TEXTO_DISP       # Se o valor lido for 1, chama a funcao TEXTO_DISP
        beq     $s0,    2,      TEXTO_DISP       # Se o valor lido for 2, chama a funcao TEXTO_DISP
        beq     $s0,    3,      TEXTO_DISP       # Se o valor lido for 3, chama a funcao TEXTO_DISP
        beq     $s0,    4,      TEXTO_DISP       # Se o valor lido for 4, chama a funcao TEXTO_DISP
        beq     $s0,    5,      TEXTO_DISP       # Se o valor lido for 5, chama a funcao TEXTO_DISP

    ELSE_COLUNA:
        li      $t1,    MENORCOLUNA                    # t4 = 0
        bgtz    $s0,    END_WHILE_COLUNA                # Se $s0 > 0, entra no END_WHILE_COLUNA
        ble	    $s0,    $t1,    VALOR_COLUNA_INVALIDO   # Se $s0 <= 0, entra no VALOR_INVALIDO

        j COMPRA_COLUNA_LOOP

    TEXTO_DISP:
        li      $v0,    PRINT_STR           # syscall para imprimir na tela
        la      $a0,    textopoltronadisp
        syscall

  jr $ra

    @ VALIDAR_POLTRONA:
        
    @      li      $t1,    4                     # t4 = 4
    @      mult    $s0,    $t1                  # $s0 = $s0 * 4
    @      mflo    $s0                         # $s0 = $s0 / 4
        
    @      li      $t1,    4                     # t4 = 4
    @      mult    $s1,    $t1                  # $s1 = $s1 * 4
    @      mflo    $s1                          # $s1 = $s1 / 4
        
    @      li      $t1,    4                     # t4 = 4
    @      mult    $s2,    $t1                  # $s2 = $s2 * 4
    @      mflo    $s2                          # $s2 = $s2 / 4
        
    @      li      $t1,    4                     # t4 = 4
    @      mult    $s3,    $t1                  # $s3 = $s3 * 4
    @      mflo    $s3                          # $s3 = $s3 / 4
        
    @      li      $t1,    4                     # t4 = 4
    @      mult    $s4,    $t1                  # $s4 = $s4 * 4
    @      mflo    $s4                          # $s4 = $s4 / 4
        
    @      li      $t1,    4                     # t4 = 4
    @      mult    $s5,    $t1                  # $s5 = $s5 * 4
    @      mflo    $s5                          # $s5 = $s5 / 4
        
    @      li      $t1,    4                     # t4 = 4
    @      mult    $s6,    $t1                  # $s6 = $s6 * 4
    @      mflo    $s6                          # $s6 = $s6 / 4

    @ jr $ra   
