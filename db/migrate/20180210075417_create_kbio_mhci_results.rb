class CreateKbioMhciResults < ActiveRecord::Migration[5.1]
  def change
    create_table :kbio_mhci_results do |t|
      t.integer :seq_id
      t.string :aa
      t.string :allele
      t.decimal :score, :precision => 10, :scale => 5
      t.references :result, foreign_key: true

      t.timestamps
    end
  end
end
