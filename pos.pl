#!/usr/bin/env perl -w

use strict;

my $test = 'test 12 0 45';

$test =~ /(\d+)/g;
pos($test) = 7;
$test =~ s/\G([^\d]*)(\d+)/$1 . ($2 + 1)/e;

print "$test\n";
