#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Data::Dumper;
use Getopt::Long;

#PROBLEM 1
#If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#Find the sum of all the multiples of 3 or 5 below 1000.

my ( $ceiling, $help );

GetOptions(
    'c|ceiling=i'               => \$ceiling,
    'h|help'                    => \$help,
);

( $ceiling && !$help ) or die <<USAGE;
Usage: $0   
  -c|--ceiling				   <number BELOW which we calculate sum of multiples of 3 or 5>
  -h|--help                    <this message>
USAGE

my $sum = 0;
foreach ( 1 .. $ceiling - 1) {
	if ( $_ % 3 == 0 || $_ % 5 == 0) {
		$sum += $_;
	}
}
print "Sum below $ceiling = $sum\n";

