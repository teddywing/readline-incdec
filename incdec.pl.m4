use strict;
use warnings;

include(`incdec.sub.pl')dnl

my $output = incdec($line, $increment_by, $point_position, $backward);
print $output;
