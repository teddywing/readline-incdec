#!/usr/bin/env perl -w

use strict;

use Test::More;

use lib './';
use incdec;

is(
	incdec::incdec('test 12'),
	'test 13',
	'increments an integer'
);

is(
	incdec::incdec('test 12 0'),
	'test 13 0',
	'increments the first integer'
);

is(
	incdec::incdec('test 12 0', 6),
	'test 13 0',
	'increments the first integer with point at position 6'
);

is(
	incdec::incdec('test 19 0', 6),
	'test 20 0',
	'increments the first integer with point at position 6'
);

is(
	incdec::incdec('test 12 0', 7),
	'test 12 1',
	'increments the second integer with point at position 7'
);

is(
	incdec::incdec('test 12 19 555', 9),
	'test 12 20 555',
	'increments the second double-digit integer with point at position 9'
);

is(
	incdec::incdec('test 12 19 555', 12),
	'test 12 19 556',
	'increments the third triple-digit integer with point at position 12'
);

is(
	incdec::incdec('test 12 19 555 64', 16),
	'test 12 19 555 65',
	'increments the fourth double-digit integer with point at position 16'
);

is(
	incdec::incdec('test 12 19 555 64', 17, 1),
	'test 12 19 555 65',
	'increments the fourth double-digit integer with point at position 16 backward'
);

done_testing;
