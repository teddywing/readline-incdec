use strict;
use warnings;

package incdec;

sub incdec {
	my ($line, $point_position, $is_backward) = @_;

	$point_position ||= 0;
	$is_backward ||= 0;

	$line =~ s/(\d+)/$1+1/e;

	return $line;
}

1;
