class AddProjectIdToData < ActiveRecord::Migration[5.1]
  def change
    add_column :data, :project_id, :integer
    add_index :data, :project_id
  end
end
