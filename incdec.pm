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
	while ($line =~ /(\d+)/g) {
		if ($is_backward) {
			$previous_match_start = $-[0];

			# if $point_position < $-[0]
			# && previous $+[0] <= $point_position
			# if ($point_position >= $-[0]) {
			# 	$start_position = $-[0];
            #
			# 	last;
			# }
		}
		else {
		if ($point_position < $+[0]) {
			$start_position = $-[0];

			last;
		}
		}
	}

	if ($is_backward) {
		$start_position = $previous_match_start;
	}

	pos($line) = $start_position;
	$line =~ s/\G([^\d]*)(\d+)/$1 . ($2 + 1)/e;

	return $line;
}

1;
