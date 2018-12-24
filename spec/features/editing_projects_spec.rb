require "rails_helper"

RSpec.feature "Users can edit existing projects" do
  before do
    FactoryBot.create :project, name: "Sublime text 3"
    
    visit '/'
    click_link "Sublime text 3"
    click_link "Edit Project"
  end
  
  scenario "with valid attributes" do
    fill_in "Name", with: "Sublime Text 4 beta"
    click_button "Update Project"
    
    expect(page).to have_content "Project has been updated."
    expect(page).to have_content "Sublime Text 4 beta"
  end
  
  scenario "with invalid attributes" do
    fill_in "Name",with: " "
    click_button "Update Project"
    expect(page).to have_content "Project has not been updated."
  end
end