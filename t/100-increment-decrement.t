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
	incdec::incdec('test 12 0', 7),
	'test 12 1',
	'increments the second integer with point at position 7'
);

done_testing;
