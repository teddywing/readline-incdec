use strict;
use warnings;

# use 5.010;

package incdec;

sub incdec {
	my ($line, $point_position, $is_backward) = @_;

	$point_position ||= 0;
	$is_backward ||= 0;

	my $original_point_position = $point_position;

	# If point is within a number, move it to ensure we match the whole number
	# rather than only part of its digits.
	my $final_line = '';
	my $line_part = $line;
	# my $previous_point_position = $point_position;
	my $previous_point_position = 0;
	$final_line .= substr($line_part, $previous_point_position);
	# while (1) {
	# for (my $i = 0; $i < 3; $i++) {
	# while ($point_position < length($line_part)) {
	# # do {
	# 	$line_part =~ /(\d+)/;
	# 	say "$-[0]:$+[0]...$line_part...";
	# 	if ($-[0] <= $point_position && $point_position < $+[0]) {
	# 		$point_position = $-[0];
    #
	# 		last;
	# 	}
    #
	# 	# if ($point_position >= length($line_part)) {
	# 	# 	last;
	# 	# }
	# 	# elsif ($point_position >= $+[0]) {
	# 	if ($point_position >= $+[0]) {
	# 		# repeat loop
	# 		$final_line .= substr($line, $previous_point_position, $point_position + 1);
	# 		$line_part = substr $line_part, $point_position;
	# 		next;
	# 	}
	# 	else {
	# 		last;
	# 	}
    #
	# 	# $line_part = substr $line_part, $point_position;
	# }
	# } while ($point_position < length($line_part));

	my $line_start = '';
	# while ($line_part =~ /(\d+)/) {
	while ($point_position < length($line_part)) {
		my $len = length($line_part);
		# print "p[$line_part]p{$point_position:$len}";
		$line_part =~ /(\d+)/;
		if ($-[0] <= $point_position && $point_position < $+[0]) {
			$point_position = $-[0];

			last;
		}

		if ($point_position >= $+[0]) {
			$line_start .= substr($line_part, $previous_point_position, $+[0]);
			$line_part = substr($line_part, $+[0]);
			$previous_point_position = $point_position;
			$point_position = 0;

			next;
		}
		else {
			last;
		}
	}

	# my $line_part = substr $line, $point_position;

	$line_part =~ s/(\d+)/$1+1/e;

	my $line_excluded = substr $line_start, 0, $original_point_position;
	# print "x[$line_excluded]x[$line_part]x";

	$line = $line_excluded . $line_part;

	return $line;

	# return $line_part;
	# return $final_line;
}

1;
