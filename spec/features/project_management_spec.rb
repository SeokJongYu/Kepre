require "rails_helper"

RSpec.feature "Project management", :type => :feature do
    scenario "User visit a new project form" do
        visit "/projects"
        expect(page).to have_text("Project board")
        click_link "New Project"
        expect(page).to have_text("New Project")
    end

    scenario "User create a new project" do
        visit "/projects/new"
        expect(page).to have_text("New Project")
        fill_in 'project_title', :with => 'BDD test'
        fill_in 'project_description', :with => 'my BDD description'
        click_button 'Submit'
        expect(page).to have_content('BDD test')
    end

end