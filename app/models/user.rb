class User < ApplicationRecord
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
end

class NullUser
  def anonymous?
    true
  end

  def id
    nil
  end
end
