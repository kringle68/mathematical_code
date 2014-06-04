#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;
use Data::Dumper;

#PROBLEM 22
#~ Using names.txt, a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
#~ 
#~ For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 x 53 = 49714.
#~ 
#~ What is the total of all the name scores in the file?

open NAMES, "<", 'prob22.txt';

my @letters = ('A'..'Z');
my %letter_score;
foreach ( 0 ..  $#letters ) {
	$letter_score{$letters[$_]} = $_ + 1;
}

my $linecount = 1;
my $sumtotal = 0;
while ( <NAMES> ) {
	chomp;
	my @name = split( //, $_);
	my $sum = 0;
	for my $letter ( @name ) {
		$sum += $letter_score{$letter};
	}
	$sum = $sum * $linecount;
	$sumtotal += $sum;
	$linecount++;
}

print "Total = $sumtotal\n";
