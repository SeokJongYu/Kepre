class CreateMhciResults < ActiveRecord::Migration[5.1]
  def change
    create_table :mhci_results do |t|
      t.string :allele
      t.integer :seq_num
      t.integer :start
      t.integer :end
      t.integer :length
      t.string :peptide
      t.string :method
      t.decimal :percentile_rank, :precision => 10, :scale => 5
      t.decimal :ann_ic50, :precision => 10, :scale => 5
      t.decimal :ann_rank, :precision => 10, :scale => 5
      t.decimal :smm_ic50, :precision => 10, :scale => 5
      t.decimal :smm_rank, :precision => 10, :scale => 5
      t.decimal :comblib_sidney2008_score, :precision => 10, :scale => 5
      t.decimal :comblib_sidney2008_rank, :precision => 10, :scale => 5
      t.decimal :netmhcpan_ic50, :precision => 10, :scale => 5
      t.decimal :netmhcpan_rank, :precision => 10, :scale => 5
      t.references :result, foreign_key: true

      t.timestamps
    end
  end
end
