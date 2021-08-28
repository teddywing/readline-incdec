Readline Incdec
===============

Readline bindings to increment and decrement numbers on the command line.


## Demo
The commands increment or decrement the closest number to the left of point. If
point is to the left of the first number in the line, the first number is
modified.

TODO

Idea: ffmpeg stuff. concat.


## Install
TODO

	source /path/to/incdec.bash

To enable the default bindings, also add:

	source /path/to/incdec-bindings.bash



	bind -x '"\C-x-": __readline_incdec_decrement'
	bind -x '"\C-x+": __readline_incdec_increment'

## License
Copyright © 2021 Teddy Wing. Licensed under the GNU GPLv3+ (see the included
COPYING file).
