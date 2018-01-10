class PbsController < ApplicationController
    before_action :get_batch_server

    def jobs
        #@job_id = @b.submit_script("/home/codegen/Dev/Kepre/public/test.sh")
        @stat = @b.get_job("5.manjaro-codegen")
    end

    def stat 
        @b.get_status
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
