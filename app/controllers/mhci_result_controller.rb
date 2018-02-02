class MhciResultController < ApplicationController
  def show
    @results = MhciResult.where("result_id = ?", params[:result_id])
    @analysis = Analysis.find(params[:analysis_id])
  end

  def plot
  end
end
