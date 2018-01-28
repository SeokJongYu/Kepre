class MhciItem < ApplicationRecord
  TYPE = "MHC-I"
  belongs_to :datum
  has_one :tool_item, as: :itemable

  def getType
    TYPE
  end

end
