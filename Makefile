.PHONY: test
test:
	prove -v


incdec.pl: incdec.pl.m4 incdec.pm
	sed -n '/sub incdec {/,/^}/p' incdec.pm > incdec.sub.pl
	m4 $< > $@
	rm incdec.sub.pl

incdec: incdec.m4.bash incdec.pl
	m4 $< --define="INCLUDE_INCDEC_PL=include(\`incdec.pl')dnl" > $@
