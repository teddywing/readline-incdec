function incdec {
	local EX_DATAERR=65

	# Portion of the line from point to the end of the line.
	local line_part="${READLINE_LINE:$READLINE_POINT}"

	# Number to increment.
	local number=

	# If the line part doesn't contain a number, exit.
	# if ! [[ "$line_part" =~ [^0-9]*([0-9]+)[^0-9]* ]]; then
	# 	return $EX_DATAERR
	# fi

	number=${BASH_REMATCH[1]}

	# echo "${READLINE_LINE}"
	# echo "${BASH_REMATCH[0]}"
	# echo "$(($number + 1))"

	incremented_line="$(echo "$line_part" | perl -pe 's/(\d+)/$1+1/e')"

	# echo "${READLINE_LINE:0:$READLINE_POINT}$incremented_line"
	READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$incremented_line"
	# echo 'this is a test'
}

function __readline_incdec_incdec2 {
	# echo "!!"
	echo !#
}

# function __readline_incdec_perl {
# 	perl 
# }

# bind -x '"\C-xa+":incdec'
# bind '"\C-xa+": "\C-e$(incdec)\e\C-e"'
# bind '"\C-xa+": "\C-e`incdec`"'
# bind '"\C-xaa":\C-xa+'

function __readline_incdec_save_readline_point {
	__readline_incdec_readline_point="$READLINE_POINT"
}

bind -x '"\C-xasrp": __readline_incdec_save_readline_point'

# bind '"\C-xaa": \C-xasrp\C-c$(__readline_incdec_incdec2)\e\C-e'
# bind '"\C-xaa": \C-xasrp'
# bind '"\C-xaa": __readline_incdec_incdec2'

function __readline_incdec {
	local increment_by="$1"
	local backward="$2"

	# local incdec = 
	# 	print "$line, ${"increment-by"}, ${"point-position"}, $backward";

	line=$(perl -s -e '
INCLUDE_INCDEC_PL
' \
		-- \
		-line="$READLINE_LINE" \
		-increment_by="$increment_by" \
		-point_position="$READLINE_POINT" \
		-backward="$backward"
	)

	# echo "$line"

	READLINE_LINE="$line"

	# TODO: If point was at the end, put it at the end again. The length of he line may have changed.

	# TODO 2021.08.22: If new READLINE_LINE is longer, move point to the right. If shorter, move it to the left.
}

function __readline_incdec_increment {
	local old_line_length="${#READLINE_LINE}"

	__readline_incdec 1 1

	local new_line_length="${#READLINE_LINE}"

	if [ "$old_line_length" -gt "$new_line_length" ]; then
		READLINE_POINT="$(($READLINE_POINT - 1))"
	fi
}

function __readline_incdec_decrement {
	local old_line_length="${#READLINE_LINE}"

	__readline_incdec -1 1

	local new_line_length="${#READLINE_LINE}"

	if [ "$old_line_length" -lt "$new_line_length" ]; then
		READLINE_POINT="$(($READLINE_POINT + 1))"
	# elif [ "$old_line_length" -gt "$new_line_length" ]; then
	# 	READLINE_POINT="$(($READLINE_POINT - 1))"
	fi
}

bind -x '"\C-x-": __readline_incdec_decrement'
bind -x '"\C-x+": __readline_incdec_increment'


# 2021.01.15: Idea: Maybe try using $EDITOR

# 2021.08.20: Idea: If point is at start, use forward matching, if point is at end, use backward matching
