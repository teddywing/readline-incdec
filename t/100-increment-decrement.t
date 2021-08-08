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

done_testing;
