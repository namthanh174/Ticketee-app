class AttachmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def show?
    user.try(:admin?) || record.ticket.project.has_member?(user)
  end
end
