class Datum < ApplicationRecord
    belongs_to :project
    has_many :analyses
end
