class NewsLogPolicy < ApplicationPolicy

  def create?
    user.admin?
  end
end
