class PbsController < ApplicationController
    before_action :get_batch_server

    def jobs
        @b.get_status
    end

    def stat 
        @b.get_status
    end

    def qsub
        @job_id = b.submit_script("/path/to/script")

    end

    def qdel
        @b.delete_job(job_id)
    end

    def get_job_info
        2b.get_job(job_id)
    end

    private
    # Create torque batch object for job handling
    def get_batch_server
      @b = PBS::Batch.new(
        host: 'manjaro-codegen',
        lib: '/usr/lib',
        bin: '/usr/bin'
        )
    end
end
