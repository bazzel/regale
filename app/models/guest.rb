class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :event, counter_cache: true

  scope :upcoming, -> { joins(:event).merge(Event.upcoming) }
  scope :for_user, -> (user) { where(user: user) }

  enum accept_status: %i(yes no maybe)

  def accept_status=(value)
    super(value.to_i)
  end
end
