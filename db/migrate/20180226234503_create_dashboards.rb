class CreateDashboards < ActiveRecord::Migration[5.1]
  def change
    create_table :dashboards do |t|
      t.integer :project_count
      t.integer :analysis_count
      t.integer :execution_time
      t.decimal :avg_time
      t.integer :total_data
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
