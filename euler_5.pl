#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Data::Dumper;
use Getopt::Long;


#PROBLEM 5
#2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

my ( $max, $help );

GetOptions(
    'm|max=i'       => \$max,
    'h|help'        => \$help,
);

( $max && $max > 0 && !$help ) or die <<USAGE;
Usage: $0   
  -m|--max			  <maximum value of POSITIVE integer for calculation of divisor>
  -h|--help           <this message>
USAGE

my $found = 0;
my $divisor = $max == 1 ? 1 : $max == 2 ? 2 : $max % 2 == 0 ? $max * ($max - 1) * ( ($max - 2) / 2 ) : $max * ($max - 1) * ($max - 2);
my $adder = $divisor;
while ( !$found ) {
  my $check = check_divisor($divisor, $max);
  if ( $check ) {
    $found = 1;
  }
  else {
    $divisor = $divisor + $adder;
  }
}  

sub check_divisor
{
  my ($checker, $digits) = @_;
  foreach ( 1 .. $digits ) {
    return 0 if $checker % $_ != 0;
  }
  return 1;
}
print "Minimum complete divisor for 1 to $max is digits = $divisor\n";

