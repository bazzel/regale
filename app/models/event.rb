class Event < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :scheduled_at, presence: true

  has_many :guests, -> { order(:accept_status) }, dependent: :destroy
  has_many :users, through: :guests

  has_many :dishes, dependent: :destroy

  Dish.descendants.each do |d|
    name = d.model_name.plural.to_sym
    has_many name, dependent: :destroy
    accepts_nested_attributes_for name, reject_if: :all_blank, allow_destroy: true
  end

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
