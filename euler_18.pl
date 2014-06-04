#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;
use Data::Dumper;
use bignum;


#PROBLEM 18 
#~ By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.
#~ 
#~ 3
#~ 7 4
#~ 2 4 6
#~ 8 5 9 3
#~ 
#~ That is, 3 + 7 + 4 + 9 = 23.
#~ 
#~ Find the maximum total from top to bottom of the triangle below:
#~ 
#~ 75
#~ 95 64
#~ 17 47 82
#~ 18 35 87 10
#~ 20 04 82 47 65
#~ 19 01 23 75 03 34
#~ 88 02 77 73 07 63 67
#~ 99 65 04 28 06 16 70 92
#~ 41 41 26 56 83 40 80 70 33
#~ 41 48 72 33 47 32 37 16 94 29
#~ 53 71 44 65 25 43 91 52 97 51 14
#~ 70 11 33 28 77 73 17 78 39 68 17 57
#~ 91 71 52 38 17 14 91 43 58 50 27 29 48
#~ 63 66 04 68 89 53 67 30 73 16 69 87 40 31
#~ 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
#~ 
#~ NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route. 
#~ However, Problem 67, is the same challenge with a triangle containing one-hundred rows; 
#~ it cannot be solved by brute force, and requires a clever method! ;o)

my ( $file, $help );

GetOptions(
    'f|file=s'  => \$file,
    'h|help'    => \$help,
);

( $file && !$help ) or die <<USAGE;
Usage: $0   
  -f|--file            <file of triangle data>
  -h|--help            <this message>
USAGE

open TRI, "<", $file;
my %triangle;
my $row = 0;

while ( <TRI> ) {
	$row++;
	chomp;
	for my $num ( split(',', $_) ) {
		push @{ $triangle{$row} }, $num;
	}
}

#Hold triangle data as a hash of arrays, where the key is the row number and the array is the row data
#Basically start at the bottom of the triangle and solve the maximum path sum as a series of smaller triangles
#Something like max( current_row_array[i] + above_row_array[i]; current_row_array[i + 1] + above_row_array[i] )
#The max of the two sums is stored in above_row_array[i] which is written to the hash as the row is completed.
#When we move to the next row up the triangle the current_row_array will contain the current maximum sums for each path.
#In this way, the value of the sum in the top row will be the maximum path sum ......
 
my $pointer = $row;
while ( $pointer > 1 ) {
	my @current_row = @{ $triangle{$pointer} };
	my @next_row = @{ $triangle{$pointer-1} };
	for my $i ( 0 .. (scalar @current_row) - 2 ) {
		my $left = $current_row[$i] + $next_row[$i];
		my $right = $current_row[$i+1] + $next_row[$i];
		$next_row[$i] = $left >= $right ? $left : $right;
	}
	@{ $triangle{$pointer-1} } = @next_row;
	$pointer--;
}

print "Maximum path sum = ", (@{ $triangle{1} })[0],"\n";
	 
