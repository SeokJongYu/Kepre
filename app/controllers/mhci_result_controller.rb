class MhciResultController < ApplicationController
  def show
    @results = MhciResult.where("result_id = ?", params[:result_id])
    @analysis = Analysis.find(params[:analysis_id])
  end

  def plot
    @results = MhciResult.where("result_id = ?", params[:result_id]).limit(50)
    @analysis = Analysis.find(params[:analysis_id])
  end
end
