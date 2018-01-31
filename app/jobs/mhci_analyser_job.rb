class MhciAnalyserJob < ApplicationJob
  queue_as :default

  def perform(analysis_id) 
    MhciWorker.new.exec(analysis_id)
  end

end
