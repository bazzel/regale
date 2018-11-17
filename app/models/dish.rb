class Dish < ApplicationRecord
  include Courses

  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :description, length: { maximum: 255 }

  belongs_to :event
end

