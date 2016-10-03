use strict;
use warnings;
my $file = $ARGV[0];

open(FILE,"chr.size.txt") or die;
while(<FILE>){
    chomp;
    my @line = split(/ /,$_);
    system "perl cal.readscount.pl $ARGV[0] $line[0] $line[1] >> $ARGV[0].count & ";
}
close FILE;
