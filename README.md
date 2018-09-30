## Jonesforth for multiple architectures

The plan is to create a nicely typeset copy of Jonesforth, and while we're
at it we'll port it to a bunch of other archictures for comparision and education,
and explore other forms of visualizations and memory architectures.

After being annoyed with the use of multiple assembly files in emacs, and using 
multiple online assemblers I decided to write a quick-and-dirty tool to fill in
the rest of the assembly for each word and each architecture and to automatically
run them against an assembler.

## Ideas

- Show hex for opcodes, ascii for text, numbers for numbers -- And color code them while displaying the memory layout.

## Other Tools

[Online x86 / x64 Assembler](https://defuse.ca/online-x86-assembler.htm) and [OakSim ARM Simulator](https://wunkolo.github.io/OakSim/) and [ARM Converter](http://armconverter.com/)

The NEXT macro using an [indirect branch](https://en.wikipedia.org/wiki/Indirect_branch) and compiles on x86 to `ADFFE0`. 





