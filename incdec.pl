#!/usr/bin/env perl -s
#
use strict;
use warnings;

sub incdec {
	my ($line, $increment_by, $point_position, $is_backward) = @_;

	$point_position ||= 0;
	$is_backward ||= 0;

	my $start_position = 0;
	my $previous_match_start = 0;
	while ($line =~ /\b(-?\d+)\b/g) {
		if ($is_backward) {
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

	if ($is_backward && $point_position == length $line) {
		$start_position = $previous_match_start;
	}

	pos($line) = $start_position;
	$line =~ s/\G([^-\d]*)(-?\d+)/$1 . ($2 + $increment_by)/e;

	return $line;
}

# my $line = 'test 1 0';
# my ${"increment-by"} = -1;
# my ${"point-position"} = 8;
# my $backward = 1;

my $line = 'test 1 -2';
my $increment_by = -1;
my $point_position = 9;
my $backward = 1;

print "$line, $increment_by, $point_position, $backward\n";
my $output = incdec($line, $increment_by, $point_position, $backward);
print $output;
print "\n";
