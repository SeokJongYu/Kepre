require 'rails_helper'

RSpec.describe ToolItem do 
    subject {ToolItem.new}

    it "is not valid for emty analysis" do
        subject.analysis = nil

        expect(subject).not_to be_valid

    end

    it "is valid when analysis and item are defined" do

        analysis = Analysis.new()
        project = Project.new()
        project.title = "test Prj"
        project.save()
        d = Datum.new()
        d.name = "testing"
        d.content =">aaa\nacgatctgactgatgctac"
        d.project=project
        d.save()
        analysis.project = project
        analysis.datum = d
        analysis.title = "analysis 1"
        analysis.description = "test run"

        subject.analysis = analysis
        
        mhci = MhciItem.new()
        mhci.datum =d
        subject.itemable = mhci

        expect(subject).to be_valid
        expect(subject.itemable).to be(mhci)
        expect(subject.analysis).to be(analysis)
    end

end