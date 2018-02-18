use strict;

if(@ARGV<1){
	die "[].pl [raw_data_*txt]\n";
}

print "\tHLA-A*01:01\tHLA-B*07:02\tHLA-A*02:01\tHLA-B*08:01\tHLA-A*02:03\tHLA-B*15:01\tHLA-A*02:06\tHLA-B*35:01\tHLA-A*03:01\tHLA-B*40:01\t";
print "HLA-A*11:01\tHLA-B*44:02\tHLA-A*23:01\tHLA-B*44:03\tHLA-A*24:02\tHLA-B*51:01\tHLA-A*26:01\tHLA-B*53:01\tHLA-A*30:01\tHLA-B*57:01\t";
print "HLA-A*30:02\tHLA-B*58:01\tHLA-A*31:01\tHLA-A*32:01\tHLA-A*33:01\tHLA-A*68:01\tHLA-A*68:02";


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
