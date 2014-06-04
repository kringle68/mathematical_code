#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Data::Dumper;
use Getopt::Long;

#PROBLEM 6
#~ The sum of the squares of the first ten natural numbers is,
#~ 
#~ 1^2 + 2^2 + ... + 10^2 = 385
#~ The square of the sum of the first ten natural numbers is,
#~ 
#~ (1 + 2 + ... + 10)^2 = 552 = 3025
#~ Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025  385 = 2640.
#~ 
#~ Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

my ( $max, $help );

GetOptions(
    'm|max=i'       => \$max,
    'h|help'        => \$help,
);

( $max && $max > 0 && !$help ) or die <<USAGE;
Usage: $0   
  -m|--max			  <maximum value for sum of squares calculation>
  -h|--help           <this message>
USAGE

my $sumnum;
my $sum_of_squares;

foreach (1 .. $max) {
	$sumnum += $_;
	$sum_of_squares += $_ ** 2;
} 

my $square_of_sums = $sumnum ** 2;

print "Square of sums for 1 to $max = $square_of_sums\n";
print "Sum of squares for 1 to $max = $sum_of_squares\n";
print "The difference is ", $square_of_sums - $sum_of_squares, "\n";

