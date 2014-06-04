#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Data::Dumper;
use Getopt::Long;

#PROBLEM 3
#The prime factors of 13195 are 5, 7, 13 and 29.
#What is the largest prime factor of the number 600851475143

my ( $ceiling, $help );

GetOptions(
    'c|ceiling=i'               => \$ceiling,
    'h|help'                    => \$help,
);

( $ceiling && !$help ) or die <<USAGE;
Usage: $0   
  -c|--ceiling				   <number to calculate prime factors for>
  -h|--help                    <this message>
USAGE

print "Largest prime factor for $ceiling = ".largestprime($ceiling)."\n";sub largestprime

{
	my ($num) = @_;
	my $i;
	return largestprime(max(2, $num/2)) if($num % 2 == 0);
	my $snum = int(sqrt($num));
	for ($i = 3; $i <= $snum; $i += 2)  {    
		if($num % $i == 0) {
			last;    
		}   
	}   
	if($i > $snum) {
		return $num;
	}
	else
	{
		return max($i, largestprime($num/$i));
	}
}

sub max($$)
{
	return (sort { $a <=> $b }(@_))[1];
}
