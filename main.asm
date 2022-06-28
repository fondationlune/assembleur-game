section .data
	introduction db 10, 10, "###################################################", 10, "--------- Voici un jeu cree en assembleur ---------", 10, "--- Vous devez proposer un nombre entre 0 et 9 ----", 10, "---- et trouver celui choisi par le programme ! ---", 10, "------------------ BONNE CHANCE -------------------", 10, "###################################################", 10, 10
	.len:	equ $ - introduction

	demandeNombre db "Quel nombre ? ", 0
	.len:   equ $ - demandeNombre

	reponse db "7"

	plusGrand db "La bonne reponse est plus grande.", 10
	.len:   equ $ - plusGrand
	
	plusPetit db "La bonne reponse est plus petite.", 10
	.len:   equ $ - plusPetit

	bravo db "Bravo, vous avez gagné !", 10
	.len:   equ $ - bravo

section .bss
	Input resb 1

section .text
	global _main

_main:
	
	mov rax, 0x2000004
    mov rdi, 1
    mov rsi, introduction
    mov rdx, introduction.len
    syscall

_jeu:
	mov rbx, demandeNombre	;met en paramettre la question
	mov rcx, demandeNombre.len ;l longueur du parametre
	call _printRBX			;ecrit le text
	call _getInput			;recuper la reponse dans Input


_testEgale:
	mov rsi, reponse
	mov rdi, Input
	mov al, [rsi]
	mov bl, [rdi]
	cmp al, bl
	jne _inequal
	jmp _equal

_equal:
	mov rax, 0x2000004
    mov rdi, 1
    mov rsi, bravo
    mov rdx, bravo.len
    syscall

    jmp _exit

_inequal:
	mov rsi, reponse
	mov rdi, Input
	mov al, [rsi]
	mov bl, [rdi]
	cmp al, bl
	ja _plusGrand
	jb _plusPetit

_plusGrand:
	mov rax, 0x2000004
    mov rdi, 1
    mov rsi, plusGrand
    mov rdx, plusGrand.len
    syscall

	jmp _jeu

_plusPetit:
	mov rax, 0x2000004
    mov rdi, 1
    mov rsi, plusPetit
    mov rdx, plusPetit.len
    syscall

	jmp _jeu

_exit:
    mov rax, 0x2000001
    mov rdi, 0
    syscall

_getInput:
	mov rax, 0x2000003
	mov rdi, 0
	mov rsi, Input
	mov rdx, 16
	syscall

	ret

_printRBX:
	mov rax, 0x2000004
    mov rdi, 1
    mov rsi, rbx
    mov rdx, rcx
    syscall

	ret