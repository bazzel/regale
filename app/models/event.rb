class Event < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :scheduled_at, presence: true

  def scheduled_at=(value)
    #byebug
    if value.is_a?(String)
      super(Time.zone.parse(value))
    else
      super
    end
  end
end
