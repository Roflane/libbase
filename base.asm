format PE64 DLL
include 'win64ax.inc'

section '.edata' export readable
export 'base.dll', \
    FastZeroMemory, 'FastZeroMemory', FastSort, 'FastSort', \
    RdSeed64, 'RdSeed64', RdSeed32, 'RdSeed32', RdSeed16, 'RdSeed16', \
    RandomInt64, 'RandomInt64', RandomInt32, 'RandomInt32', RandomInt16, 'RandomInt16', RandomByte, 'RandomByte', RandomSByte, 'RandomSByte', \
    RandomDouble, 'RandomDouble', RandomSingle, 'RandomSingle'

section '.data' data readable
    one64 dq 1.0
    one32 dd 1.0
    _x64value dq 1.8446744073709552e30
    _x32value dd 1000000000

section '.text' code readable executable
proc FastZeroMemory
    xor cl, cl
    mov rdi, rcx
    mov rcx, rdx
    rep stosb
    ret
endp

proc RdSeed64
    rdrand rax
    ret
endp

proc RdSeed32
    rdrand eax
    ret
endp

proc RdSeed16
    rdrand ax
    ret
endp

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
    neg ax
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

proc RandomDouble
.begin:
    rdrand r15
    test r15, r15
    cmp r15, 0
    js .negate
    jmp .impl
.negate:
    neg r15
.impl:
    cvtsi2sd xmm2, r15
    cvtsi2sd xmm3, [_x64value]
    divsd xmm2, xmm3
    movq rax, xmm2
    test rax, rax
    cmp rax, [one64]
    jge .begin
    movsd xmm7, xmm0
    movsd xmm6, xmm1
    subsd xmm6, xmm7
    mulsd xmm2, xmm6
    addsd xmm2, xmm7
    movsd xmm0, xmm2
    ret
endp

proc RandomSingle
.begin:
    rdrand esi
    test esi, esi
    cmp esi, 0
    js .negate
    jmp .impl
.negate:
    neg esi
.impl:
    cvtsi2ss xmm2, esi
    cvtsi2ss xmm3, [_x32value]
    divss xmm2, xmm3
    movd eax, xmm2
    test eax, eax
    cmp eax, [one32]
    jge .begin
    movss xmm7, xmm0
    movss xmm6, xmm1
    subss xmm6, xmm7
    mulss xmm2, xmm6
    addss xmm2, xmm7
    movss xmm0, xmm2
    ret
endp

FastSort:
    cmp rdx, 1
    jbe .ret
    lea r8, [rdx - 1]
.outer:
    xor r9, r9
.inner:
    mov  r10, [rcx + r9*8]
    mov  r11, [rcx + r9*8 + 8]
    cmp  r11, r10
    jge  .no_swap
    mov  [rcx + r9*8],       r11
    mov  [rcx + r9*8 + 8],   r10
.no_swap:
    inc  r9
    cmp  r9, r8
    jl   .inner
    dec  r8
    jg   .outer
.ret:
    ret    
