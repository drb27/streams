class WorkstreamPolicy < ApplicationPolicy
  def fetch?
    user && user.admin?
  end
end
