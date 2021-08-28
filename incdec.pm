# Copyright (c) 2021  Teddy Wing
#
# This file is part of Incdec.
#
# Incdec is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Incdec is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Incdec. If not, see <https://www.gnu.org/licenses/>.


use strict;
use warnings;

package incdec;

sub incdec {
	my ($line, $increment_by, $point_position, $is_backward) = @_;

	$point_position ||= 0;
	$is_backward ||= 0;

	my $start_position = 0;
	my $previous_match_start = 0;
	while ($line =~ /(-?\d+)/g) {
		if ($is_backward) {
			# Set start position to the current match start. This gives us the
			# correct start position when incrementing the last number in a
			# line.
			$start_position = $-[0];

			# If point is not at the end, set start position to the number
			# closest to the point position.
			if ($point_position < $-[0]) {
				$start_position = $previous_match_start;

				last;
			}

			$previous_match_start = $-[0];
		}
		else {
			if ($point_position < $+[0]) {
				$start_position = $-[0];

				last;
			}
		}
	}

	# Using `\G` when `pos` is 0 seems to cause occasional missed substitutions.
	if ($start_position > 0) {
		pos($line) = $start_position;
		$line =~ s/\G(-?\d+)/$1 + $increment_by/e;
	}
	else {
		$line =~ s/(-?\d+)/$1 + $increment_by/e;
	}

	return ($line, $start_position);
}

1;
