#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Data::Dumper;
use Getopt::Long;

#PROBLEM 9 
#~ A Pythagorean triplet is a set of three natural numbers, a  b  c, for which,
#~ 
#~ a^2 + b^2 = c^2
#~ For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
#~ 
#~ There exists exactly one Pythagorean triplet for which a + b + c = 1000.
#~ Find the product abc.

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


for my $a ( 3 .. ($max-3)/3 ) {
	for my $b ( $a+1 .. ($max-1-$a)/2 ) {
	    my $c = $max - $a -$b;
	    if ($a ** 2 + $b ** 2 == $c ** 2) {
			print "ABC: $a, $b, $c\n";
			print "Product = ", $a * $b * $c, "\n";
		}
	}
}
