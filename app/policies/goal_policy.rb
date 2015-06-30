class GoalPolicy < ApplicationPolicy

  def create?
    return user && record.workstream && Pundit.policy(user,record.workstream.becomes(Workstream)).modifygoals?
  end

  def edit?
    create?
  end
  
  def destroy?
    return user && record.workstream && Pundit.policy(user,record.workstream.becomes(Workstream)).modifygoals?
  end

  def complete?
    return user && record.workstream && Pundit.policy(user,record.workstream.becomes(Workstream)).modifygoals?
  end

end
