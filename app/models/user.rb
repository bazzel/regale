class User < ApplicationRecord
  enum role: %i(guest vip admin)
  after_initialize :set_default_role, if: :new_record?

  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: 255 },
    email: true
  validates :name, length: { maximum: 100 }
  validates :role, presence: true

  has_many :guests, dependent: :destroy
  has_many :events, through: :guests

  def anonymous?
    false
  end

  def invalidate_token
    update!(login_token: nil, login_token_valid_until: 1.year.ago)
  end

  def self.valid_with_token(token)
    where(login_token: token)
      .where('login_token_valid_until > ?', Time.now).first
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
