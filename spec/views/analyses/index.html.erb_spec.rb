require 'rails_helper'

RSpec.describe "analyses/index", type: :view do
  before(:each) do
    assign(:analyses, [
      Analysis.create!(),
      Analysis.create!()
    ])
  end

  it "renders a list of analyses" do
    render
  end
end
