#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Getopt::Long;
use Data::Dumper;
use bignum;

#PROBLEM 19
#~ You are given the following information, but you may prefer to do some research for yourself.
#~ 
#~ 1 Jan 1900 was a Monday.
#~ Thirty days has September,
#~ April, June and November.
#~ All the rest have thirty-one,
#~ Saving February alone,
#~ Which has twenty-eight, rain or shine.
#~ And on leap years, twenty-nine.
#~ A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
#~ How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

my $year = 1900;
my $month = 1;
my $day = 2;

my %MONTHS = (1 => 'January', 2 => 'February', 3 => 'March', 4 => 'April', 5 => 'May', 6 => 'June', 7 => 'July', 8 => 'August', 9 => 'September', 10 => 'October', 11 => 'November', 12 => 'December');
my %MONTH_DAYS = ('January' => 31, 'February' => 31, 'March' => 28, 'April' => 31, 'May' => 30, 'June' => 31, 'July' => 30, 'August' => 31, 'September' => 31, 'October' => 30, 'November' => 31, 'December' => 30);
my %DAYS = (1 => 'Sunday', 2 => 'Monday', 3 => 'Tuesday', 4 => 'Wednesday', 5 => 'Thursday', 6 => 'Friday', 7 => 'Saturday');

my $num_sundays = 0;

while ( $year < 2001 ) {
	$month++;
	my $month_name = $MONTHS{$month};
	my $month_days = $MONTH_DAYS{$month_name};
	$month_days++ if $month == 3 && $year % 4 == 0;
	$day = $day + $month_days % 7;
	$day = $day % 7 if $day > 7;
	if ( $year > 1900 && $day == 1 ) {
		print "$DAYS{$day} $day $MONTHS{$month} $year\n";
		$num_sundays++;
	}
	if ( $month == 12 ) {
		$year++;
		$month = 0;
	}
} 

print "The number of months with Sunday as the first day in the 20th Century is $num_sundays\n";
