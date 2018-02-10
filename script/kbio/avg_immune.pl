use strict;


if(@ARGV<1){
	die "[].pl [raw_data_*txt]\n";
}
#raw_data_2_GLP-2-hyFc.fasta.txt

#my $raw_data_str = `ls raw_data_*.txt`;
#my @raw_data = split(/\s/,$raw_data_str);

############################
#exit(0) if(@raw_data<1);
#############################	

open(IN,$ARGV[0]) or die "can't open file:$ARGV[0]\n";
my $avg_score=0;
my %seq;
my %hla;
<IN>;
#seq_id aa allele score
#1 H DRB1*01:01 100
while(<IN>){
	chomp;
	my ($idx,$res,$h,$percentile)=split;
	$seq{"$idx$res"}=1;
	$hla{$h}=1;
	$avg_score +=  (100 - $percentile);
}
close IN;

my $seqn=keys %seq;
my $hlan=keys %hla;

$avg_score /= $seqn;
$avg_score = sprintf("%4.2f",$avg_score / $hlan);

print "$ARGV[0] $avg_score\n";	#higher score, higher immunogenicity




