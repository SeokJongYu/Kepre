class MhciiItem < ApplicationRecord
  TYPE = "MHC-II"
  belongs_to :datum
  has_one :tool_item, as: :itemable
  has_one :analysis, through: :tool_item

  def getType
    TYPE
  end

  def getArgs
    "#{prediction_method} \"#{alleles}\""
  end

  def getMethod
    prediction_method
  end

  def getAlleles
    alleles
  end

  def getOutputSort
    output_sort
  end

end
