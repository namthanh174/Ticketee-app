require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { CommentPolicy.new(user, comment) }
  
  let(:user) { FactoryBot.create :user }
  let(:project) { FactoryBot.create :project }
  let(:ticket) { FactoryBot.create :ticket, project: project, author: FactoryBot.create(:user) }
  let(:comment) { FactoryBot.create :comment, ticket: ticket, author: FactoryBot.create(:user) }
  
  context "for anonymous users" do
    let(:user) { nil }
    it { should_not permit_action :create }
  end
  
  context "for viewers of project" do
    before { assign_role!(user, :viewer, project) }
    it { should_not permit_action :create }
  end
  
  context "for editors of project" do
    before { assign_role!(user, :editor, project) }
    it { should permit_action :create }
  end
  
  context "for managers of project" do
    before { assign_role!(user, :manager, project) }
    it { should permit_action :create }
  end
  
  context "for managers of other projects" do
    before { assign_role!(user, :manager, FactoryBot.create(:project)) }
    it { should_not permit_action :create }
  end
  
  context "for administrators" do
    let(:user) { FactoryBot.create :user, :admin }
    it { should permit_action :create }
  end
end
