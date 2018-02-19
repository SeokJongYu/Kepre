class KbioMhciiAnalyserJob < ApplicationJob
  queue_as :default

  def perform(analysis_id) 
    KbioMhciiWorker.new.exec(analysis_id)
  end

end
