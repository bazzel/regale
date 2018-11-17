require 'active_support/concern'

module Courses
  extend ActiveSupport::Concern
  class_methods do
    def courses
      [Soup, Appetizer, MainCourse, Dessert]
    end
  end
end

