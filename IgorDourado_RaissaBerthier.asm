# Trabalho realizado por: Igor Dourado e Raissa Berthier
# Org e Arq I Turma 128

.data
VetorDados: 	.space 200
VetorPadrao: 	.space 20
Msg1:  		.asciiz "\n A["
MsgDados: 	.asciiz "Defina o número de elementos do vetor de dados: "
MsgPadrao:	.asciiz "Defina o número de elementos do vetor padrão: "
MsgNumeros:	.asciiz "Digite o número para o vetor:  "
naoHaPadrao:	.asciiz "Não há padrão, pois Vetor Padrão é maior que Vetor Dados"

.text                   
.globl  main   

	j 	main
	
	                                    
carregaVetor:
 	li 	$v0, 5				# código para ler um inteiro e depois passar para a pilha
	syscall		
	
	addiu	$sp, $sp, -4
	la 	$t6, 0($v0)
	sw 	$t6, 0($sp)
	la 	$t7, 0($sp)
	lw 	$t7, 0($t7) 			#esse é o processo para ler com pilha
	#e r r o
	la 	$s3, 0($sp)
	lw 	$s3, 0($s3)
	addiu 	$sp, $sp,4
	
	addu 	$s1,$0, $t7
	la 	$s2, 0($t5)
	addiu 	$s4, $zero, 1
 	
 	addiu	$sp, $sp, -4
 	sw  	$ra, 4($sp)
 	
 	jal 	loop
 	
 	lw 	$ra, 4($sp)
 	addiu 	$sp, $sp,4 
 	
	jr 	$ra
	
loop: 
	li 	$v0, 4
	la 	$a0, MsgNumeros
	syscall 
	
	mulu	$t1, $t0, 4 
	addu	$t1, $t1, $s2
	lw 	$t2, 0($t1)
	li 	$v0, 5
	syscall
	
	addu 	$t2, $v0, $0
	sw  	$t2, 0($t1)
	addiu 	$t0, $t0, 1
	
	bne 	$t0, $s1, loop
	
	la 	$s2, 0($t5)
	addiu 	$t0, $zero, 0
	jr 	$ra
	
	
	
encontraPadrao:
	bgt	$s0, $s7, naoTemPadrao

	la      $t0,VetorDados 				#endereco VetorDados
	la	$t1, 4($sp)				#salva a variavel posicaoDados
	lw      $t1, 0($t1)     			#vai salvar em t1 o valor que tava na pilha
	
	#la      $t2, 
	
naoTemPadrao:
	li 	$v0, 4
	la 	$a0, MsgNumeros
	syscall
	
	j	exit

				
	
main: 
	li 	$v0, 4
	la 	$a0, MsgDados
	syscall 
	
	la      $t5,VetorDados 				#recupera endereco de vetor dados	
	jal 	carregaVetor
	
	la 	$s7, 0($s3)  				#salva o tamanho do vetorDados
	
	
	
	li 	$v0, 4
	la 	$a0, MsgPadrao
	syscall 
	
	la      $t5,VetorPadrao				#recupera endereco de vetor padrao  
	jal 	carregaVetor
	
	la 	$s0, 0($s3) 				#salva o tamanho do vetorPadrao
	
	
	jal	encontraPadrao
	
	
	addiu	$sp, $sp, -24 				#abre 6 espacos para futuras variaveis
	
	li 	$s5, 0					# Variavel "contabilizaPadrao"
        sw	$s5, 0($sp)
        
        li 	$s6, 0					# Variavel "posicaoDados"
        sw	$s6, 4($sp)	
        
        
        
        
        add	$t7,$s0,
        
        
        while:
        	bge	$t7, $s1, exit			# se 
        
        
        
	
	
	
	exit:
	li 	$v0, 10
	syscall
	
   
 	
