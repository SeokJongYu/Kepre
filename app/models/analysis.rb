class Analysis < ApplicationRecord
  belongs_to :datum
  belongs_to :project
  has_one :tool_item
  has_many :result

  validates :title, presence: true
  
end
