class AddScoreAndSummaryLocationToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :score, :decimal
    add_column :results, :output2, :string
  end
end
