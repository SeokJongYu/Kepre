class MhciItem < ApplicationRecord
  TYPE = "MHC-I"
  belongs_to :datum
  has_one :tool_item, as: :itemable
  has_one :analysis, through: :tool_item
  #attr_accessor :prediction_method, :alleles, :output_sort

  def getType
    TYPE
  end

  def getArgs
    "#{prediction_method} \"#{alleles}\" #{length}"
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
