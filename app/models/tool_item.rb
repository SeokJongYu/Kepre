class ToolItem < ApplicationRecord
  belongs_to :anlysis
  belongs_to :itemable, polymorphic: true
end
