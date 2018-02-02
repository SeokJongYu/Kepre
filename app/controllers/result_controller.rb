class ResultController < ApplicationController
  def show
    if params[:tool_type] == "MHC-I"
      redirect_to mhci_result_show_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    end
  end

  def plot
  end
end
