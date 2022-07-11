#!/usr/bin/env perl -w

# Copyright (c) 2021–2022  Teddy Wing
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


use strict;

use Test::More;

use lib './';
use incdec;

my @got;
my @want;

@got = incdec::incdec('test 12', 1);
@want = ('test 13', 5);
is_deeply(
	\@got,
	\@want,
	'increments an integer'
);

@got = incdec::incdec('test 12 0', 1);
@want = ('test 13 0', 5);
is_deeply(
	\@got,
	\@want,
	'increments the first integer'
);

@got = incdec::incdec('test 012 0', 1);
@want = ('test 013 0', 6);
is_deeply(
	\@got,
	\@want,
	'increments an integer with a leading zero'
);

@got = incdec::incdec('test A-02 0', -1);
@want = ('test A-01 0', 8);
is_deeply(
	\@got,
	\@want,
	'increments a negative integer with a leading zero'
);

@got = incdec::incdec('openssl x509 -inform DER -in codesign0 -text', 1);
@want = ('openssl x509 -inform DER -in codesign1 -text', 37);
is_deeply(
	\@got,
	\@want,
	'increments a zero without removing the following character'
);

@got = incdec::incdec('test 12 0', 1, 6);
@want = ('test 13 0', 5);
is_deeply(
	\@got,
	\@want,
	'increments the first integer with point at position 6'
);

@got = incdec::incdec('test 19 0', 1, 6);
@want = ('test 20 0', 5);
is_deeply(
	\@got,
	\@want,
	'increments the first integer with point at position 6'
);

@got = incdec::incdec('test 12 0', 1, 7);
@want = ('test 12 1', 8);
is_deeply(
	\@got,
	\@want,
	'increments the second integer with point at position 7'
);

@got = incdec::incdec('test 12 19 555', 1, 9);
@want = ('test 12 20 555', 8);
is_deeply(
	\@got,
	\@want,
	'increments the second double-digit integer with point at position 9'
);

@got = incdec::incdec('test 12 19 555', 1, 12);
@want = ('test 12 19 556', 11);
is_deeply(
	\@got,
	\@want,
	'increments the third triple-digit integer with point at position 12'
);

@got = incdec::incdec('test 12 19 555', 7, 9);
@want = ('test 12 26 555', 8);
is_deeply(
	\@got,
	\@want,
	'increments the second double-digit integer by 7 with point at position 9'
);

@got = incdec::incdec('test 12 19 555 64', 1, 16);
@want = ('test 12 19 555 65', 15);
is_deeply(
	\@got,
	\@want,
	'increments the fourth double-digit integer with point at position 16'
);

@got = incdec::incdec('test 12 19 555 64', 1, 17, 1);
@want = ('test 12 19 555 65', 15);
is_deeply(
	\@got,
	\@want,
	'increments the fourth double-digit integer with point at position 17 backward'
);

@got = incdec::incdec('test 12 19 555 64', 1, 13, 1);
@want = ('test 12 19 556 64', 11);
is_deeply(
	\@got,
	\@want,
	'increments the third triple-digit integer with point at position 13 backward'
);

@got = incdec::incdec('test 12 19 555 64', 1, 14, 1);
@want = ('test 12 19 556 64', 11);
is_deeply(
	\@got,
	\@want,
	'increments the third triple-digit integer with point at position 14 backward'
);

@got = incdec::incdec('test 12 982 4 ', 1, 14, 1);
@want = ('test 12 982 5 ', 12);
is_deeply(
	\@got,
	\@want,
	'increments the third integer with point at position 14 backward'
);

@got = incdec::incdec('test -1 ', 1, 7, 1);
@want = ('test 0 ', 5);
is_deeply(
	\@got,
	\@want,
	'increments the negative integer with point at position 7 backward'
);

@got = incdec::incdec('test -1 ', -1, 7, 1);
@want = ('test -2 ', 5);
is_deeply(
	\@got,
	\@want,
	'decrements the negative integer with point at position 7 backward'
);

@got = incdec::incdec('test 1 -2', 1, 8, 1);
@want = ('test 1 -1', 7);
is_deeply(
	\@got,
	\@want,
	'increments the second negative integer with point at position 8 backward'
);

@got = incdec::incdec('test 1 -2', -1, 8, 1);
@want = ('test 1 -3', 7);
is_deeply(
	\@got,
	\@want,
	'decrements the second negative integer with point at position 8 backward'
);

@got = incdec::incdec('test 12', -1);
@want = ('test 11', 5);
is_deeply(
	\@got,
	\@want,
	'decrements the first integer'
);

@got = incdec::incdec('test 12', -1, 7, 1);
@want = ('test 11', 5);
is_deeply(
	\@got,
	\@want,
	'decrements the first integer with point at position 7 backward'
);

@got = incdec::incdec('test 12 982 4', -1, 11, 1);
@want = ('test 12 981 4', 8);
is_deeply(
	\@got,
	\@want,
	'decrements the second integer with point at position 11 backward'
);

@got = incdec::incdec('test 12 982 4', -1, 9, 1);
@want = ('test 12 981 4', 8);
is_deeply(
	\@got,
	\@want,
	'decrements the second integer with point at position 9 backward'
);

@got = incdec::incdec('test 12 982 4', -5, 8, 1);
@want = ('test 12 977 4', 8);
is_deeply(
	\@got,
	\@want,
	'decrements the second integer by 5 with point at position 8 backward'
);

@got = incdec::incdec('test 12 1 4', -2, 9, 1);
@want = ('test 12 -1 4', 8);
is_deeply(
	\@got,
	\@want,
	'decrements the second integer by 2 with point at position 9 backward'
);

@got = incdec::incdec('test_99_A_-_03_[a30df7cf]', 1, 15, 1);
@want = ('test_99_A_-_04_[a30df7cf]', 13);
is_deeply(
	\@got,
	\@want,
	'increments the second zero-prefixed integer by 1 with point at position 15 backward'
);

@got = incdec::incdec("sed -n '39,54p' Alice\'s\ Adventures\ in\ Wonderland.txt ", 1, 3, 1);
@want = ("sed -n '40,54p' Alice\'s\ Adventures\ in\ Wonderland.txt ", 8);
is_deeply(
	\@got,
	\@want,
	'increments the first integer with point at position 3 backward'
);

@got = incdec::incdec("sed -n '39,54p' Alice\'s\ Adventures\ in\ Wonderland.txt ", 1, 8, 1);
@want = ("sed -n '40,54p' Alice\'s\ Adventures\ in\ Wonderland.txt ", 8);
is_deeply(
	\@got,
	\@want,
	'increments the first integer with point at position 8 backward'
);

@got = incdec::incdec("sed -n '39,54p' Alice\'s\ Adventures\ in\ Wonderland.txt ", -1, 10, 1);
@want = ("sed -n '38,54p' Alice\'s\ Adventures\ in\ Wonderland.txt ", 8);
is_deeply(
	\@got,
	\@want,
	'decrements the first integer with point at position 10 backward'
);

@got = incdec::incdec("sed -n '39,54p' Alice\'s\ Adventures\ in\ Wonderland.txt ", 1, 3, 8);
@want = ("sed -n '40,54p' Alice\'s\ Adventures\ in\ Wonderland.txt ", 8);
is_deeply(
	\@got,
	\@want,
	'increments the first integer with point at position 3'
);

done_testing;
