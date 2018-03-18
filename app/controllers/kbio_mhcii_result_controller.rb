class KbioMhciiResultController < ApplicationController
  def show
    @results = MhciiResult.where("result_id = ?", params[:result_id])
    @analysis = Analysis.find(params[:analysis_id])

    respond_to do |format|
      format.html
      format.csv { send_data @results.to_csv}
      format.xls #{ send_data @results.to_csv(col_sep: "\t")}
    end

  end

  def summary
    @results = KbioMhciiResult.where("result_id = ?", params[:result_id])
    @analysis = Analysis.find(params[:analysis_id])
  end

  def plot
    @results = Result.find_by_id(params[:result_id])
    @json = read_file(@results.output)
    @analysis = Analysis.find(params[:analysis_id])
  end

  def plot2
    @results = Result.find_by_id(params[:result_id])
    @json = read_file(@results.output2)
    @analysis = Analysis.find(params[:analysis_id])
  end


  def report
    @rawdata = KbioMhciiResult.where("result_id = ? and score < 1", params[:result_id]).order(score: :asc, allele: :desc)
    #@rawdata = MhciResult.where("result_id = ? and percentile_rank < 0.5", params[:result_id]).order(percentile_rank: :asc).distinct
    @results = Result.find_by_id(params[:result_id])
    #@json = read_file(@results.output)
    @analysis = Analysis.find(params[:analysis_id])
    @seq = @analysis.datum

    pdf = ReportPdf.new(@analysis, @rawdata, @seq, "MHC II")
    send_data pdf.render, filename: "analysis_report.pdf", type: "application/pdf" , disposition: "inline"
  end

  def read_file(file_name)
    file = File.open(file_name, "r")
    data = file.read
    file.close
    return data
  end

end
