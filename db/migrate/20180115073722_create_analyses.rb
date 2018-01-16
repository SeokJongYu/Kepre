class CreateAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :analyses do |t|
      t.string :title
      t.string :description
      t.references :data, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
