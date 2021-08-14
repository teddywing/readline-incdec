use strict;
use warnings;

package incdec;

sub incdec {
	my ($line, $point_position, $is_backward) = @_;

	$point_position ||= 0;
	$is_backward ||= 0;

	my $original_point_position = $point_position;

	# If point is within a number, move it to ensure we match the whole number
	# rather than only part of its digits.
	my $line_part = $line;
	while (1) {
		$line_part =~ /(\d+)/;
		if ($-[0] <= $point_position && $point_position < $+[0]) {
			$point_position = $-[0];

			last;
		}

		if ($point_position >= $+[0]) {
			# repeat loop
			next;
		}
		else {
			last;
		}

		$line_part = substr $line_part, $point_position;
	}

	# my $line_part = substr $line, $point_position;

	$line_part =~ s/(\d+)/$1+1/e;

	my $line_excluded = substr $line, 0, $original_point_position;

	# $line = $line_excluded . $line_part;

	# return $line;

	return $line_part;
}

1;
