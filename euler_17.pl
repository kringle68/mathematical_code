#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;
use Data::Dumper;
use bignum;

#PROBLEM 17
#~ If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#~ 
#~ If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
#~ 
#~ 
#~ NOTE: Do not count spaces or hyphens. 
#~ For example, 342 (three hundred and forty-two) contains 23 letters and 
#~              115 (one hundred and fifteen) contains 20 letters. 
#~ The use of "and" when writing out numbers is in compliance with British usage.

my ( $ceiling, $help );

GetOptions(
    'c|ceiling=i'               => \$ceiling,
    'h|help'                    => \$help,
);

( $ceiling && $ceiling > 0 && !$help ) or die <<USAGE;
Usage: $0   
  -c|--ceiling				   <maximum number for addition of words>
  -h|--help                    <this message>
USAGE
 
my $HUNDRED = 'hundred';
my $THOUSAND = 'thousand';
my $AND = 'and';

my %DIGITS = (1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five', 6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine');
my %TEENS = (10 => 'ten', 11 => 'eleven', 12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen', 15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen' , 19 => 'nineteen');   
my %TENS = (2 => 'twenty', 3 => 'thirty', 4 => 'forty', 5 => 'fifty', 6 => 'sixty', 7 => 'seventy', 8 => 'eighty', 9 => 'ninety');

my $total_length = 0;
foreach ( 1 .. $ceiling ) {
	$total_length += get_number_in_words($_);
}

print "\n\nMAX NUM: $ceiling, WORDS LENGTH: $total_length\n";
	
sub get_number_in_words {
	my ($number) = @_;
	my @num_digits = split ( //, $number );
	my @rev_digits = reverse(@num_digits); 
	my $number_word;
	my $include_unit = 1;

	if ( $rev_digits[3] ) {
		$number_word = $DIGITS{$rev_digits[3]}.' '.$THOUSAND;
	}
	if ( $rev_digits[2] && $rev_digits[2] != 0 ) {
		if ( $number_word ) {
			$number_word = $number_word.' '.$DIGITS{$rev_digits[2]}.' '.$HUNDRED;
		}
		else {
			$number_word = $DIGITS{$rev_digits[2]}.' '.$HUNDRED;
		}
	}
	if ( $number_word ) {
		$number_word = $number_word.' '.$AND.' ' unless ($rev_digits[1] == 0 && $rev_digits[0] == 0 );
	}
	else {
		$number_word = '';
	}
	if ( $rev_digits[1] && $rev_digits[1] != 0 ) {
		if ( $rev_digits[1] == 1 ) {
			my $teen = $rev_digits[1].$rev_digits[0];
			$number_word = $number_word.$TEENS{$teen};
			$include_unit = 0;
		}
		else {
			$number_word = $number_word.$TENS{$rev_digits[1]}.' ';
		}
	}
	if ( $rev_digits[0] && $include_unit && $rev_digits[0] != 0 ) {
		$number_word = $number_word.$DIGITS{$rev_digits[0]};
	}
	print "$number_word  ";
	$number_word =~ tr/ //ds;
	return length($number_word);
}
