class DiscoTopeItem < ApplicationRecord
    TYPE = "DiscoTope"
    has_one :tool_item, as: :itemable
end
