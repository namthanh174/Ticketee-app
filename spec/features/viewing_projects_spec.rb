require "rails_helper"

RSpec.feature "Users can view projects" do
  let(:user) { FactoryBot.create :user }
  
  before do
    login_as(user)
  end
  
  scenario "with the project details" do
    project = FactoryBot.create :project, name: "Sublime text 3"
    assign_role!(user, :viewer, project)
    
    visit '/'
    click_link "Sublime text 3"
    expect(page.current_url).to eq project_url(project) 
  end
end