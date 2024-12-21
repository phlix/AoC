#!/usr/bin/env perl
use strict;
use warnings;

#print "perl version: $]\n";

my $file = 'example_a.txt';
open my $handle, $file or die "Could not open $file: $!";

my $nSafeReports = 0;
my $lineNo = 0;
while( my $line = <$handle> ) {
	$lineNo++;
	print "\nzeile $lineNo: $line\n";
    my $isSafeReport = 1;
	my $previous = 0;
	my $nIncreased = 0;
	my $nDecreased = 0;
	my @levels = split /\s+/, $line;
	for my $i (0 .. $#levels) {
		if ($i eq 0) {
			$previous = $levels[$i];
			print "aktuell: $previous, previous: n/a, diff: n/a\n";
			next;
		}
		my $diff = $levels[$i] - $previous;
		if($diff < 0) {
			$nDecreased++;
		} else {
			$nIncreased++
		}
		$diff = abs($diff);
		print "aktuell: $levels[$i], previous: $previous, diff: $diff\n";
		$previous = $levels[$i];

		if ($diff eq 0) {
			$isSafeReport = 0;
			print "not safe due too same level in two steps\n";
			last;
		}
		if ($diff > 3) {
			$isSafeReport = 0;
			print "not safe due to too high discrepance\n";
			last;
		} elsif($nIncreased > 0 and $nDecreased > 0) {
			$isSafeReport = 0;
			print "not safe due to change in direction\n";
			last;
		}

	}
	if ($isSafeReport) {
		$nSafeReports++;
		print "safe: $nSafeReports\n";
	}
}

print "$nSafeReports\n";

close $handle;