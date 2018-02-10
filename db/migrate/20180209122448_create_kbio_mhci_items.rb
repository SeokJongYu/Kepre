class CreateKbioMhciItems < ActiveRecord::Migration[5.1]
  def change
    create_table :kbio_mhci_items do |t|
      t.string :name
      t.references :datum, foreign_key: true
      t.integer :percentile_rank, :precision => 3, :scale => 5

      t.timestamps
    end
  end
end
