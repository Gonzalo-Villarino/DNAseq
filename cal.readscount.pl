use strict;
use warnings;
##usage    perl cal.readscount.pl filename  chrname chrsize

my $wsize = 1000;
my $overlap = 500;
my $chr = $ARGV[1];
my $chrsize = $ARGV[2];
my %pos;
my %end;
my $count = 0;

open(FILE,$ARGV[0]) or die;
while(<FILE>){
        chomp;
        my @line = split(/\t/,$_);
        next if(/@/);
        my $len = length($line[9]);
        if($line[2] eq $chr){
            if(exists $pos{$line[3]}){
                    if(exists $end{$line[3]+$len}){
                        next;
                    }
                    else{
                        $pos{$line[3]} = $pos{$line[3]} + 1;
                        $end{$line[3]+$len} = 1;
                        $count++;
                    }
            }
            else{
                $pos{$line[3]} = 1;
                $end{$line[3]+$len} = 1;
                $count++;
            }
        }
 }
 close FILE;

my $i = 1;
open(OUT,">$ARGV[0]\.$ARGV[1]\.count.txt") or die;
while($i<$chrsize+$wsize){
    my $j = $i;
    my $count = 0;
    while($j<$i+$wsize){
        if(exists $pos{$j}){
            $count = $count + $pos{$j};
        }
        $j++;
    }
    print OUT "$j\t$count\n";
    $i = $i + $overlap;

}

close OUT;

print "$ARGV[0]\t$ARGV[1]\t$count\n";


           
