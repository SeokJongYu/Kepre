class KbioMhciAnalyserJob < ApplicationJob
  queue_as :default

  def perform(analysis_id) 
    KbioMhciWorker.new.exec(analysis_id, current_user.id)
  end

end
