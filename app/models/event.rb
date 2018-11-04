class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :scheduled_at, presence: true
end
