require 'rails_helper'

RSpec.describe Datum do 
    subject {Datum.new}

    it "is not valid without a name of the data" do
        expect(subject).not_to be_valid
    end

    it "is not valid without the context of the data" do
        expect(subject).not_to be_valid
    end

    it "is not valid withoud the project of the data" do
        expect(subject).not_to be_valid
    end

    it "should be valid with name and context of data" do
        subject.content = ">test\nagcgatyctygac"
        subject.name = "testing"
        project = Project.new()
        project.title="prj"
        project.save()
        subject.project = project
        subject.save()
        expect(subject).to be_valid
    end

    it "can check the FASTA type of the data" do
        subject.content = ">test\nagcgatyctygac"
        subject.name = "testing"
        expect(subject.FASTA?).to be_truthy
    end

end
