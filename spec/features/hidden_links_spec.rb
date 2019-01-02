require "rails_helper"

RSpec.feature "Users can only see the appropriate links" do
  let(:user) { FactoryBot.create :user }
  let(:admin) { FactoryBot.create :user, :admin }
  let(:project) { FactoryBot.create :project }
  let(:ticket) { FactoryBot.create :ticket, project: project, author: FactoryBot.create(:user) }
  
  context "anonymous users" do
    scenario "cannot see the New Project link" do
      visit '/'
      expect(page).not_to have_link "New Project"
    end
    
    # scenario "cannot see the Delete Project link" do
    #   visit project_path(project)
    #   expect(page).to_not have_link "Delete Project"
    # end
  end
  
  context "non-admin users (project viewers)" do
    before do
      assign_role!(user, :viewer, project)
      login_as(user)
    end
    
    scenario "cannot see the New Project link" do
      visit '/'
      expect(page).to_not have_link "New Project"
    end
    
    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      expect(page).to_not have_link "Delete Project"
    end
    
    scenario "cann't see the Edit Project link" do
      visit project_path(project)
      expect(page).not_to have_link "Edit Project"
    end
    
    scenario "cannot see the new ticket link" do
      visit project_path(project)
      expect(page).not_to have_link "New Ticket"
    end
    
    scenario "cannot see the Edit ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_link "Edit Ticket"
    end
    
    scenario "cannot see the Delete ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_link "Delete Ticket"
    end
    
    scenario "cannot see New Comment link" do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_heading "New Comment"
    end
  end
  
  context "admin users" do
    before { login_as(admin) }
    
    scenario "can see the New Project link" do
      visit '/'
      expect(page).to have_link "New Project"
    end
    
    scenario "can see the Delete Project link" do
      visit project_path(project)
      expect(page).to have_link "Delete Project"
    end
    
    scenario "can see the Edit Project link" do
      visit project_path(project)
      expect(page).to have_link "Edit Project"
    end
    
    scenario "can see the new ticket link" do
      visit project_path(project)
      expect(page).to have_link "New Ticket"
    end
    
    scenario "can see the Edit ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).to have_link "Edit Ticket"
    end
    
    scenario "can see the Delete ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).to have_link "Edit Ticket"
    end
    
    scenario "can see New Comment link" do
      visit project_ticket_path(project, ticket)
      expect(page).to have_heading "New Comment"
    end
  end
end