class MailToPolicy < ApplicationPolicy
  def menu_choices?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
