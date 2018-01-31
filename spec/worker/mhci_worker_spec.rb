require 'rails_helper'


RSpec.describe "MhciWorker" do
    subject {MhciWorker.new}

    let(:input) {'/tmp/kepre/testPrj/1/testing'}
    it "create the working directory and save the data file" do
        project = Project.new()
        project.title = "testPrj"
        project.save()
        d = Datum.new()
        d.name = "testing"
        d.content =">aaa\nacgatctgactgatgctac"
        d.project=project
        d.save()

        analysis = Analysis.new()
        analysis.project = project
        analysis.datum = d
        analysis.title = "analysis 1"
        analysis.description = "test run"
        item_obj = MhciItem.new()
        item_obj.prediction_method ="IEDB_recommended"
        item_obj.alleles = "HLA-A*02:01"
        tool_item = ToolItem.new()
        tool_item.itemable = item_obj
        item_obj.tool_item = tool_item
        analysis.tool_item = tool_item
        tool_item.save
        item_obj.save
        analysis.save

        subject.exec(analysis.id)

    end
end
