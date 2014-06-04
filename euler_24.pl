#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;
use Data::Dumper;

#PROBLEM 24
#~ A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. 
#~ The lexicographic permutations of 0, 1 and 2 are:
#~ 012   021   102   120   201   210
#~ What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?


my ( $size, $permutation, $help );

GetOptions(
    's|size=i'               => \$size,
    'p|perm=i'               => \$permutation,
    'h|help'                    => \$help,
);

( $size > 0 && $size < 26 && $permutation && !$help ) or die <<USAGE;
Usage: $0   
  -s|--size				   <size of array>
  -p|--perm                <permutation>
  -h|--help                    <this message>
USAGE


my $permstring = nth_permutation($size, $permutation - 1);

print "The $permutation th permutation os $size elements is $permstring\n";

sub nth_permutation 
{
	my ($size, $nthperm) = @_;
	my $return = '';
    my $arrsize = $size - 1;
    
	my %fact;
	my %perm;
	
    foreach ( 0 .. $arrsize ) {
		$fact{$_} = factorial($_);
	}

	# compute factorial code
   for (my $i = 0; $i < $size; ++$i)
   {
      $perm{$i} = int($nthperm / $fact{$arrsize - $i});
      $nthperm = $nthperm % $fact{$arrsize - $i};
   }

   # readjust values to obtain the permutation
   # start from the end and check if preceding values are lower
   for ( my $k = $arrsize; $k > 0; --$k) {
      for (my $j = $k - 1; $j >= 0; --$j) {
         $perm{$k}++ if ($perm{$j} <= $perm{$k});
	  }
   }
   
   # build return permutation string
   foreach ( sort keys %perm ) {
      $return = $return.$perm{$_};
   }
  return $return;
}

sub factorial
{
	my ($num) = @_;
	return 1 if ($num == 1 || $num == 0);
	my $factorial = 1;
	for my $n ( 2 .. $num ) {
		$factorial = $factorial * $n;
	}
	return $factorial;
}

#Adapted from nifty C implementation of nth-permutation here:
#http://stackoverflow.com/questions/7918806/finding-n-th-permutation-without-computing-others
