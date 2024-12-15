#!/usr/bin/env perl
use strict;
use warnings;

my $file = 'input_b.txt';
open my $handle, $file or die "Could not open $file: $!";

my @leftList = (); my @rightList = ();
while( my $line = <$handle> ) {
	my @parts = split /\s+/, $line;
	push(@leftList,  $parts[0]);
	push(@rightList, $parts[1]);
}

my $similarityScore = 0;
for my $i (0 .. $#leftList) {
	my $count = grep { $_ eq $leftList[$i] } @rightList;
	$similarityScore += $leftList[$i] * $count;
}

print "$similarityScore\n";

close $handle;