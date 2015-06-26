class WorkstreamPolicy < ApplicationPolicy
  def fetch?
    user && user.admin?
  end

  def modifygoals?
    user
  end

end
