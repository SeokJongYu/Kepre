class MhciResult < ApplicationRecord
  belongs_to :result

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |result|
        csv << result.addributes.values_at(*column_names)
      end
    end
  end

end
