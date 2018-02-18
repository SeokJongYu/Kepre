FactoryBot.define do
  factory :mhcii_result do
    allele "MyString"
    seq_num 1
    seq_start 1
    seq_end 1
    peptide "MyString"
    consensus_percentile_rank "9.99"
    comblib_core "MyString"
    comblib_score "9.99"
    comblib_rank "9.99"
    smm_align_core "MyString"
    smm_align_ic50 "9.99"
    smm_align_rank "9.99"
    nn_align_core "MyString"
    nn_align_ic50 "9.99"
    nn_align_rank "9.99"
    sturniolo_core "MyString"
    sturniolo_score "9.99"
    sturniolo_rank "9.99"
    result nil
  end
end
