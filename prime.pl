#!usr/bin/perl -w

use strict;
use warnings;

my $o = 2;
print "enter upto what number you wish to generate the primes: ";
my $e = <STDIN>;
my ($i,$j,$p);
my @prime_=();
print "prime numbers are:\n";

for($i=$o; $i<=$e; $i++)
{
$p=0;
    for($j=1; $j<=$i; $j++)
      {
        if($i % $j== 0)
          {
            $prime_[$p] = "$j";
            $p++;
               }
        if ($prime_[1] == $i)
            {
            print "$i\t";
               }
                    }
        }
print"\n";
