class Dish < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :description, length: { maximum: 255 }

  belongs_to :course, counter_cache: true
end
