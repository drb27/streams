class TaskPolicy < ApplicationPolicy

  def create?
    return user != nil
  end

  def edit?
    create?
  end

  def update?
    edit?
  end
  
  def destroy?
    return user!=nil
  end

  def complete?
    return user!=nil
  end

end
