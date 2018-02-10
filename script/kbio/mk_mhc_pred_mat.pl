#!/usr/bin/perl

use strict;
use File::Basename;
use Getopt::Long;
use Data::Dumper;

# Description:
# wrapper for running Patchdock

my $usage = "Usage: $0 -fasta <input fasta file> -HLA_file <HLA list file> -curl_out <mhc pred curl output file> -percentile_rank <percentile_rank_cutoff : 20 default> -use_core_seq\n";

# --- TASFLIGAMSVESEDGIGLYRTVTGISL 
#allele  seq_num start   end peptide method  percentile_rank comblib_core    comblib_score   comblib_rank    smm_align_core  smm_align_ic50  smm_align_rank  nn_align_core   nn_align_ic50   nn_align_rank   netmhciipan_core    netmhciipan_ic50    netmhciipan_rank    sturniolo_core  sturniolo_score sturniolo_rank
#HLA-DRB1*07:01  1   14  28  EDGIGLYRTVTGISL Consensus (comb.lib./smm/nn)    0.20    YRTVTGISL   0.01    0.01    LYRTVTGIS   30  0.20    YRTVTGISL   5.20    0.53    -   -   -   -   -   -
#HLA-DRB5*01:01  1   14  28  EDGIGLYRTVTGISL Consensus (smm/nn/sturniolo)    2.74    -   -   -   LYRTVTGIS   329 2.74    YRTVTGISL   802.50  39.83   -   -   -   YRTVTGISL   5.50    0.07

# ---- Special Arguments ----
my %args=();
GetOptions("fasta:s"=>\$args{fasta},
				   "percentile_rank:s"=>\$args{percentile_rank},
				   "HLA_file:s"=>\$args{HLA_file},
				   "use_core_seq:s"=>\$args{use_core_seq},
				   "curl_out:s"=>\$args{curl_out});

my $fasta = $args{fasta} or die $usage;
my $out = $args{curl_out} or die $usage;
my $HLA = $args{HLA_file} or die $usage;
my $percentile_rank_cut = $args{percentile_rank} || 20.0;  # 

# -- input ----------
my $seq='';
open(IN,$fasta) or die "can't open file:$_\n";
while(<IN>){
	chomp;
	next if(/^$/);
	next if(/^>/);
	$seq .= $_;
}
close IN;
my @HLA_list;
open(IN,$HLA) or die "can't open file:$HLA\n";
while(<IN>){
	chomp;
	next if(/^$/);
	my $allele=$_;
	$allele=~s/\-/\//;		# for,  HLA-DQA1*04:01/DQB1*04:02		
	push @HLA_list,$allele;
}
close IN;
# -----------------


my %Res_Score;
my %Res_Core_Score;

my %aa_idx;
open(IN,$out) or die "can't open file:$out\n";
my @heads;
while(<IN>){
	chomp;
	next if(/^$/);
	if(/^allele/){
		@heads = split(/\t/,$_);
		next;
	}
	my %feat;
	my ($allele,$seq_num,$start,$end,$peptide,$method,$percentile,@tmp) = split(/\t/,$_);
	$allele=~s/^HLA-//;
	my @ele = split(/\t/,$_);
	for(my $i=0;$i<@ele;$i++){
		$feat{$heads[$i]}=$ele[$i];
	}
	
	my $core_seq;
	if($feat{nn_align_core}=~/[ACDEFGHIKLMNPQRSTVWY]/){
		$core_seq = $feat{nn_align_core};
	}elsif($feat{smm_align_core}=~/[ACDEFGHIKLMNPQRSTVWY]/){
		$core_seq = $feat{smm_align_core};
	}elsif($feat{comblib_core}=~/[ACDEFGHIKLMNPQRSTVWY]/){
		$core_seq = $feat{comblib_align_core};
	}elsif($feat{netmhciipan_core}=~/[ACDEFGHIKLMNPQRSTVWY]/){
		$core_seq = $feat{netmhciipan_core};
	}
	die "CORE SEQUENCE CANNOT BE DEFINED ($core_seq)\n-->$_" if(not defined $core_seq);
	my $pos = index($seq, $core_seq);	# pos 0-idx

	my $len=$end-$start+1;
	my $subs=substr($seq,$start-1,$len);	# start 1-idx 
	if($percentile <= $percentile_rank_cut ){
		
		for(my $i=$start-1;$i<$end;$i++){		# Res_Score 0-idx
			$aa_idx{$i}=1;
			if(defined $Res_Score{$i}{$allele}{score}){
				if($Res_Score{$i}{$allele}{score} > $percentile){
					$Res_Score{$i}{$allele}{score}=$percentile;
					$Res_Score{$i}{$allele}{aa}=substr($seq,$i,1);
					$Res_Score{$i}{$allele}{core}=$core_seq;
				}
			}else{
				$Res_Score{$i}{$allele}{score}=$percentile;
				$Res_Score{$i}{$allele}{aa}=substr($seq,$i,1);
				$Res_Score{$i}{$allele}{core}=$core_seq;
			}
		}

		#print "core seq ",length($core_seq),"\n";
		for(my $i=$pos; $i < $pos+length($core_seq); $i++){	# pos already 0-idx
			if(defined $Res_Core_Score{$i}{$allele}{score}){
					if($Res_Core_Score{$i}{$allele}{score} > $percentile){
						$Res_Core_Score{$i}{$allele}{score}=$percentile;
						$Res_Core_Score{$i}{$allele}{aa}=substr($seq,$i,1);
						$Res_Core_Score{$i}{$allele}{core}=$core_seq;
					}	
			}else{
				$Res_Core_Score{$i}{$allele}{score}=$percentile;
				$Res_Core_Score{$i}{$allele}{aa}=substr($seq,$i,1);
				$Res_Core_Score{$i}{$allele}{core}=$core_seq;
			}
		}
	
	}
}
close IN;

#print Dumper \%Res_Score;

#---- HEADER --------------------
print "seq_id aa allele score\n";
#--------------------------------

my @idx_ary = sort {$a<=>$b} keys %aa_idx;
my $max_idx_ary = $idx_ary[-1];


if(defined  $args{use_core_seq}){
	for(my $i=0;$i<=$max_idx_ary;$i++){
	#for my $i (sort {$a<=>$b} keys %aa_idx){	# 0-idx
		for my $hla (@HLA_list){
			my $aa=substr($seq,$i,1);
			my $score = 100 ; #percentile?
				if(defined $Res_Core_Score{$i}{$hla}){
					$score =  $Res_Core_Score{$i}{$hla}{score} if(defined $Res_Core_Score{$i}{$hla}{score});
				}
			print $i+1," $aa $hla $score\n";
		}	
	}

}else{

	for(my $i=0;$i<=$max_idx_ary;$i++){
	#for my $i (sort {$a<=>$b} keys %aa_idx){
		for my $hla (@HLA_list){
			my $aa=substr($seq,$i,1);
			my $score = 100 ; #percentile?
				if(defined $Res_Score{$i}{$hla}){
					$score =  $Res_Score{$i}{$hla}{score} if(defined $Res_Score{$i}{$hla}{score});
				}
			print $i+1," $aa $hla $score\n";
		}	
	}

}
