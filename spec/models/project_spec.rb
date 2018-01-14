require 'rails_helper'

RSpec.describe Project do 
    subject {Project.new}

    it "is not valid without a name of the project" do 
        expect(subject).not_to be_valid
    end

    it "is not valid with a title longer than 100 characters" do 
        subject.title ='a' *101
        expect(subject).not_to be_valid
    end

    it "is valid with proper title less than 100 characters" do 
        subject.title = 'a'*90
        expect(subject).to be_valid
    end

end
