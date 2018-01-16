class CreateToolItems < ActiveRecord::Migration[5.1]
  def change
    create_table :tool_items do |t|
      t.references :anlysis, foreign_key: true
      t.references :itemable, polymorphic: true

      t.timestamps
    end
  end
end
