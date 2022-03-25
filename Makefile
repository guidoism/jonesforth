all:
	cweave jonesforth.w
	luatex jonesforth.tex
	open jonesforth.pdf
