class CreateData < ActiveRecord::Migration[5.1]
  def change
    create_table :data do |t|
      t.string :name
      t.text :content
      t.string :data_type

      t.timestamps
    end
  end
end
