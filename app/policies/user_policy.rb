class UserPolicy < ApplicationPolicy
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
