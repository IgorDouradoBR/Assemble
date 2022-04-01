	.data
VetorDados: .space 200
VetorPadrao: .space 20
Msg1:  .asciiz "\n A["

	.text                   
        .globl  main   

	j main
	
loop: 
	mulu	$t1, $t0, 4 
	addu $t1, $t1, $s2
	lw $t2, 0($t1)
	li $v0, 5
	syscall
	
	addu $t2, $v0, $0
	sw  $t2, 0($t1)
	addiu $t0, $t0, 1
	
	bne $t0, $s1, loop
	
	la $s2, 0($t5)
	addiu $t0, $zero, 0
	jr $ra
   
 carregaVetor:
 	li $v0, 5		# código para ler um inteiro e depois passar para a pilha
	syscall		
	addiu	$sp, $sp, -4
	la $t6, 0($v0)
	sw $t6, 0($sp)
	la $t7, 0($sp)
	lw $t7, 0($t7) 	#esse é o processo para ler com pilha
	#e r r o
	la $s3, 0($sp)
	lw $s3, 0($s3)
	addiu $sp, $sp,4
	
	addu $s1,$0, $t7
	la $s2, 0($t5)
	addiu $s4, $zero, 1
 	
 	addiu	$sp, $sp, -4
 	sw  $ra, 0($sp)
 	
 	jal loop
 	
 	lw $ra, 0($sp)
 	addiu $sp, $sp,4 
 	
	jr $ra
	
diferente:
	li	$t8, 0	
	li 	$t5, 1
	beq   $t4, $t5,  jEncontraPadrao1
	j fimRecursao
igual:
	li	$t8, 1
	beq   $t4, $t8,  jEncontraPadrao1
	j fimRecursao
	
encontraPadrao2:
	
	mul	$t5, $t1, 4
	addu $t5, $t0, $t5
	lw	$t5, 0($t5)
	
	mul	$t6, $t3, 4
	addu $t6, $t2, $t6
	lw	$t6, 0($t6)
	
	bne	$t5,$t6, diferente
	
	addiu $t7, $t4, -1
	
	beq	$t3, $t7, igual
	
	addiu $t1, $t1, 1
	addiu $t3, $t3, 1
	
	addiu	$sp, $sp, -4
 	sw  $ra, 0($sp)
 	
 	jal encontraPadrao2 		#ISSO VAI SHIFTAR CADA $SP PARA 1 PARA O LADO
 	
 fimRecursao:	
 	lw $ra, 0($sp)
 	addiu $sp, $sp,4 
 	
 jEncontraPadrao1:	
 	jr $ra
 	
encontraPadrao1:

	lw $t0, 4($sp)		# endereço vetor de dados
	lw $t1, 8($sp)		# posicao vetor de dados
	lw $t2, 12($sp)		# endereço vetor padrao
	lw $t3, 16($sp)		# posicao vetor padrao
	lw $t4, 20($sp)	# tamanho vetor padrao
	
	addiu	$sp, $sp, -4
 	sw  $ra, 0($sp)
 	
 	jal encontraPadrao2 		#ISSO VAI SHIFTAR CADA $SP PARA 1 PARA O LADO
 
 	lw $ra, 0($sp)
 	addiu $sp, $sp,4
 
 	jr $ra
 	
main: 

	la      $t5,VetorDados 		#recupera endereco de vetor dados	
	 
	jal carregaVetor
	
	la $s7, 0($s3)  				#salva o tamanho do vetorDados
	
	la      $t5,VetorPadrao		#recupera endereco de vetor padrao  
	
	jal carregaVetor
	
	la $s1, VetorDados 			#1 parametro carregar endereco
	la $s2, VetorPadrao 		#3 parametro carregar 
	
	la $s0, 0($s3) #salva o tamanho do vetorPadrao e 5 parametro
	
	addiu	$sp, $sp, -24 	#abre 6 espacos para futuras variaveis
	
	li 	$s5, 0		# Variavel "contabilizaPadrao"
        
        li 	$s6, 0		# Variavel "posicaoDados" e 2 parametro da funcao
        sw	$s6, 8($sp)	
        
        addiu $s3, $zero, 0 		#4 parametro comecado em zero
        
        sw $s3, 16($sp)		#salva o 4 parametro carrega endereco
        
        sw $s0, 20($sp)		#salva o tamanho vetor padrao
        
        sw $s1, 4($sp) 			#salva o 1 parametro carrega endereco
	sw $s2, 12($sp)			#salva o 3 parametro carrega endereco
        
 while:  bge $t9, $s7, fim

 	jal encontraPadrao1 		#ISSO VAI SHIFTAR CADA $SP PARA 1 PARA O LADO
 	
	addu $s5, $s5, $t8
	addu  $t9, $s6, $s0
	addiu $s6, $s6, 1
	sw	$s6, 8($sp)
	j while
	
fim: 	
	li $v0, 1	
	la $a0, ($s5)	
	syscall	
	li $v0, 10
	syscall
