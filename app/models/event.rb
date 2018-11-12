class Event < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :scheduled_at, presence: true

  has_many :guests, dependent: :destroy
  has_many :users, through: :guests

  has_many :dishes, dependent: :destroy
  has_many :soups, dependent: :destroy
  has_many :appetizers, dependent: :destroy
  has_many :main_courses, dependent: :destroy
  has_many :desserts, dependent: :destroy

  accepts_nested_attributes_for :soups, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :appetizers, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :main_courses, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :desserts, reject_if: :all_blank, allow_destroy: true

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
