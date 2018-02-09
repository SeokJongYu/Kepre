class KbioMhciItem < ApplicationRecord
  TYPE = "KBIO-MHC-I"
  belongs_to :datum
  has_one :tool_item, as: :itemable
  has_one :analysis, through: :tool_item

  def getType
    TYPE
  end

  def getArgs
    "#{percentile_rank}"
  end

  def getPercentileRank
    percentile_rank
  end

end
