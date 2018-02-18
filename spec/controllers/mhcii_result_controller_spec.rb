require 'rails_helper'

RSpec.describe MhciiResultController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #plot" do
    it "returns http success" do
      get :plot
      expect(response).to have_http_status(:success)
    end
  end

end
