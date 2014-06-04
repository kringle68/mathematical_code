#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;

#PROBLEM 15
#Starting in the top left corner of a 2 x 2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.
#How many such routes are there through a 20 x 20 grid?

#NOTE: This is the staircase walk problem, which is a combination problem (MS221 block A!)
#Basically:   (m + n)! / m!n!
#http://mathworld.wolfram.com/StaircaseWalk.html

my ( $x, $y, $help );

GetOptions(
    'x|x=i'    => \$x,
    'y|y=i'    => \$y,
    'h|help'   => \$help,
);

( $x && $y && $x > 0 && $y > 0 && !$help ) or die <<USAGE;
Usage: $0   
  -x|--x				   <size of grid in x direction>
  -y|--y				   <size of grid in y direction>
  -h|--help                    <this message>
USAGE

my $numerator = factorial($x + $y);
print "Numerator: $numerator\n";

my $denominator = factorial($x) * factorial($y);
print "Denominator: $denominator\n";

print "Number of paths across $x by $y grid = ", $numerator / $denominator, "\n";

sub factorial
{
	my ($num) = @_;
	my $factorial = 1;
	for my $n ( 2 .. $num ) {
		$factorial = $factorial * $n;
	}
	return $factorial;
}

#NOTE: This is the staircase walk problem, which is a combination problem (MS221 block A!)
#Basically:   (m + n)! / m!n!
#http://mathworld.wolfram.com/StaircaseWalk.html
