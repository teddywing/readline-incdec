use strict;
use warnings;

package incdec;

sub incdec {
	my ($line, $point_position, $is_backward) = @_;

	$point_position ||= 0;
	$is_backward ||= 0;

	# my $original_point_position = $point_position;

	# If point is within a number, move it to ensure we match the whole number
	# rather than only part of its digits.
	# my $line_start = '';
	# my $line_part = $line;
	# while ($point_position < length($line_part)) {
	# 	$line_part =~ /(\d+)/;
    #
	# 	# If `$point_position` is within the matched number, we can stop.
	# 	if ($-[0] <= $point_position && $point_position < $+[0]) {
	# 		last;
	# 	}
    #
	# 	# Continue the loop if point is further right than the end of the match.
	# 	if ($point_position >= $+[0]) {
	# 		# Store the line part that we don't increment so we can include it at the end.
	# 		$line_start .= substr($line_part, 0, $+[0]);
    #
	# 		# Match starting in the next part of the string next iteration.
	# 		$line_part = substr($line_part, $+[0]);
    #
	# 		# Adjust point position according to the new line part.
	# 		$point_position -= $+[0];
    #
	# 		next;
	# 	}
	# 	else {
	# 		last;
	# 	}
	# }

	# Idea: Loop through @- and @+ to find @- <= point < @+
	# $point_position = $original_point_position;
	# my @matches = $line =~ /(\d+)/g;
	# print "[[@matches]]";
	# TODO: @- and @+ hold a list of captured groups. You need to loop through matches to get positions for each match with $-+[0]. It doesn't give you a list of positions of all matches.
	# print "-[[@-]]-.+[[@+]]+";
	# for (my $i = 0; $i < scalar @+ - 1; $i++) {
	# 	print "..$-[$i]:$+[$i]..$point_position..";
	# 	if ($point_position < $+[$i + 1]) {
	# 		print "x[$matches[$i]]x";
	# 	}
	# }
	# for (my $i = 0; $i < scalar @- - 1; $i++) {
	# 	print "..$-[$i + 1]:$+[$i]..$point_position..";
	# 	if ($point_position > $+[$i] && $point_position <= $-[$i + 1]) {
	# 		print "x[$matches[$i]]x";
	# 	}
	# }
	# for (my $i = scalar @+ - 1; $i > 0; $i--) {
	# 	print "..i[$i]..+[$+[$i]]..pos[$point_position]..";
	# 	if ($point_position < $+[$i]) {
	# 		print "x[$matches[$i - 1]]x";
	# 	}
	# }

	my $i = 0;
	my $start_position = 0;
	while ($line =~ /(\d+)/g) {
		my $pos = pos $line;
		# print "\n-[$-[0]]-+[$+[0]]+\n";
		# print "..+[@+]..perlpos[:$pos]..pos[$point_position]..";
		if ($point_position < $+[0]) {
			# print "//[$matches[$i]]//";
			$start_position = $-[0];

			last;
		}

		$i++;
	}
	# print "\npos[$start_position]\n";

	pos($line) = $start_position;

	$line =~ s/\G([^\d]*)(\d+)/$1 . ($2 + 1)/e;

	# Final match, final match before point

	# $line_part =~ s/(\d+)/$1+1/e;

	# my $line_excluded = substr $line_start, 0, $original_point_position;

	# $line = $line_excluded . $line_part;

	return $line;
}

1;
