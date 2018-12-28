class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  scope :excluding_archived, lambda { where(archived_at: nil) }
  has_many :roles
  
  def archive
    self.update(archived_at: Time.now)
  end
  
  def active_for_authentication?
    super && archived_at.nil?
  end
  
  def inactive_message
    archived_at.nil? ? super : :archived   
  end
  
  def role_on(project)
    roles.find_by(project_id: project).try(:name)
  end
  
  def to_s
    "#{email} (#{ admin? ? 'Admin' : 'User'})"
  end
end
