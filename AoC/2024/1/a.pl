#!/usr/bin/env perl
use strict;
use warnings;

#print "perl version: $]\n";

my $file = 'input_a.txt';
open my $handle, $file or die "Could not open $file: $!";

my @leftList = (); my @rightList = ();
while( my $line = <$handle> ) {
	my @parts = split /\s+/, $line;
	push(@leftList,  $parts[0]);
	push(@rightList, $parts[1]);
}

@leftList  = sort @leftList;
@rightList = sort @rightList;

my $diff       = 0;
my $sumAggDiff = 0;
for my $i (0 .. $#leftList) {
	if ($leftList[$i] < $rightList[$i]) {
		$diff = $rightList[$i] - $leftList[$i];
	}
	else {
		$diff = $leftList[$i] - $rightList[$i];
	}
	
	$sumAggDiff += $diff;
}

print "$sumAggDiff\n";

close $handle;