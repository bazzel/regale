class Event < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :scheduled_at, presence: true
  validate :respond_before_must_be_before_scheduled_at

  has_many :guests, dependent: :destroy
  has_many :users, through: :guests
  has_many :dishes, dependent: :destroy

  Dish.courses.each do |d|
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

  def invitation_expired?
    respond_before && (respond_before < Time.current)
  end

  private

  def respond_before_must_be_before_scheduled_at
    return unless respond_before

    errors.add(:respond_before, :invalid_respond_before) if respond_before > scheduled_at
  end
end
