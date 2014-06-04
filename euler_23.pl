#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;
use Data::Dumper;

#PROBLEM 23
#~ A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
#~ A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.
#~ As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.
#~ Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

my ( $ceiling, $help );

GetOptions(
    'c|ceiling=i'               => \$ceiling,
    'h|help'                    => \$help,
);
my $MAXPOSS = 28122;
$ceiling ||= $MAXPOSS;

( $ceiling > 0 && $ceiling <= $MAXPOSS && !$help ) or die <<USAGE;
Usage: $0   
  -c|--ceiling				   <number BELOW which we the sum of amicable numbers is calculated>
  -h|--help                    <this message>
USAGE

my %abundant;
my %added_abundants;
my %nonabundant = ( 1 => 1 );

for my $n ( 2 .. $ceiling ) {
	my $divsum = get_sum_proper_divisors($n);
	if ( $n < $divsum ) {
		$added_abundants{ $n * 2 } = 1 if ($n * 2) <= $ceiling; 
		for my $abu ( sort {$a <=> $b} keys %abundant ) {
			my $added = $abu + $n;
			$added_abundants{ $added } = 1 if $added <= $ceiling;
		}
		$abundant{$n} = 1;
	}
}

my $total = 0;
for my $num ( 1 .. $ceiling ) {
	$total += $num unless $added_abundants{$num};
}

print "Sum of all positive integers below $ceiling, which cannot be written as the sum of two abundant numbers, is $total\n";

sub get_sum_proper_divisors {
  my ($num) = @_;
  return 1 if $num == 2;
  my $max = int(($num / 2) + 1);
  my $sum = 1;
  for my $i ( 2 .. $max ) {
    if ( $num % $i == 0 ) {
		$sum += $i;
	}
  }
  return $sum;
}
