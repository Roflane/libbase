format PE64 DLL
include 'win64a.inc'

section '.edata' export readable
export 'base.dll', \
    FastZeroMemory, 'FastZeroMemory', RandomInt64, 'RandomInt64', RandomInt32, 'RandomInt32', RandomInt16, 'RandomInt16', RandomByte, 'RandomByte', RandomSByte, 'RandomSByte'


section '.code' code readable executable
proc FastZeroMemory
    xor cl, cl
    mov rdi, rcx
    mov rcx, rdx
    rep stosb
    ret
endp

macro negr rg { neg rg }


proc RandomInt64
    cmp rdx, rcx
    jg .impl
    xor rax, rax
    ret
.impl:
    rdrand rax
    mov r8, rcx
    mov r9, rdx
    sub r9, r8
    inc r9
    xor rdx, rdx
    div r9
    add rdx, rcx
    mov rax, rdx
    ret
endp

proc RandomInt32
    cmp edx, ecx
    jg .impl
    xor eax, eax
    ret
.impl:
    rdrand eax
    mov esi, ecx
    mov edi, edx
    sub edi, esi
    inc edi
    xor edx, edx
    div edi
    add edx, ecx
    mov eax, edx
    ret
endp

proc RandomInt16
    cmp dx, cx
    jg .gen
    xor ax, ax
    ret
.gen:
    rdrand ax
    test ax, ax
    jns .pos
    negr ax
.pos:
    mov bx, dx
    sub bx, cx
    inc bx
    xor dx, dx
    div bx
    mov ax, cx
    add ax, dx
    ret
endp

proc RandomByte
    cmp dx, cx
    jg .impl
    xor ax, ax
    ret
.impl:
    rdrand ax
    movzx eax, ax
    mov bx, dx
    sub bx, cx
    inc bx
    xor dx, dx
    div bx
    mov ax, cx
    add ax, dx
    ret
endp

proc RandomSByte
    cmp dx, cx
    jg .impl
    xor ax, ax
    ret
.impl:
    rdrand ax
    movsx eax, ax
    mov bx, dx
    sub bx, cx
    inc bx
    xor dx, dx
    div bx
    mov ax, cx
    add ax, dx
    ret
endp

proc RandomFloat

endp