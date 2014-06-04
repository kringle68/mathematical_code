#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;
use Data::Dumper;
use bignum;


#PROBLEM 20
#~ n! means n x (n  1) x ... x 3 x 2 x 1
#~ 
#~ For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
#~ and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
#~ 
#~ Find the sum of the digits in the number 100!

my ( $ceiling, $help );

GetOptions(
    'c|ceiling=i'               => \$ceiling,
    'h|help'                    => \$help,
);

( $ceiling && $ceiling > 0 && !$help ) or die <<USAGE;
Usage: $0   
  -c|--ceiling				   <value of factorial for summation>
  -h|--help                    <this message>
USAGE

my $fac = factorial($ceiling);
my $sum = 0;
foreach ( split//, $fac ) {
	$sum += $_;
}
print "The summation of the factorial of $ceiling is $sum\n";

sub factorial
{
	my ($num) = @_;
	my $factorial = 1;
	for my $n ( 2 .. $num ) {
		$factorial = $factorial * $n;
	}
	return $factorial;
}
