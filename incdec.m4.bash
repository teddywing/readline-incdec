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

# Version: 0.0.1


# Increment or decrement a number on the current line.
function __readline_incdec {
	local increment_by="$1"
	local backward="$2"

	line=$(perl -s -e '
INCLUDE_INCDEC_PL
' \
		-- \
		-line="$READLINE_LINE" \
		-increment_by="$increment_by" \
		-point_position="$READLINE_POINT" \
		-backward="$backward"
	)

	READLINE_LINE="$line"
}

# Increment the nearest number to the left of point by 1.
function __readline_incdec_increment {
	local old_line_length="${#READLINE_LINE}"

	__readline_incdec 1 1

	local new_line_length="${#READLINE_LINE}"

	# If a negative sign was removed, keep point where it was.
	if [ "$old_line_length" -gt "$new_line_length" ]; then
		READLINE_POINT="$(($READLINE_POINT - 1))"
	fi
}

# Decrement the nearest number to the left of point by 1.
function __readline_incdec_decrement {
	local old_line_length="${#READLINE_LINE}"

	__readline_incdec -1 1

	local new_line_length="${#READLINE_LINE}"

	# If a negative sign was added, keep point where it was.
	if [ "$old_line_length" -lt "$new_line_length" ]; then
		READLINE_POINT="$(($READLINE_POINT + 1))"
	fi
}
