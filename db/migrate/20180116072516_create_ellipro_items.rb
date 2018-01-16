class CreateElliproItems < ActiveRecord::Migration[5.1]
  def change
    create_table :ellipro_items do |t|
      t.string :name
      t.string :pdb
      t.string :min
      t.string :max

      t.timestamps
    end
  end
end
