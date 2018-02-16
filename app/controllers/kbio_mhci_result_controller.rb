class KbioMhciResultController < ApplicationController
  def show
    @results = KbioMhciResult.where("result_id = ?", params[:result_id])
    @analysis = Analysis.find(params[:analysis_id])
  end

  def plot
    @results = Result.find_by_id(params[:result_id])
    @json = read_file(@results.output)
    @analysis = Analysis.find(params[:analysis_id])
  end

  def read_file(file_name)
    file = File.open(file_name, "r")
    data = file.read
    file.close
    return data
  end

end
