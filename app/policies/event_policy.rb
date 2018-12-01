class EventPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def permitted_attributes
    [:title,
     :scheduled_at,
     :respond_before,
     :location,
     :additional_info,
     user_ids: [],
     soups_attributes: [:id, :title, :description, :vegetarian, :_destroy],
     appetizers_attributes: [:id, :title, :description, :vegetarian, :_destroy],
     main_courses_attributes: [:id, :title, :description, :vegetarian, :_destroy],
     desserts_attributes: [:id, :title, :description, :_destroy]]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
