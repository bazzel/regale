class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :event, counter_cache: true
  belongs_to :soup, optional: true
  belongs_to :appetizer, optional: true
  belongs_to :main_course, optional: true
  belongs_to :dessert, optional: true

  scope :upcoming, -> { joins(:event).order('events.scheduled_at').merge(Event.upcoming) }
  scope :for_user, -> (user) { where(user: user) }

  enum accept_status: %i(yes no maybe)

  def accept_status=(value)
    super(value.to_i)
  end
end
