section .data
NULL equ 0
SYS_write equ 1
SYS_read equ 0
SYS_exit equ 60
STDIN equ 0
STDOUT equ 1
Char db "*"
CharInput db "0"
NEWLINE db 10

section .text
global _start
_start:

mov rdi, CharInput  ;read 1 character from stdin to specified address
mov rsi, 1
call read_stdin

mov rdi, CharInput  ;convert character presumed to be in the range 0-9 to the corresponding real value  
call char_to_int

mov r8b, byte [CharInput]
mov r9, 0
print_loop:         ;loop to print Char the amount of times entered previously
cmp r9b, r8b
je print_loop_done
mov r10b, 0
inner_print_loop:
cmp r10b, r8b
je inner_print_loop_done


mov rax, SYS_write
mov rdi, STDOUT
mov rsi, Char
mov rdx, 1
syscall

inc r10b
jmp inner_print_loop

inner_print_loop_done:

mov rax, SYS_write
mov rdi, STDOUT
mov rsi, NEWLINE
mov rdx, 1
syscall

dec r8
jmp print_loop


print_loop_done:



mov rax, SYS_exit
mov rdi, 0
syscall

global read_stdin
read_stdin:
;arg1 address to read to, arg2 amount of characters to read
push rbx
push rbp
mov rbx, rdi
mov rbp, rsi

mov rax, SYS_read
mov rdi, STDIN
mov rsi, rbx
mov rdx, rbp
syscall

pop rbp
pop rbx

ret

global char_to_int
char_to_int:
;arg1 character address to convert
sub byte [rdi], 48
ret

