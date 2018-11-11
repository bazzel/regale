class Course < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :description, length: { maximum: 255 }

  has_many :dishes, inverse_of: :course, dependent: :destroy
  belongs_to :event, counter_cache: true

  accepts_nested_attributes_for :dishes, reject_if: :all_blank, allow_destroy: true
end
