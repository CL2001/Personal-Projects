default rel

; Data Section: Constants
section .data
    N               equ 3                   ; Starting number
    M               equ 20                   ; Ending number
    STD_OUTPUT_HANDLE equ -11               ; Standard output handle constant
    NULL            equ 0                   ; Null value

; BSS Section: Uninitialized Data
section .bss
    stdout          resq 1                  ; Handle for standard output
    written         resq 1                  ; Number of bytes written by WriteConsoleA
    buffer          resb 32                 ; Buffer for string representation

; External Declarations: Windows API Functions
extern GetStdHandle
extern WriteConsoleA
extern ExitProcess

; Text Section: Code
section .text
    global main

; display Function: Converts an integer to string and prints it
; Expects number in RCX.
display:
    push rbp
    mov rbp, rsp
    push rdi                                ; Save callee-saved register
    push rsi                                ; Save callee-saved register
    push rbx                                ; Save rbx for use in reversal

    lea rdi, [rel buffer]                   ; rdi points to start of buffer
    mov rax, rcx                            ; Number to display in rax

    ; Handle negative numbers: add '-' if needed.
    test rax, rax
    jns .positive
    mov byte [rdi], '-'                     ; Write '-' sign
    inc rdi
    neg rax
.positive:
    mov r10, rdi                            ; Save start address for digits
    mov rcx, 10                             ; Divisor for digit extraction

    ; Special case: if number is 0, write '0'
    cmp rax, 0
    jne .digit_loop
    mov byte [rdi], '0'
    inc rdi
    jmp .reverse_proc

.digit_loop:
    xor rdx, rdx                            ; Clear remainder register
    div rcx                                 ; Divide rax by 10; quotient in rax, remainder in rdx
    add dl, '0'                             ; Convert remainder to ASCII
    mov [rdi], dl                           ; Store the digit
    inc rdi                                ; Advance pointer
    cmp rax, 0
    jne .digit_loop

.reverse_proc:
    ; Reverse the digits in the buffer (the digits lie between r10 and rdi-1)
    mov rsi, r10                            ; rsi = start of digits
    mov rbx, rdi
    dec rbx                                 ; rbx = last digit position
.reverse_loop:
    cmp rsi, rbx
    jge .reverse_done                       ; If pointers have met or crossed, reversal is complete
    mov al, [rsi]                           ; Temporarily store byte at start
    mov dl, [rbx]                           ; Get byte at end
    mov [rsi], dl                           ; Swap: write end byte to start
    mov [rbx], al                           ; Write stored byte to end
    inc rsi                                ; Move start pointer forward
    dec rbx                                ; Move end pointer backward
    jmp .reverse_loop
.reverse_done:
    ; Append CR+LF after the digits
    mov byte [rdi], 13                      ; Carriage return (CR)
    inc rdi
    mov byte [rdi], 10                      ; Line feed (LF)
    inc rdi

    ; Calculate string length: rdi now points after the appended CR+LF.
    lea rax, [rel buffer]
    mov r8, rdi
    sub r8, rax                           ; r8 = number of characters to write

    ; Prepare and call WriteConsoleA (Microsoft x64 calling convention)
    mov rcx, [rel stdout]                   ; First parameter: console handle
    lea rdx, [rel buffer]                   ; Second parameter: pointer to buffer
    ; r8 already holds the number of characters
    lea r9, [rel written]                   ; Third parameter: pointer to number of chars written
    sub rsp, 32                             ; Allocate shadow space
    mov qword [rsp + 32], 0                 ; Fifth parameter (lpReserved) set to 0
    call WriteConsoleA
    add rsp, 32                             ; Clean up shadow space

    pop rbx                                 ; Restore registers
    pop rsi
    pop rdi
    leave
    ret

; main Function: Program entry point
main:
    push rbp
    mov rbp, rsp
    sub rsp, 32                             ; Ensure proper stack alignment

    ; Get standard output handle
    mov ecx, STD_OUTPUT_HANDLE              ; Parameter for GetStdHandle
    call GetStdHandle                       ; Call Windows API
    mov [rel stdout], rax                   ; Store handle

    ; Loop from N to M
    mov r12, N                              ; Initialize counter to N
.loop:
    cmp r12, M                              ; Compare counter with M
    jg .end_loop                           ; If counter > M, exit loop
    mov rcx, r12                           ; Pass current number to display function
    call display                           ; Print the number
    inc r12                                ; Increment counter
    jmp .loop                              ; Repeat loop
.end_loop:
    xor ecx, ecx                           ; Exit code 0
    call ExitProcess                        ; Terminate the program


; #include <stdio.h>

; void display(int num) {
;     printf("%d\n", num);
; }

; int main() {
;     int N = 1;
;     int M = 5;
;     for (int i = N; i <= M; i++) {
;         display(i);
;     }
;     return 0;
; }
