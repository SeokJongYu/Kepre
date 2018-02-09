class KbioMhciiItem < ApplicationRecord
  TYPE = "KBIO-MHC-II"
  belongs_to :datum
  has_one :tool_item, as: :itemable
  has_one :analysis, through: :tool_item

  def getType
    TYPE
  end

  def getArgs
    "#{percentile_rank}"
  end

  def getPercentile
    percentile_rank
  end

end
