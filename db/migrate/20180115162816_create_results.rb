class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_table :results do |t|
      t.string :location
      t.binary :output
      t.references :analysis, foreign_key: true

      t.timestamps
    end
  end
end
