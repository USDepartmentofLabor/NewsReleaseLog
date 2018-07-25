class RegionPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.role.admin?
  end

  def edit?
    user.role.admin?
  end

  def update?
    user.role.admin?
  end

  def destroy?
    user.role.admin?
  end
end
