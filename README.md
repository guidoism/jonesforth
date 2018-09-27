## Jonesforth for multiple architectures

[Online x86 / x64 Assembler](https://defuse.ca/online-x86-assembler.htm) and [OakSim ARM Simulator](https://wunkolo.github.io/OakSim/)

The NEXT macro using an [indirect branch](https://en.wikipedia.org/wiki/Indirect_branch) and compiles on x86 to `ADFFE0`. ([x86 JMP](https://c9x.me/x86/html/file_module_x86_id_147.html))

So, DUP looks like `03 445550 89C450 ADFFE0` without the 4 byte pointer to the next word.

DROP looks like `04 44524F50 58 ADFFE0`.

SWAP `04 53574150 585B5053 ADFFE0`

[x86 MOV](https://c9x.me/x86/html/file_module_x86_id_176.html)

Errrrr, the assembly bytes might be wrong as I think that I'm using AT&T syntax instead of Intel or the other way around.

// NEXT
lodsd
jmp eax

// DROP
pop %eax

pop eax

// SWAP
pop %eax
pop %ebx  
push %eax
push %ebx

pop eax
pop ebx  
push eax
push ebx

// DUP
mov (%esp),%eax
push %eax

mov eax, esp
push eax

89E050


