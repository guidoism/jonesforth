@* Jonesforth. A sometimes minimal FORTH compiler and tutorial for Linux / i386 systems.

\input eplain
\beginpackages
\usepackage{url}
\endpackages

By Richard W.M. Jones {\tt rich@@annexia.org}

This is {\bf Public Domain} (see public domain release statement below).

\url{http://annexia.org/forth}

@ Introduction.

Forth is one of those alien languages which most working programmers regard in the same
way as Haskell, Lisp, and so on.  Something so strange that they'd rather any thoughts
of it just go away so they can get on with writing this paying code.  But that's wrong
and if you care at all about programming then you should at least understand all these
languages, even if you will never use them.

Lisp is the ultimate high-level language, and features from Lisp are being added every
decade to the more common languages.  But Forth is in some ways the ultimate in low level
programming.  Out of the box it lacks features like dynamic memory management and even
strings.  In fact, at its primitive level it lacks even basic concepts like |if|-statements
and loops.

Why then would you want to learn Forth?  There are several very good reasons.  First
and foremost, Forth is minimal.  You really can write a complete Forth in, say, 2000
lines of code.  I don't just mean a Forth program, I mean a complete Forth operating
system, environment and language.  You could boot such a Forth on a bare PC and it would
come up with a prompt where you could start doing useful work.  The Forth you have here
isn't minimal and uses a Linux process as its `base PC' (both for the purposes of making
it a good tutorial). It's possible to completely understand the system.  Who can say they
completely understand how Linux works, or gcc?

Secondly Forth has a peculiar bootstrapping property.  By that I mean that after writing
a little bit of assembly to talk to the hardware and implement a few primitives, all the
rest of the language and compiler is written in Forth itself.  Remember I said before
that Forth lacked |if|-statements and loops?  Well of course it doesn't really because
such a lanuage would be useless, but my point was rather that |if|-statements and loops are
written in Forth itself.

Now of course this is common in other languages as well, and in those languages we call
them `libraries'.  For example in \Cee, `printf' is a library function written in \Cee.  But
in Forth this goes way beyond mere libraries.  Can you imagine writing \Cee's `if' in \Cee?
And that brings me to my third reason: If you can write `if' in Forth, then why restrict
yourself to the usual |if|/|while|/|for|/|switch| constructs?  You want a construct that iterates
over every other element in a list of numbers?  You can add it to the language.  What
about an operator which pulls in variables directly from a configuration file and makes
them available as Forth variables?  Or how about adding Makefile-like dependencies to
the language?  No problem in Forth.  How about modifying the Forth compiler to allow
complex inlining strategies -- simple.  This concept isn't common in programming languages,
but it has a name (in fact two names): ``macros" (by which I mean Lisp-style macros, not
the lame \Cee preprocessor) and ``domain specific languages" (DSLs).

This tutorial isn't about learning Forth as the language.  I'll point you to some references
you should read if you're not familiar with using Forth.  This tutorial is about how to
write Forth.  In fact, until you understand how Forth is written, you'll have only a very
superficial understanding of how to use it.

So if you're not familiar with Forth or want to refresh your memory here are some online
references to read:

\url{http://en.wikipedia.org/wiki/Forth_%28programming_language%29}

\url{http://galileo.phys.virginia.edu/classes/551.jvn.fall01/primer.htm}

\url{http://wiki.laptop.org/go/Forth_Lessons}

\url{http://www.albany.net/~hello/simple.htm}

Here is another "Why FORTH?" essay: \url{http://www.jwdt.com/~paysan/why-forth.html}

Discussion and criticism of this Forth here: \url{http://lambda-the-ultimate.org/node/2452}

@ Acknowledgements. This code draws heavily on the design of LINA
FORTH (\url{http://home.hccnet.nl/a.w.m.van.der.horst/lina.html}) by Albert
van der Horst. Any similarities in the code are probably not
accidental.

Some parts of this Forth are also based on this IOCCC entry from 1992:
\url{http://ftp.funet.fi/pub/doc/IOCCC/1992/buzzard.2.design}.
I was very proud when Sean Barrett, the original author of the IOCCC entry, commented in the LtU thread
\url{http://lambda-the-ultimate.org/node/2452#comment-36818} about this Forth.

And finally I'd like to acknowledge the (possibly forgotten?) authors of ARTIC FORTH because their
original program which I still have on original cassette tape kept nagging away at me all these years.
\url{http://en.wikipedia.org/wiki/Artic_Software}

@ Public Domain.

I, the copyright holder of this work, hereby release it into the
public domain. This applies worldwide.

In case this is not legally possible, I grant any entity the right to
use this work for any purpose, without any conditions, unless such
conditions are required by law.

@ Assembler.

(You can just skip to the next section -- you don't need to be able to read assembler to
follow this tutorial).

However if you do want to read the assembly code here are a few notes about gas (the GNU assembler):

\numberedlist
\li Register names are prefixed with `%', so %eax is the 32 bit i386 accumulator.  The registers
    available on i386 are: %eax, %ebx, %ecx, %edx, %esi, %edi, %ebp and %esp, and most of them
    have special purposes.

\li Add, mov, etc. take arguments in the form SRC,DEST.  So mov %eax,%ecx moves %eax -> %ecx

\li Constants are prefixed with `\$', and you mustn't forget it!  If you forget it then it
    causes a read from memory instead, so:
    mov \$2,%eax         moves number 2 into %eax
    mov 2,%eax          reads the 32 bit word from address 2 into %eax (ie. most likely a mistake)

\li gas has a funky syntax for local labels, where `1f' (etc.) means label `1:' "forwards"
    and `1b' (etc.) means label `1:' ``backwards".  Notice that these labels might be mistaken
    for hex numbers (eg. you might confuse 1b with \$0x1b).

\li `ja' is ``jump if above", `jb' for ``jump if below", `je' ``jump if equal" etc.

\li gas has a reasonably nice .macro syntax, and I use them a lot to make the code shorter and
    less repetitive.
\endnumberedlist

For more help reading the assembler, do "info gas" at the Linux prompt.

Now the tutorial starts in earnest.

