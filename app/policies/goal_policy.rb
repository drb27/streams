class GoalPolicy < ApplicationPolicy

  def create?
    return user && record.workstream && Pundit.policy(user,record.workstream).modifygoals?
  end
end
