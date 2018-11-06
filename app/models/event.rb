class Event < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :scheduled_at, presence: true

  has_many :guests
  has_many :users, through: :guests

  def scheduled_at=(value)
    if value.is_a?(String)
      super(Time.zone.parse(value))
    else
      super
    end
  end
end
