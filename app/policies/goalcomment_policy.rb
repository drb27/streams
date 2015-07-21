class GoalcommentPolicy < ApplicationPolicy

  def create?
    return user
  end

end
