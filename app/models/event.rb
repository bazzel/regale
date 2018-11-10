class Event < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :scheduled_at, presence: true

  has_many :guests, dependent: :destroy
  has_many :users, through: :guests
  has_many :courses, inverse_of: :event, dependent: :destroy

  accepts_nested_attributes_for :courses, reject_if: :all_blank, allow_destroy: true

  scope :upcoming, -> { where('scheduled_at > ?', Date.today) }
  scope :for_user, -> (user) { joins(:users).merge(User.where(id: user.id)) }

  def scheduled_at=(value)
    if value.is_a?(String)
      super(Time.zone.parse(value))
    else
      super
    end
  end
end
