#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Data::Dumper;
use Getopt::Long;

#PROBLEM 10
#The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#Find the sum of all the primes below two million.

my ( $max, $help );

GetOptions(
    'm|max=i'       => \$max,
    'h|help'        => \$help,
);

( $max && $max > 0 && !$help ) or die <<USAGE;
Usage: $0   
  -m|--max			  <max value for prime number>
  -h|--help           <this message>
USAGE


my $total = 0;
my %notprimes;
PRIMES: foreach my $num ( 2 .. $max ) {
	next PRIMES if $notprimes{$num};
	$total = $total + $num;
    for (my $mul = $num + $num; $mul <= $max; $mul += $num) {
        $notprimes{$mul} = 1;
    }	
}
print "\nThe sum of all primes below $max is $total\n";


#FROM forum -> using a vector:
#
#~ my $UPPER = $max;
#~ my $sieve = "";
#~ my $sum = 0;
#~ GUESS: for (my $guess = 2; $guess <= $UPPER; $guess++) {
    #~ next GUESS if vec($sieve,$guess,1);
#~ #    print "$guess\n" if $count++ % 10000 == 0;
    #~ $sum += $guess;
    #~ for (my $mults = $guess * $guess; $mults <= $UPPER; $mults += $guess) {
        #~ vec($sieve,$mults,1) = 1;
    #~ }
#~ }
#~ print "\nThe sum of all primes below $max is $sum\n";
