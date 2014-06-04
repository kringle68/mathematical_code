#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Data::Dumper;
use Getopt::Long;


#PROBLEM 4
#A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 99.
#Find the largest palindrome made from the product of two 3-digit numbers.

my ( $digits, $help );

GetOptions(
    'd|digits=i'      => \$digits,
    'h|help'          => \$help,
);

( $digits && !$help ) or die <<USAGE;
Usage: $0   
  -d|--digits				   <number of digits to calculate palindrome>
  -h|--help                    <this message>
USAGE


my $max = (10 ** $digits) - 1;
my $maxpalindrome = 0;
for ( my $i = $max; $i > 0; $i--) {
	for ( my $j = $max; $j > 0; $j--) {
		my $product = $i * $j;
		if (($product == reverse $product) && ($product > $maxpalindrome) ) {
			$maxpalindrome = $product;
		}
	}
}
print "Maximimum palindrome for $digits digits = $maxpalindrome\n";
