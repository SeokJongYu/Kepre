FactoryBot.define do
  factory :mhci_result do
    allele "MyString"
    seq_num 1
    seq_start 1
    seq_end 1
    seq_length 1
    peptide "MyString"
    analysis_method "MyString"
    percentile_rank "9.99"
    ann_ic50 "9.99"
    ann_rank "9.99"
    smm_ic50 "9.99"
    smm_rank "9.99"
    comblib_sidney2008_score "9.99"
    comblib_sidney2008_rank "9.99"
    netmhcpan_ic50 "9.99"
    netmhcpan_rank "9.99"
    result nil
  end
end
