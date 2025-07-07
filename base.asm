format PE64 DLL
include 'win64a.inc'

section '.edata' export readable
export 'base.dll', \
    FastZeroMemory, 'FastZeroMemory', RandomInt64, 'RandomInt64', RandomInt32, 'RandomInt32', RandomInt16, 'RandomInt16'


section '.code' code readable executable
proc FastZeroMemory
    xor bl, bl
    mov rdi, rcx
    mov rcx, rdx
    rep stosb
    ret
endp

proc RandomInt64
.check:
    cmp rdx, rcx
    jg .impl
.fail:
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
.check:
    cmp edx, ecx
    jg .impl
.fail:
    xor eax, eax
    ret
.impl:
    rdrand ebx
    mov esi, ecx
    mov ebx, edx
    sub ebx, esi
    inc ebx
    xor edx, edx
    div ebx
    add edx, ecx
    mov eax, edx
    ret
endp

proc RandomInt16
.check:
    cmp dx, cx
    jb .fail
.impl:
    mov ax, dx
    sub ax, cx
    inc ax
    rdrand bx
    xor dx, dx
    div ax
    add dx, cx
    mov ax, dx
    ret
.fail:
    xor ax, ax
    ret
endp