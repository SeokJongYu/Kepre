class ElliproItem < ApplicationRecord
    TYPE = "ElliPro"
    has_one :tool_item, as: :itemable
end
