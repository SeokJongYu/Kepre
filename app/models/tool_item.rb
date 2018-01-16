class ToolItem < ApplicationRecord
  belongs_to :analysis
  belongs_to :itemable, polymorphic: true

end
