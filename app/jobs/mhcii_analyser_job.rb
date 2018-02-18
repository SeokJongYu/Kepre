class MhciiAnalyserJob < ApplicationJob
  queue_as :default

  def perform(analysis_id) 
    MhciiWorker.new.exec(analysis_id)
  end

end
