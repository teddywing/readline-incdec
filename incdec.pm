use strict;
use warnings;

package incdec;

sub incdec {
	my ($line, $increment_by, $point_position, $is_backward) = @_;

	$point_position ||= 0;
	$is_backward ||= 0;

	my $start_position = 0;
	# my @match_ranges;
	my $previous_match_start = 0;
	my $previous_match_end = 0;
	while ($line =~ /(-?\d+)/g) {
		if ($is_backward) {
			print "p[$point_position] -[$-[0]] +[$+[0]]\n";
			print "p[$point_position] -[$previous_match_start] +[$previous_match_end]\n";
			# print "last match: $^N\n";
			print $previous_match_end - 1 . " <= $point_position < $-[0]\n";
			# if ($previous_match_end - 1 <= $point_position
			# 		&& $point_position < $-[0]) {

			# Try always setting $start_position and resetting it if there's another number?
			# TODO: document, last number handling

			# Set start position to the current match start. This gives us the
			# correct start position when incrementing the last number in a
			# line.
			$start_position = $-[0];

			# If point is not at the end, set start position to the number
			# closest to the point position.
			if ($point_position < $-[0]) {
				# print "match at [$previous_match_start]";
				$start_position = $previous_match_start;

				last;
			}

			$previous_match_start = $-[0];
			$previous_match_end = $+[0];

			# my @range = ($-[0], $+[0]);
			# push @match_ranges, \@range;
		}
		else {
			if ($point_position < $+[0]) {
				$start_position = $-[0];

				last;
			}
		}
	}

	pos($line) = $start_position;
	$line =~ s/\G([^-\d]*)(-?\d+)/$1 . ($2 + $increment_by)/e;

	return $line;
}

1;
