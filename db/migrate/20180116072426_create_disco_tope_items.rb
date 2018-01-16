class CreateDiscoTopeItems < ActiveRecord::Migration[5.1]
  def change
    create_table :disco_tope_items do |t|
      t.string :name
      t.string :pdb
      t.string :chain
      t.string :version

      t.timestamps
    end
  end
end
