use strict;
use 5.10.0;

my $lag = shift(@ARGV);

my @lterms;
for (my $i=1; $i<=$lag;$i++){
	my $k = $lag-$i;
	push @lterms, "ker[$i]*inc[j+$k]";
}

my $lagchain .= join " + ", @lterms;

while(<>){
	s/\bFOICHAIN\b/($lagchain)/;
	print;
}
