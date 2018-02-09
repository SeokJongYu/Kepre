class CreateKbioMhciiItems < ActiveRecord::Migration[5.1]
  def change
    create_table :kbio_mhcii_items do |t|
      t.string :name
      t.references :datum, foreign_key: true
      t.integer :percentile_rank

      t.timestamps
    end
  end
end
