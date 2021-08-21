#!/usr/bin/env perl -w

use strict;

use Test::More;

use lib './';
use incdec;

is(
	incdec::incdec('test 12', 1),
	'test 13',
	'increments an integer'
);

is(
	incdec::incdec('test 12 0', 1),
	'test 13 0',
	'increments the first integer'
);

is(
	incdec::incdec('test 12 0', 1, 6),
	'test 13 0',
	'increments the first integer with point at position 6'
);

is(
	incdec::incdec('test 19 0', 1, 6),
	'test 20 0',
	'increments the first integer with point at position 6'
);

is(
	incdec::incdec('test 12 0', 1, 7),
	'test 12 1',
	'increments the second integer with point at position 7'
);

is(
	incdec::incdec('test 12 19 555', 1, 9),
	'test 12 20 555',
	'increments the second double-digit integer with point at position 9'
);

is(
	incdec::incdec('test 12 19 555', 1, 12),
	'test 12 19 556',
	'increments the third triple-digit integer with point at position 12'
);

is(
	incdec::incdec('test 12 19 555', 7, 9),
	'test 12 26 555',
	'increments the second double-digit integer by 7 with point at position 9'
);

is(
	incdec::incdec('test 12 19 555 64', 1, 16),
	'test 12 19 555 65',
	'increments the fourth double-digit integer with point at position 16'
);

is(
	incdec::incdec('test 12 19 555 64', 1, 17, 1),
	'test 12 19 555 65',
	'increments the fourth double-digit integer with point at position 17 backward'
);

is(
	incdec::incdec('test 12 19 555 64', 1, 13, 1),
	'test 12 19 556 64',
	'increments the third triple-digit integer with point at position 13 backward'
);

is(
	incdec::incdec('test 12 19 555 64', 1, 14, 1),
	'test 12 19 556 64',
	'increments the third triple-digit integer with point at position 14 backward'
);

is(
	incdec::incdec('test 12 982 4 ', 1, 14, 1),
	'test 12 982 5 ',
	'increments the third integer with point at position 14 backward'
);

is(
	incdec::incdec('test -1 ', 1, 7, 1),
	'test 0 ',
	'increments the negative integer with point at position 7 backward'
);

is(
	incdec::incdec('test 12', -1),
	'test 11',
	'decrements the first integer'
);

is(
	incdec::incdec('test 12', -1, 7, 1),
	'test 11',
	'decrements the first integer with point at position 7 backward'
);

is(
	incdec::incdec('test 12 982 4', -1, 11, 1),
	'test 12 981 4',
	'decrements the second integer with point at position 11 backward'
);

is(
	incdec::incdec('test 12 982 4', -1, 9, 1),
	'test 12 981 4',
	'decrements the second integer with point at position 9 backward'
);

is(
	incdec::incdec('test 12 982 4', -5, 8, 1),
	'test 12 977 4',
	'decrements the second integer by 5 with point at position 8 backward'
);

is(
	incdec::incdec('test 12 1 4', -2, 9, 1),
	'test 12 -1 4',
	'decrements the second integer by 2 with point at position 9 backward'
);

done_testing;
