class KbioMhciWorker

  def exec(analysis_id)
    time_start = Time.new
    #if you want get array arguments, just use *args
    # create input file in user's project directory 
    # define the args that is relayed from wicked wizard process
    # it should the analysis id as serialized arguments and placed into the Redis queue
    
    analysis = Analysis.find(analysis_id)
    user = analysis.project.user
    user_id = user.id
    # make input file
    create_data(analysis)
    # make run.sh script
    create_script(analysis)
    # create torque controller and lanch
    lanch_torque_job(analysis)
    # monitoring analysis job and do post processing
    poll_job(analysis)
    post_processing(analysis)

    time_finish = Time.new
    diff = time_finish - time_start
    update_dashboard_info(diff, user_id)
  end

  def create_data(analysis)
    datum = analysis.datum
    project = analysis.project

    @dir_str = "/home/codegen/tmp/kepre/" + project.title.delete(' ')  + "/" + analysis.id.to_s
    @file_str = @dir_str + '/' + datum.name.delete(' ')  
    FileUtils::mkdir_p @dir_str
    File.open(@file_str, "w") {|f| f.write(datum.content)}
  end

  def create_script(analysis)

    tool_item = analysis.tool_item
    mhci_option = KbioMhciItem.find(tool_item.itemable_id)
    
    @script_file = @dir_str + '/run.sh'
    @output_file = @dir_str + '/output.txt'
    @processing_file = @dir_str + '/raw_data.txt'
    @avg_immune_file = @dir_str + '/avg_immune_score.txt'
    @cluster_file = @dir_str + '/kbio_mhci_view.json'
    @cluster_file_summary = @dir_str + '/kbio_mhci_view_summary.json'
    @percentile_rank = mhci_option.getPercentileRank
    begin
      script = File.open(@script_file, "w")
      script.write("#!/bin/sh\n")
      script.write("\n")
      script.write("#PBS -N KBIO-MHC_I\n")
      script.write("#PBS -l nodes=1,walltime=00:20:00\n")
      script.write("#PBS -e #{@dir_str}/job_error.out\n")
      script.write("#PBS -o #{@dir_str}/job_output.out\n")
      script.write("#PBS -q batch\n")
      script.write("\n")
      script.write("cd #{@dir_str} \n")
      script.write("/usr/local/IEDB/mhc_i/src/predict_binding.py IEDB_recommended \"HLA-A*01:01,HLA-B*07:02,HLA-A*02:01,HLA-B*08:01,HLA-A*02:03,HLA-B*15:01,HLA-A*02:06,HLA-B*35:01,HLA-A*03:01,HLA-B*40:01,HLA-A*11:01,HLA-B*44:02,HLA-A*23:01,HLA-B*44:03,HLA-A*24:02,HLA-B*51:01,HLA-A*26:01,HLA-B*53:01,HLA-A*30:01,HLA-B*57:01,HLA-A*30:02,HLA-B*58:01,HLA-A*31:01,HLA-A*32:01,HLA-A*33:01,HLA-A*68:01,HLA-A*68:02\" \"9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9\" #{@file_str} > output.txt\n")
      #paring output data
      script.write("perl /usr/local/IEDB/KBIO/mk_mhc_i_pred_mat.pl -fasta #{@file_str} -HLA_file /usr/local/IEDB/KBIO/allele27.list -curl_out #{@output_file} -percentile_rank #{@percentile_rank} > #{@processing_file} 2> err2.txt\n")

      script.write("perl /usr/local/IEDB/KBIO/avg_immune.pl #{@processing_file} > #{@avg_immune_file}\n")

      script.write("perl /usr/local/IEDB/KBIO/create_matrix.pl #{@processing_file} > mat.txt\n")
      script.write("perl /usr/local/IEDB/KBIO/create_summary_matrix_i.pl #{@processing_file} > mat2.txt\n")
      script.write("python /usr/local/IEDB/KBIO/create_clustergrammer.py \n")

    rescue IOError => e 
    ensure
      script.close unless script.nil?
    end
  end


  def lanch_torque_job(analysis)
    @b = PBS::Batch.new(
      host: 'manjaro-codegen',
      lib: '/usr/lib',
      bin: '/usr/bin'
      )
    @job_id = @b.submit_script(@script_file)

    analysis.job_id = @job_id
    analysis.status = "submit"
    analysis.save
  end

  def poll_job(analysis)
    job_id = analysis.job_id
    status = analysis.status
    stat_server = "submit"
    until stat_server == "Done"  do
      @stat = @b.get_job(job_id)
      #puts @stat.to_yaml
      # puts ">>>>>"
      #puts job_id
      @stat.each_key {|key| puts key }
      val = @stat[job_id]
      stat_str = val[:job_state]
      if stat_str == "Q" 
        stat_server = "Queue"
      elsif stat_str == "R"
        stat_server = "Running"
      elsif stat_str == "C"
        stat_server = "Done"
      end

      if stat_server != status
        analysis.status = stat_server
        analysis.save
        sleep 10
      end
      
    end
  end

  def post_processing(analysis)
    analysis.status = "Post processing"
    analysis.save
    
    # create Result
    result = Result.new()
    result.location = @output_file
    result.output = @cluster_file
    result.output2 = @cluster_file_summary;
    result.analysis = analysis

    puts "post processing"
    puts @output_file
    puts @processing_file
    puts @percentile_rank
    puts @avg_immune_file

    avg_data = File.readlines(@avg_immune_file)
    avg_value = avg_data[0].strip.split(" ")
    result.score = avg_value[1]
    result.save

    csv_text = File.read(@output_file)
    csv = CSV.parse(csv_text, :col_sep =>"\t", :headers => true, :converters => lambda { |s| s.tr("-","") })
    csv.each do |row|
      if row['percentile_rank'].to_f < @percentile_rank.to_f
        #puts row.to_hash
        mhc_result = MhciResult.create(row.to_hash)
        mhc_result.result = result
        mhc_result.save
      end
    
    end

    csv_text2 = File.read(@processing_file)
    csv_prog = CSV.parse(csv_text2, :col_sep =>" ", :headers => true)
    csv_prog.each do |row2|
      #puts row2.to_hash
      kbio_mhc_result = KbioMhciResult.create(row2.to_hash)
      kbio_mhc_result.result = result
      kbio_mhc_result.save
    
    end

    analysis.status = "Finish"
    analysis.save
    
  end

  def update_dashboard_info(time, user_id)
    current_user = User.find(user_id)
    dashboard = current_user.dashboard
    curr_data = dashboard.execution_time
    analysis_num = dashboard.analysis_count + 1
    dashboard.analysis_count = analysis_num 
    dashboard.execution_time = curr_data + time
    dashboard.avg_time = (curr_data + time) / analysis_num
    dashboard.save
  end

end