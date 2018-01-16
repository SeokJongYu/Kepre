class BcellAntibodyItem < ApplicationRecord
  TYPE = "Antibody_Epitope"
  belongs_to :datum
  has_one :tool_item, as: :itemable
end
