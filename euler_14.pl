#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;
use Data::Dumper;
use bignum;

#PROBLEM 14
#~ The following iterative sequence is defined for the set of positive integers:
#~ n -> n/2 (n is even)
#~ n -> 3n + 1 (n is odd)
#~ 
#~ Using the rule above and starting with 13, we generate the following sequence:
#~ 
#~ 13  40  20  10  5  16  8  4  2  1
#~ It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
#~ 
#~ Which starting number, under one million, produces the longest chain?
#~ 
#~ NOTE: Once the chain starts the terms are allowed to go above one million.

my ( $ceiling, $help );

GetOptions(
    'c|ceiling=i'               => \$ceiling,
    'h|help'                    => \$help,
);

( $ceiling && $ceiling > 0 && !$help ) or die <<USAGE;
Usage: $0   
  -c|--ceiling				   <max starting value (must be positive integer)>
  -h|--help                    <this message>
USAGE

my $maxlen = 0;
my $start = 0;
for ( 1 .. $ceiling ) {
	my $seqlen = get_sequence_length($_);
	if ( $seqlen > $maxlen ) {
		$maxlen = $seqlen;
		$start = $_;
	}
}
print "Max sequence length = $maxlen, starting number = $start\n";

sub get_sequence_length 
{
	my ($sn) = @_;
	my @seq = ($sn);
	my $num = $sn;
	while ($num > 1) {
		$num = $num % 2 == 0 ? $num / 2 : (3 * $num) + 1;
		push @seq, $num;
	}
	my $seqlen = scalar @seq;
	#print "SN: $sn; SEQ: ",join('->', @seq), "  [$seqlen]\n";
	return $seqlen;
}
