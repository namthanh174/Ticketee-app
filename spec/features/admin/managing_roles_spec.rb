require "rails_helper"

RSpec.feature "Admins can manage a users roles" do
  let(:admin) { FactoryBot.create :user, :admin }
  let(:user) { FactoryBot.create :user }
  let!(:ie) { FactoryBot.create :project, name: "Internet Explorer" }
  let!(:st3) { FactoryBot.create :project, name: "Sublime text 3" }
  
  before { login_as(admin) }
  
  scenario "when assigning roles to an existing user" do
    visit admin_user_path(user)
    click_link "Edit User"
    
    select "Viewer", from: "Internet Explorer"
    select "Manager", from: "Sublime text 3"
    
    click_button "Update User"
    expect(page).to have_content "User has been updated"
    
    click_link user.email
    expect(page).to have_content "Internet Explorer: Viewer"
    expect(page).to have_content "Sublime text 3: Manager"
  end
end