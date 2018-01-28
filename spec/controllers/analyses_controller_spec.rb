require 'rails_helper'

RSpec.describe AnalysesController, type: :controller do
    describe "GET #index" do

        subject {get :index}

        it "responds successfully with an HTTP 200 status code" do
            subject
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end

        it "create analyses with project and datum " do
            
        end
    end
end
