require 'rails_helper'

RSpec.describe MhciAnalyserJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(1) }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'executes perform' do
    # expect(MyService).to receive(:call).with(123)
    # perform_enqueued_jobs { job }
  end

  it 'create a directory for saving the input data' do

  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end

end
