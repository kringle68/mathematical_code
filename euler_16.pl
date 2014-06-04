#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;
use Data::Dumper;
use bignum;

#PROBLEM 16
#2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
#What is the sum of the digits of the number 2^1000?

my ( $ceiling, $help );

GetOptions(
    'c|ceiling=i'               => \$ceiling,
    'h|help'                    => \$help,
);

( $ceiling && $ceiling > 0 && !$help ) or die <<USAGE;
Usage: $0   
  -c|--ceiling				   <power of 2>
  -h|--help                    <this message>
USAGE

my $total = 0;
foreach ( split ( //, 2 ** $ceiling ) ) {
	$total += $_;
}
print "Total sum of digits for 2 to the power $ceiling is $total\n";
  
