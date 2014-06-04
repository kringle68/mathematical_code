#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;
use Data::Dumper;
use bignum;

#PROBLEM 21
#~ Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
#~ If d(a) = b and d(b) = a, where a  b, then a and b are an amicable pair and each of a and b are called amicable numbers.
#~ 
#~ For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
#~ 
#~ Evaluate the sum of all the amicable numbers under 10000.

my ( $ceiling, $help );

GetOptions(
    'c|ceiling=i'               => \$ceiling,
    'h|help'                    => \$help,
);

( $ceiling && !$help ) or die <<USAGE;
Usage: $0   
  -c|--ceiling				   <number BELOW which we the sum of amicable numbers is calculated>
  -h|--help                    <this message>
USAGE

my $sum_amicable_numbers = 0;
my %amicable_store;

for my $n ( 1 .. $ceiling - 1 ) {
	my $divsum = 0;
	$divsum += get_sum_proper_divisors($n);
	if ( $divsum > $n ) {
		$amicable_store{$divsum} = $n;
	}
	elsif ( $divsum < $n ) {
		if ( $amicable_store{$n} && $amicable_store{$n} == $divsum ) {
			print "AMICABLE: $n and $amicable_store{$n}\n";
			$sum_amicable_numbers += ( $n + $amicable_store{$n} );
		}
	}	
}

print "The total sum of amicable numbers below $ceiling is $sum_amicable_numbers\n";

sub get_sum_proper_divisors {
  my ($num) = @_;
  my $max = int(($num / 2) + 1);
  my $sum = 1;
  for my $i ( 2 .. $max ) {
    if ( $num % $i == 0 ) {
		$sum += $i;
		#$sum += $num / $i;
		#$max = $max / $i + 1;
		#redo
	}
  }
  print "NUM: $num, SUM: $sum\n";
  return $sum;
}

#~ sub get_sum_proper_divisors {
  #~ my ($x) = @_;
  #~ my $nnn = $x;
  #~ my @prime_factors;
  #~ my $sum = 1;
  #~ my %divisors;
  #~ for( my $y = 2; $y <= $x; $y++ ) { 
	#~ next if $x % $y; 
	#~ $x /= $y; 
	#~ foreach ( keys %divisors ) {
		  #~ $divisors{ $_ * $y } = 1;
	#~ }
	#~ $divisors{$y} = 1;
	#~ push @prime_factors, $y;
	#~ redo 
  #~ }
  #~ foreach ( keys %divisors ) {
	#~ $sum += $_ if $_ != $nnn;
  #~ }
  #~ return $sum;
#~ }

#Look at this regex for providing prime factors of numbers.....
#Very fast - can use to produce divisors from mutiplying out
#perl -le '$x=shift; for($y=2; $y<=$x; $y++) { next if $x%$y; $x/=$y; print $y; redo }' 1000

#~ as a subroutine:
#~ my $x = 24;
#~ my @prime_factors;
#~ for( my $y = 2; $y <= $x; $y++ ) { 
	#~ next if $x % $y; 
	#~ $x /= $y; 
	#~ push @prime_factors, $y;
	#~ redo 
#~ }
#~ 
#~ print join( ', ', @prime_factors ), "\n";  	

