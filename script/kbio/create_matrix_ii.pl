use strict;

if(@ARGV<1){
	die "[].pl [raw_data_*txt]\n";
}

print "\tDRB1*01:01\tDRB1*03:01\tDRB1*04:01\tDRB1*04:05\tDRB1*07:01\tDRB1*08:02\tDRB1*09:01\tDRB1*11:01\tDRB1*12:01\tDRB1*13:02\tDRB1*15:01\tDRB3*01:01\tDRB3*02:02\tDRB4*01:01\tDRB5*01:01\tDQA1*05:01-DQB1*02:01\tDQA1*05:01-DQB1*03:01\tDQA1*03:01-DQB1*03:02\tDQA1*04:01-DQB1*04:02\tDQA1*01:01-DQB1*05:01\tDQA1*01:02-DQB1*06:02\tDPA1*02:01-DPB1*01:01\tDPA1*01:03-DPB1*02:01\tDPA1*01-DPB1*04:01\tDPA1*03:01-DPB1*04:02\tDPA1*02:01-DPB1*05:01\n";


open(IN,$ARGV[0]) or die "can't open file:$ARGV[0]\n";
my $avg_score=0;
my %seq;
my %hla;
<IN>;
#seq_id aa allele score
#1 H DRB1*01:01 100
my $first = "0";
while(<IN>){
	chomp;
	my ($idx,$res,$h,$percentile)=split;
    if ($first != $idx){
        my $leadingzero = sprintf("%04d", $idx);
        print "\n$leadingzero$res";
        $first = $idx;
    }
    print "\t". 1/$percentile;
}
close IN;
