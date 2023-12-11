#!/usr/bin/perl

sub F {
	my @a= @{$_[0]};
	my $zeros = 0;
	my @d;
	my $x;
	
	foreach(@a) {
		if ($_ != 0) {
			$zeros = 1; 
		}	
	}

	if ($zeros <= 0) {
		return 0;
	}
	
	for my $i (0 .. $#a-1) {
		$x = $a[$i+1] - $a[$i];
		push(@d, $x);
	}

	$diff = F(\@d);
	return $a[0] - $diff;
}

open(DATA, "<input.txt") or die "$!";

$total = 0;

while(<DATA>) {
	my @a;
	push(@a, split(' ', $_)); 
	$f = F(\@a);
	$total = $total + $f; 

}

print "$total\n";

