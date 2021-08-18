use strict;
use warnings;

package incdec;

sub incdec {
	my ($line, $point_position, $is_backward) = @_;

	$point_position ||= 0;
	$is_backward ||= 0;

	my $start_position = 0;
	while ($line =~ /(\d+)/g) {
		if ($point_position < $+[0]) {
			$start_position = $-[0];

			last;
		}
	}

	pos($line) = $start_position;
	$line =~ s/\G([^\d]*)(\d+)/$1 . ($2 + 1)/e;

	return $line;
}

1;
