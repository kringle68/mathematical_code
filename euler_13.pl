#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;
use Data::Dumper;
use bignum;

#PROBLEM 13
#Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.	(#In prob13.txt)

open NUM, "<", 'prob13.txt';
my $total = 0;

while ( <NUM> ) {
	chomp;
	$total += $_;
}

$total = sprintf("%0.1f", ($total / 1e+42) );

print "First ten digits (plus one dp): $total\n";
