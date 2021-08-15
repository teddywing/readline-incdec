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
	my $line_start = '';
	my $line_part = $line;
	my $previous_point_position = 0;
	while ($point_position < length($line_part)) {
		$line_part =~ /(\d+)/;
		if ($-[0] <= $point_position && $point_position < $+[0]) {
			$point_position = $-[0];

			last;
		}

		if ($point_position >= $+[0]) {
			$line_start .= substr($line_part, 0, $+[0]);
			$line_part = substr($line_part, $+[0]);
			$previous_point_position = $point_position;
			$point_position -= $+[0];

			next;
		}
		else {
			last;
		}
	}

	$line_part =~ s/(\d+)/$1+1/e;

	my $line_excluded = substr $line_start, 0, $original_point_position;

	$line = $line_excluded . $line_part;

	return $line;
}

1;
