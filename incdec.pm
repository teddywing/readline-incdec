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

	my $number_regex = '-?([1-9]\d*|0\D|0$)';

	my $start_position = 0;
	my $previous_match_start = 0;
	my $i = 0;
	while ($line =~ /($number_regex)/g) {
		if ($is_backward) {
			# Set start position to the current match start. This gives us the
			# correct start position when incrementing the last number in a
			# line.
			$start_position = $-[0];

			# Keep the start position of the first number if point is before
			# the first number.
			if ($i == 0 && $point_position < $-[0]) {
				last;
			}

			# If point is not at the end, set start position to the number
			# closest to the point position.
			if ($point_position < $-[0]) {
				$start_position = $previous_match_start;

				last;
			}

			$previous_match_start = $-[0];
			$i++;
		}
		else {
			if ($point_position < $+[0]) {
				$start_position = $-[0];

				last;
			}
		}
	}

	pos($line) = $start_position;
	$line =~ s/\G($number_regex)/$1 + $increment_by/e;

	return ($line, $start_position);
}

1;
