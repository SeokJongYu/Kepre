class Analysis < ApplicationRecord
  belongs_to :data
  belongs_to :project
  has_one :tool_item
  has_many :result
  
end
