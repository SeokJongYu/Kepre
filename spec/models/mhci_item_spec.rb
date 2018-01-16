require 'rails_helper'

RSpec.describe MhciItem do 
    subject {MhciItem.new}

    it "is not valid when tool_item is not assigned" do
        expect(subject).not_to be_valid
    end

    it "should have a TYPE of the tool" do
        expect(subject{:TYPE}) == "MHC-I"
    end

    it "belongs to data for the analysis" do
        datum = Datum.new()
        datum.content =">test\nagcgatyctygac"
        datum.name = "testing"
        project = Project.new()
        project.title="prj"
        datum.project = project
        subject.datum = datum

        expect(subject).to be_valid
        
    end
    
end