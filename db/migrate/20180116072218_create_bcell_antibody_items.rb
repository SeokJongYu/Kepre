class CreateBcellAntibodyItems < ActiveRecord::Migration[5.1]
  def change
    create_table :bcell_antibody_items do |t|
      t.string :name
      t.string :swiss
      t.references :datum, foreign_key: true
      t.string :prediction_method

      t.timestamps
    end
  end
end
