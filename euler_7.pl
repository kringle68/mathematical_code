#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Data::Dumper;
use Getopt::Long;


#PROBLEM 7
#By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
#What is the 10 001st prime number?

my ( $max, $help );

GetOptions(
    'm|max=i'       => \$max,
    'h|help'        => \$help,
);

( $max && $max > 0 && !$help ) or die <<USAGE;
Usage: $0   
  -m|--max			  <value for prime nubmer>
  -h|--help           <this message>
USAGE


my $primecount = 0;
my $n = 1;
while ( $primecount < $max ) {
	$n++;
	$primecount++ if isprime($n);
} 

print "\nThe prime number in position $max is $n\n";

sub isprime {
  my ($num) = @_;
  return 0 if $num < 2;
  return 1 if ($num == 2 || $num == 3);
  for (my $i = 2; $i < (sqrt($num) + 1); $i++) { 
	  return 0 if ($num % $i == 0); 
  }
  print "$num\t";
  return 1;
}
