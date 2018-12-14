class Event < ApplicationRecord
  validates :title,           presence: true,
                              length: { maximum: 100 }
  validates :scheduled_at,    presence: true
  validates :location,        length: { maximum: 255 }
  validates :additional_info, length: { maximum: 500 }
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

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

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

  def coordinates
    [latitude, longitude]
  end

  # @return [HashWithIndifferentAccess] contains all accept statuses (`nil` included) as keys
  #   and the number of corresponding responses asthe values
  # @example
  #   event.accept_statuses_summary
  #   # => {
  #          yes: 13,
  #          no:  2,
  #          maybe: 3,
  #          nil => 34
  #        }
  def accept_statuses_summary
    h = HashWithIndifferentAccess.new(nil => 0)
    Guest.accept_statuses.keys.each do |k|
      h[k] = 0
    end

    guests.group(:accept_status).count.each do |accept_status, count|
      h[accept_status] = count
    end

    h
  end

  private

  def respond_before_must_be_before_scheduled_at
    return unless respond_before

    errors.add(:respond_before, :invalid_respond_before) if respond_before > scheduled_at
  end
end
