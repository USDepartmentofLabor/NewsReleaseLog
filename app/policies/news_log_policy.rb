class NewsLogPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def new?
    user.role.admin? || user.role.moderator?
  end

  def create?
    user.role.admin? || user.role.moderator?
  end

  def edit?
    user.role.admin? || user.role.moderator?
  end

  def update?
    user.role.admin? || user.role.moderator?
  end

  def destroy?
    user.role.admin? 
  end
end
