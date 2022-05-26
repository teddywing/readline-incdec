# Copyright (c) 2021–2022  Teddy Wing
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

# Version: 0.0.2


# Increment or decrement a number on the current line.
function __readline_incdec {
	local increment_by="$1"
	local backward="$2"

	result="$(perl -s -e '
sub incdec {
	my ($line, $increment_by, $point_position, $is_backward) = @_;

	$point_position ||= 0;
	$is_backward ||= 0;

	my $number_regex = q/-?([1-9]\d*|0\D|0$)/;

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

my ($output, $start_position) = incdec(
	$line,
	$increment_by,
	$point_position,
	$backward
);
print "$start_position\#$output";
' \
		-- \
		-line="$READLINE_LINE" \
		-increment_by="$increment_by" \
		-point_position="$READLINE_POINT" \
		-backward="$backward"
	)"

	echo "$result"
}

# Increment the nearest number to the left of point by 1.
function __readline_incdec_increment {
	local old_line_length="${#READLINE_LINE}"

	result="$(__readline_incdec 1 1)"

	line="${result#*#}"
	READLINE_LINE="$line"

	local new_line_length="${#READLINE_LINE}"

	local start_position="${result%#*}"

	# If a negative sign was removed, keep point where it was.
	if [ \
		"$old_line_length" -gt "$new_line_length" \
		-a \
		"$start_position" -le "$READLINE_POINT" \
	]; then
		READLINE_POINT="$(($READLINE_POINT - 1))"
	fi
}

# Decrement the nearest number to the left of point by 1.
function __readline_incdec_decrement {
	local old_line_length="${#READLINE_LINE}"

	result="$(__readline_incdec -1 1)"

	line="${result#*#}"
	READLINE_LINE="$line"

	local new_line_length="${#READLINE_LINE}"

	local start_position="${result%#*}"

	# If a negative sign was added, keep point where it was.
	if [ \
		"$old_line_length" -lt "$new_line_length" \
		-a \
		"$start_position" -le "$READLINE_POINT" \
	]; then
		READLINE_POINT="$(($READLINE_POINT + 1))"
	fi
}
