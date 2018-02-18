class CreateMhciiResults < ActiveRecord::Migration[5.1]
  def change
    create_table :mhcii_results do |t|
      t.string :allele
      t.integer :seq_num
      t.integer :start
      t.integer :end
      t.string :peptide
      t.string :method
      t.decimal :consensus_percentile_rank, :precision => 10, :scale => 5
      t.string :comblib_core
      t.decimal :comblib_score, :precision => 10, :scale => 5
      t.decimal :comblib_rank, :precision => 10, :scale => 5
      t.string :smm_align_core
      t.decimal :smm_align_ic50, :precision => 10, :scale => 5
      t.decimal :smm_align_rank, :precision => 10, :scale => 5
      t.string :nn_align_core
      t.decimal :nn_align_ic50, :precision => 10, :scale => 5
      t.decimal :nn_align_rank, :precision => 10, :scale => 5
      t.string :sturniolo_core
      t.decimal :sturniolo_score, :precision => 10, :scale => 5
      t.decimal :sturniolo_rank, :precision => 10, :scale => 5
      t.references :result, foreign_key: true

      t.timestamps
    end
  end
end
