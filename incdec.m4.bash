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

bind -x '"\C-x-": __readline_incdec_decrement'
bind -x '"\C-x+": __readline_incdec_increment'
