class Dish < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :description, length: { maximum: 255 }

  belongs_to :event
end

module Descendants
  def self.included(base)
    base.singleton_class.prepend(ClassMethods)
  end

  module ClassMethods
    def courses
      [Soup, Appetizer, MainCourse, Dessert]
    end
  end
end

Dish.include(Descendants)
