require 'rails_helper'

RSpec.describe Analysis do 
    subject {Analysis.new}

    it "is not valid without a name of the analysis" do
        expect(subject).not_to be_valid
    end

    it "should have project and data" do
        project = Project.new()
        project.title = "test Prj"
        project.save()
        d = Datum.new()
        d.name = "testing"
        d.content =">aaa\nacgatctgactgatgctac"
        d.project=project
        d.save()
        subject.project = project
        subject.datum = d
        subject.title = "analysis 1"
        subject.description = "test run"
        expect(subject).to be_valid
    end



end