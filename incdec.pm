use strict;
use warnings;

package incdec;

sub incdec {
	my ($line) = @_;

	$line =~ s/(\d+)/$1+1/e;

	return $line;
}

1;
