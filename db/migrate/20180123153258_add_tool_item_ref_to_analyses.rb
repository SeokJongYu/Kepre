class AddToolItemRefToAnalyses < ActiveRecord::Migration[5.1]
  def change
    add_reference :analyses, :tool_item, foreign_key: true
  end
end
