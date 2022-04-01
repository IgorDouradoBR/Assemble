





















	addiu	$sp,$sp,4
	
	enquanto: bge	$t9,$s1,fim_main	#enquanto posDaos + tamanho vetorPadrao <= tamanho vetorDdos
		addiu	$sp,$sp,-20
		sw	$s0,0($sp)		#endereço vetor de dados
		sw	$s2,4($sp)		#posição vetor de dador
		sw	$s3,8($sp)		#endereço no vetor padrão
		sw	$s5,12($sp)		#posição no vetor padrão
		sw	$s4,16($sp)		#tamanho do vetor padrão
		
		jal 	encontraPadrao
		lw	$to,0($sp)
		addiu	$sp,$sp,20
		addu	$s7,$s7,$t0
		addu	$t9,$s4,$s2
		addiu	$s2,$s2,1
	j enquanto
	
fim_main:





















































	addiu 	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	jal	encontraPadraoAux
	
frec:	la	$ra,0($sp)
	addiu	$sp,$sp,4
	
	sw	$t0, 0($sp)
	jr	$ra
	
encontraPadraoAux:
	mul 	$t5,$t1,4
	addu	$t5,$t0,$t5
	lw	$t5,0($t5)
	
	mul	$t6,$t3,4
	addu	$t6,$t2,$t6	
	
	bne	$t5,$t6,return0
	
	addiu	$t5,$t4,-1
	beq	$t3,$t3,return1
	
	addiu	$t1,$t1,1
	addiu	$t3,$t3,1
	
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	jal encontraPadraoAux
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	
	jr	$ra
	
return0:
	lw	$ra,0($sp)
	
	li	$t0,0
	j	frec			#salto incondicional para frec
return1:
	lw	$ra,0($sp)
	li	$t0,1
	j	frec			#salto incondicional para frec
	
	
	
