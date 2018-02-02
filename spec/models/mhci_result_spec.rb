require 'rails_helper'
require 'csv'

RSpec.describe MhciResult, type: :model do
  it "can save the result file with csv module" do
    @output_file = "/tmp/kepre/test/5/output.txt"
    result = Result.new()
    result.location = @output_file
    result.save

    csv_text = File.read(@output_file)
    csv = CSV.parse(csv_text, :col_sep =>"\t", :headers => true, :converters => lambda { |s| s.tr("-","") })
    csv.each do |row|
      puts row.to_hash
      mhc_result = MhciResult.create(row.to_hash)
      mhc_result.result = result
      mhc_result.save
    end
    puts MhciResult.count
    puts MhciResult.first.allele
    # expect (MhciResult.count).to be > 100

  end

end
