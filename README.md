Readline Incdec
===============

Readline bindings to increment and decrement numbers on the command line.


## Demo
The commands increment or decrement the closest number to the left of point. If
point is to the left of the first number in the line, the first number is
modified.

![Screencast](./Demo.gif)


## Bindings
Default bindings are provided, but they can also be customised by adding them
manually. By default:

| Binding | Action    |
|---------|-----------|
| `C-x a` | Increment |
| `C-x x` | Decrement |


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
