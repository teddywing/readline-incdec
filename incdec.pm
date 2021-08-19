use strict;
use warnings;

package incdec;

sub incdec {
	my ($line, $point_position, $is_backward) = @_;

	$point_position ||= 0;
	$is_backward ||= 0;

	my $start_position = 0;
	my @points = ();
	my $previous_match_start = 0;
	my $previous_match_end = 0;
	while ($line =~ /(\d+)/g) {
		if ($is_backward) {
			# print "pos[$point_position] -[$-[0]]- +[$+[0]]+\n";
			# if $point_position < $-[0]
			# && previous $+[0] <= $point_position
			# if ($previous_match_end <= $point_position && $point_position < $-[0]) {
			if ($-[0] <= $point_position && $point_position < $+[0]) {
				# print "matched";
				$start_position = $-[0];

				last;
			}

			$previous_match_start = $-[0];
			$previous_match_end = $+[0];
		}
		else {
		if ($point_position < $+[0]) {
			$start_position = $-[0];

			last;
		}
		}
	}

	if ($is_backward && $point_position == length $line) {
		$start_position = $previous_match_start;
	}

	pos($line) = $start_position;
	$line =~ s/\G([^\d]*)(\d+)/$1 . ($2 + 1)/e;

	return $line;
}

1;
