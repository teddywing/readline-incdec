use strict;
use warnings;

package incdec;

sub incdec {
	my ($line, $point_position, $is_backward) = @_;

	$point_position ||= 0;
	$is_backward ||= 0;

	# If point is within a number, move it to ensure we match the whole number
	# rather than only part of its digits.
	$line =~ /(\d+)/;
	if ($-[0] <= $point_position && $point_position < $+[0]) {
		$point_position = $-[0];
	}

	my $line_part = substr $line, $point_position;

	$line_part =~ s/(\d+)/$1+1/e;

	my $line_excluded = substr $line, 0, $point_position;

	$line = $line_excluded . $line_part;

	return $line;
}

1;
