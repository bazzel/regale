class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :event, counter_cache: true
  Dish.descendants.each do |d|
    name = d.model_name.singular.to_sym
    belongs_to name, optional: true
  end

  scope :upcoming, -> { joins(:event).order('events.scheduled_at').merge(Event.upcoming) }
  scope :for_user, -> (user) { where(user: user) }

  enum accept_status: %i(yes no maybe)

  def accept_status=(value)
    super(value.to_i)
  end
end
