## Jonesforth for multiple architectures

The plan is to create a nicely typeset copy of Jonesforth, and while we're
at it we'll port it to a bunch of other archictures for comparision and education,
and explore other forms of visualizations and memory architectures.

The motivation is to understand the relationship between the cpu and the assembly
programmer and how we go from moving around bits to a useable high-level language.

After being annoyed with the use of multiple assembly files in emacs, and using 
multiple online assemblers I decided to write a quick-and-dirty tool to fill in
the rest of the assembly for each word and each architecture and to automatically
run them against an assembler.

With this, we should be able to programmatically assemble the pieces of assembly,
commentary, and binary opcodes into various visualizations.

## Other ports

* [RISC-V 64](https://github.com/jjyr/jonesforth_riscv/)
* [ARM 64](https://github.com/narenratan/jonesforth_arm64_apl/)

## Ideas

- Show hex for opcodes, ascii for text, numbers for numbers -- And color code them while displaying the memory layout.

## Other Tools

[Online x86 / x64 Assembler](https://defuse.ca/online-x86-assembler.htm) and [OakSim ARM Simulator](https://wunkolo.github.io/OakSim/) and [ARM Converter](http://armconverter.com/)

The NEXT macro using an [indirect branch](https://en.wikipedia.org/wiki/Indirect_branch) and compiles on x86 to `ADFFE0`. 





