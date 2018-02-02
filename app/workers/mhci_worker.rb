class MhciWorker
  require 'fileutils'
  require 'csv'

  def exec(analysis_id)
    #if you want get array arguments, just use *args
    # create input file in user's project directory 
    # define the args that is relayed from wicked wizard process
    # it should the analysis id as serialized arguments and placed into the Redis queue
    
    analysis = Analysis.find(analysis_id)
    # make input file
    create_data(analysis)
    # make run.sh script
    create_script(analysis)
    # create torque controller and lanch
    lanch_torque_job(analysis)
    # monitoring analysis job and do post processing
    #TODO poll_job(analysis)
    sleep 120
    post_processing(analysis)

  end

  def create_data(analysis)
    datum = analysis.datum
    project = analysis.project

    @dir_str = "/tmp/kepre/" + project.title + "/" + analysis.id.to_s
    @file_str = @dir_str + '/' + datum.name 
    FileUtils::mkdir_p @dir_str
    File.open(@file_str, "w") {|f| f.write(datum.content)}
  end

  def create_script(analysis)

    tool_item = analysis.tool_item
    mhci_option = MhciItem.find(tool_item.itemable_id)
    
    @script_file = @dir_str + '/run.sh'
    @output_file = @dir_str + '/output.txt'

    begin
      script = File.open(@script_file, "w")
      script.write("#!/bin/sh\n")
      script.write("\n")
      script.write("#PBS -N Kepre-MHC_I\n")
      script.write("#PBS -l nodes=1,walltime=00:01:00\n")
      script.write("#PBS -q batch\n")
      script.write("\n")
      script.write("cd #{@dir_str} \n")
      script.write("/usr/local/IEDB/mhc_i/src/predict_binding.py #{mhci_option.getArgs} #{@file_str} > output.txt\n")

    rescue IOError => e 
    ensure
      script.close unless script.nil?
    end
  end


  def lanch_torque_job(analysis)
    # @b = PBS::Batch.new(
    #   host: 'manjaro-codegen',
    #   lib: '/usr/lib',
    #   bin: '/usr/bin'
    #   )
    # @job_id = @b.submit_script(@script_file)

    # analysis.job_id = @job_id
    analysis.job_id = "1"
    analysis.status = "submit"
    analysis.save
  end

  def poll_job(analysis)
    job_id = analysis.job_id
    status = analysis.status
    until status == "done"  do
      @stat = @b.get_job(job_id)
      if (@stat != status) then
        analysis.status = @stat
        analysis.save
        sleep 10
      end
    end
  end

  def post_processing(analysis)
    # create Result
    result = Result.new()
    result.location = @output_file
    result.analysis = analysis
    result.save

    csv_text = File.read(@output_file)
    csv = CSV.parse(csv_text, :col_sep =>"\t", :headers => true, :converters => lambda { |s| s.tr("-","") })
    csv.each do |row|
      puts row.to_hash
      mhc_result = MhciResult.create(row.to_hash)
      mhc_result.result = result
      mhc_result.save
    
    end
    
  end

end