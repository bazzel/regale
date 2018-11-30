class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || user == record
  end

  def destroy?
    user.admin?
  end

  def permitted_attributes
    attributes = %i(email name)
    attributes << :role if user.admin?
    attributes
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
