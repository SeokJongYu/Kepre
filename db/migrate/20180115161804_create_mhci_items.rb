class CreateMhciItems < ActiveRecord::Migration[5.1]
  def change
    create_table :mhci_items do |t|
      t.string :name
      t.references :datum, foreign_key: true
      t.string :prediction_method
      t.string :species
      t.string :alleles
      t.integer :length
      t.string :output_sort
      t.string :output_format

      t.timestamps
    end
  end
end
