class Analysis < ApplicationRecord
  belongs_to :datum
  belongs_to :project
  has_one :tool_item
  has_one :itemable, through: :tool_item, source_type: "Itemable"
  has_one :result

  validates :title, presence: true
  validates :description, presence: true
  accepts_nested_attributes_for :tool_item, allow_destroy: true


  def check
    (title != nil and description != nil) ? true : false
  end
end
