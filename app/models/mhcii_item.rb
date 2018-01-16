class MhciiItem < ApplicationRecord
  TYPE = "MHC-II"
  belongs_to :datum
  has_one :tool_item, as: :itemable
end
