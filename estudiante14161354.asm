%macro print_char 1;
    ;imprime un espacio
    mov eax, %1
    mov [temp], eax
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, temp
    mov edx, 1
    int 0x80
%endmacro

%macro print_num 1;
    print_char 32d
;imprime el caracter resultado
    mov eax, 0x0000
    mov eax, %1
    add eax, '0'
    mov [temp], eax
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, temp
    mov edx, 1
    int 0x80
%endmacro


SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_WRITE equ 4
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1


segment .data
msg1 db "Formula del estudiante:", 0xA,0xD

segment .bss
    num1a resb 2
    num2b resb 2
    num3c resb 2
    res1 resb 2 ; guarda el valor de b al cuadrado
    res2 resb 2 ; guarda el valor de a por c
    res3 resb 2 ; guarda el valor de a por c por 4
    res4 resb 2 ; guarda el valor de la operacion dentro de la raiz
    dividendo resb 2; guarda el dividendo
    cociente resb 2; guarda el dividendo
    resultado resb 2;
    resp1 resb 2; guarda la suma
    resp2 resb 2; resultado de la division
    temp resb 2

section  .text
global _start  ;must be declared for using gcc
_start:  ;tell linker entry point


;iniciando valores de a b y c;
; valor de a
mov eax, 2d;
mov [num1a], eax

; valor de b
mov eax, 4d;
mov [num2b], eax

; valor de c
mov eax, 1d;
mov [num3c], eax
print_num [num3c]


; calculamos b al cuadrado

  mov eax, [num2b]
mov ebx, [num2b]

mul ebx
mov [res1], eax

print_num [res1]


; calculamos a por c
  mov eax, [num1a]
mov ebx, [num3c]

mul ebx
mov [res2], eax
print_num [res2]



; multiplicamos por 4
  mov eax, [res2]
mov ebx, 4

mul ebx
mov [res3], eax
print_num [res3]



;hacemos la resta que esta dentro de la raiz
  mov eax, [res1]
mov ebx, [res3]
sub eax, ebx


mov [res4], eax
print_num [res4]

;calculamos el dividendo
mov eax, [num1a]
mov ebx, 2
mul ebx

mov [dividendo], eax
print_num [dividendo]



;calculamos la raiz de la ecuacion

;sumamos 8 + 9
mov eax, 8
mov ebx, 9
add eax, ebx

mov [resp1], eax
print_num [resp1]

;dividimos entre de 6

mov AX, 0x0000
mov DX, 0x0000
mov AX, [resp1]
mov CX, 6d
div CX
mov [resp1], eax
    print_num [resp1]

;sumamos b
mov eax, [resp1]
mov ebx, [num2b]
add eax, ebx

mov [resp2], eax
print_num [resp2]

;dividimos
mov AX, [resp2]
mov CX, [dividendo]
div CX
mov [resultado], eax
    print_num [resultado]

salir:
    mov eax, SYS_SALIDA
    xor ebx, ebx
    int 0x80
