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
	# my $previous_match_end = 0;
	while ($line =~ /(\d+)/g) {
		if ($is_backward) {
			# print "p[$point_position] -[$-[0]] +[$+[0]]\n";
			# print "p[$point_position] -[$previous_match_start] +[$previous_match_end]\n";
			# print "last match: $^N\n";
			# print $previous_match_end - 1 . " <= $point_position < $-[0]\n";
			# if ($previous_match_end - 1 <= $point_position
			# 		&& $point_position < $-[0]) {
			if ($point_position < $-[0]) {
				# print "match at [$previous_match_start]";
				$start_position = $previous_match_start;

				last;
			}

			$previous_match_start = $-[0];
			# $previous_match_end = $+[0];

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

	if ($is_backward && $point_position == length $line) {
		$start_position = $previous_match_start;
	}

	pos($line) = $start_position;
	$line =~ s/\G([^\d]*)(\d+)/$1 . ($2 + $increment_by)/e;

	return $line;
}

1;
