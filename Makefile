# Copyright (c) 2021  Teddy Wing
#
# This file is part of Incdec.
#
# Incdec is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Incdec is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Incdec. If not, see <https://www.gnu.org/licenses/>.


MAN_PAGE := doc/incdec.7


.PHONY: all
all: incdec.bash


incdec.bash: incdec.m4.bash incdec.pl
	m4 --define="INCLUDE_INCDEC_PL=include(\`incdec.pl')dnl" $< > $@

incdec.pl: incdec.m4.pl incdec.pm
	sed -n '/sub incdec {/,/^}/p' incdec.pm > incdec.sub.pl
	m4 --define="INCLUDE_INCDEC_SUBROUTINE=include(\`incdec.sub.pl')dnl" $< > $@
	rm incdec.sub.pl


.PHONY: test
test:
	prove -v


.PHONY: doc
doc: $(MAN_PAGE)

$(MAN_PAGE): $(MAN_PAGE).txt
	a2x --no-xmllint --format manpage $<
