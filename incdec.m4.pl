INCLUDE_INCDEC_SUBROUTINE

my ($output, $start_position) = incdec(
	$line,
	$increment_by,
	$point_position,
	$backward
);
print "$start_position\#$output";
