class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def show?
    user.try(:admin?) || record.project.roles.exists?(user_id: user)
  end
end
