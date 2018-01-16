class ClassImmuItem < ApplicationRecord
  TYPE = "Class-I_Immunogenicity"
  belongs_to :datum
  has_one :tool_item, as: :itemable
end
