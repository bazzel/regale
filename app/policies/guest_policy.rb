class GuestPolicy < ApplicationPolicy
  def update?
    user == record.user
  end

  def permitted_attributes
    %i(accept_status soup_id appetizer_id main_course_id dessert_id additional_info)
  end

  class Scope < Scope
    def resolve
      scope.for_user(user)
    end
  end
end
