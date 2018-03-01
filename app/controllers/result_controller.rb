class ResultController < ApplicationController
  def show
    if params[:tool_type] == "MHC-I"
      redirect_to mhci_result_show_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    elsif params[:tool_type] == "KBIO-MHC-I"
      redirect_to kbio_mhci_result_show_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    elsif params[:tool_type] == "KBIO-MHC-II"
      redirect_to kbio_mhcii_result_show_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    end
  end

  def plot
    if params[:tool_type] == "MHC-I"
      redirect_to mhci_result_plot_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    elsif params[:tool_type] == "KBIO-MHC-I"
      redirect_to kbio_mhci_result_plot_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    elsif params[:tool_type] == "KBIO-MHC-II"
      redirect_to kbio_mhcii_result_plot_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    end
  end

  def plot2
    if params[:tool_type] == "MHC-I"
      redirect_to mhci_result_plot_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    elsif params[:tool_type] == "KBIO-MHC-I"
      redirect_to kbio_mhci_result_plot2_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    elsif params[:tool_type] == "KBIO-MHC-II"
      redirect_to kbio_mhcii_result_plot2_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    end
  end

  def report
    if params[:tool_type] == "MHC-I"
      redirect_to mhci_result_report_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    elsif params[:tool_type] == "KBIO-MHC-I"
      redirect_to kbio_mhci_result_report_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    elsif params[:tool_type] == "KBIO-MHC-II"
      redirect_to kbio_mhcii_result_report_path( :result_id => params[:result_id], :analysis_id => params[:analysis_id] )
    end
  end

end
