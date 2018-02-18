class MhciiResultController < ApplicationController
  def show
    @results = MhciiResult.where("result_id = ?", params[:result_id])
    @analysis = Analysis.find(params[:analysis_id])
  end

  def plot
    @results = MhciiResult.where("result_id = ?", params[:result_id]).limit(50)
    @analysis = Analysis.find(params[:analysis_id])
  end
end
