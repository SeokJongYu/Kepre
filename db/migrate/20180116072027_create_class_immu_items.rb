class CreateClassImmuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :class_immu_items do |t|
      t.string :name
      t.references :datum, foreign_key: true
      t.string :position_mask
      t.string :alleles

      t.timestamps
    end
  end
end
