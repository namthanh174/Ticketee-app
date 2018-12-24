require "rails_helper"

RSpec.feature "Users can delete projects" do
  scenario "successfully" do
    FactoryBot.create :project, name: "Sublime text 3"
    
    visit '/'
    click_link "Sublime text 3"
    click_link "Delete Project"
    
    expect(page).to have_content "Project has been deleted."
    expect(page.current_url).to eq projects_url
    expect(page).to have_no_content "Sublime text 3" 
  end
end