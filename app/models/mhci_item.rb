class MhciItem < ApplicationRecord
  belongs_to :data
  belongs_to :tool_item, as: :itemable

end
