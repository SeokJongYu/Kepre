class Datum < ApplicationRecord
    validates :name, presence: true
    validates :content, presence: true
    belongs_to :project
    has_many :analyses

    def FASTA?
        if content.start_with?(">")
            return true
        else
            return false
        end
    end
end
