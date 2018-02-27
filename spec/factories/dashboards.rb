FactoryBot.define do
  factory :dashboard do
    project_count 1
    analysis_count 1
    execution_time 1
    avg_time "9.99"
    total_data 1
    user nil
  end
end
