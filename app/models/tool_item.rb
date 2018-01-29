class ToolItem < ApplicationRecord
  belongs_to :analysis
  belongs_to :itemable, polymorphic: true

  def getToolType
    self.itemable_type
  end

end
