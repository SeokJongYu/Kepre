require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

    describe "GET #index" do

        subject {get :index}

        it "responds successfully with an HTTP 200 status code" do
            subject
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end

        it "renders the index template" do
            subject
            expect(response).to render_template("index")
        end

        it "should have project contents" do
            project1, project2 = Project.create!(title: "test1"), Project.create!(title: "test2")
            subject
            expect(assigns(:projects)).to match_array([project1, project2])
        end
    end

    describe "PUT update/:id" do
          
        #let(:attr) do 
        #    { :title => 'new title', :description => 'new content' }
        #end
        #
        #before(:each) do
        #    @project = Factory(:project)
        #    put :update, :id => @project.id, :project => attr
        #    @project.reload
        #end
        #it "responds successfully and redirect to the project" do
        #    expect(response).to be_success
        #    expect(response).to redirect_to(@project)
        #end
    end

end
